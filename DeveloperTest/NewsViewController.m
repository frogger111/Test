//
//  NewsViewController.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "NewsViewController.h"
#import "ScoresViewController.h"
#import "StandingsViewController.h"
#import "AppDelegate.h"
#import "NewsCell.h"
#import "NewsItem.h"
#import "ThumbDownloader.h"
#import "NewsDetailViewController.h"

#define defaultRows     1

@interface NewsViewController ()

@end

@implementation NewsViewController{
    AppDelegate *appDelegate;
}

@synthesize dropDownButton;
@synthesize tableView;

const NSString *NewsNotification = @"DropDownMenuNotification";

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    [[appDelegate getDeveloperTestManager] getNewsManager].delegate = self;
    [[appDelegate getDeveloperTestManager] getNewsManager].newsDownloadDelegate = self;
//    [[[appDelegate getDeveloperTestManager] getNewsManager] startDownloadNews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)dropDownSelector:(id)sender{
    
    NSArray * arr = [[NSArray alloc] init];
    arr = [NSArray arrayWithObjects:@"News", @"Scores", @"Standings",nil];
    
    if(dropDownMenu == nil) {
        CGFloat f = 200;
        dropDownMenu = [[DropDownMenu alloc] initDropDown:sender height:&f array:arr direction:@"down"];
        dropDownMenu.delegate = self;
    }
    else {
        [dropDownMenu hideDropDown:sender];
        [self reload];
    }
}

- (void) dropDownDelegateMethod:(DropDownMenu *)sender {
    [self reload];
}

-(void)reload{
    dropDownMenu = nil;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    int count = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] count];
	
	// ff there's no data yet, return enough rows to fill the screen
    if (count == 0)
	{
        return defaultRows;
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"NewsCellidentifier";
    
    if ([[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] count] == 0 && indexPath.row == 0){
        NewsCell *cell = (NewsCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
		cell.titleLabel.text = @"Loading…";
        cell.datetimeLabel.hidden = YES;
        
		return cell;
    }
    
    NewsItem *item = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] objectAtIndex:indexPath.row];
    NewsCell *cell = (NewsCell *)[self.tableView dequeueReusableCellWithIdentifier:identifier];
    cell.contentView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    cell.titleLabel.text = [item title];
    cell.titleLabel.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    [cell.textLabel sizeToFit];
    cell.datetimeLabel.text = [item pubDate];
    [cell.datetimeLabel sizeToFit];
    cell.datetimeLabel.hidden = NO;
    
    if (!item.thumb) {
        if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
            [self startIconDownload:item forIndexPath:indexPath];
        }
        // if a download is deferred or in progress, return a placeholder image
        cell.imageView.image = [UIImage imageNamed:@"placeholder.png"];
    }
    else {
        cell.imageView.image = item.thumb;
    }
    cell.imageView.frame = CGRectMake(0, 0, 58, 58);
    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showNewsDetail"]) {
        [dropDownMenu hideDropDown:sender];
        [self reload];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NewsDetailViewController *ndvc = segue.destinationViewController;
        ndvc.newsItem = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] objectAtIndex:indexPath.row];
    }
}

#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(NewsItem *)newsItem forIndexPath:(NSIndexPath *)indexPath {
    [[[appDelegate getDeveloperTestManager] getNewsManager] startDownloadThumb:newsItem forIndexPath:indexPath];

}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows {
    
    if ([[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] count] > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            NewsItem *newsItem = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] objectAtIndex:indexPath.row];
            
            // avoid the app icon download if the app already has an icon
            if (!newsItem.thumb) {
                [self startIconDownload:newsItem forIndexPath:indexPath];
            }
        }
    }
}

// reload row with thumbnail
-(void)rowImage:(UIImage *)image didLoad:(NSIndexPath *)indexPath{
        NewsCell *cell = (NewsCell *)[self.tableView cellForRowAtIndexPath:indexPath];

        // Display the newly loaded image
        cell.imageView.image = image;
        cell.imageView.frame = CGRectMake(0, 0, 58, 58);
}

-(void)reloadNewsTableView{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int count = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] count];
    if(count > 0){
        if (!decelerate) {
                [self loadImagesForOnscreenRows];
            }
    }
}

// Load images for all onscreen
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int count = [[[[appDelegate getDeveloperTestManager] getNewsManager] newsArray] count];
    if(count > 0){
        [self loadImagesForOnscreenRows];
    } else {
        [[[appDelegate getDeveloperTestManager] getNewsManager] startDownloadNews];
    }
}


@end
