//
//  StandingsViewController.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "StandingsViewController.h"
#import "StandingsCell.h"
#import "AppDelegate.h"
#import "Score.h"
#import "Ranking.h"


#define defaultRows     1

@interface StandingsViewController ()

@end

@implementation StandingsViewController{
    AppDelegate *appDelegate;
}

@synthesize standingTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // get appdelegate instance
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    // set delegate object
    [[appDelegate getDeveloperTestManager] getStandingManager].standingDownloadDelegate = self;
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
        // height for dropdown menu
        CGFloat f = 200;
        dropDownMenu = [[DropDownMenu alloc] initDropDown:sender height:&f array:arr direction:@"down"];
        
        //set delegate 
        dropDownMenu.delegate = self;
    }
    else {
        // hide dropdown menu
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
    // return number of section in rows
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of sections.
    int count = [[[[appDelegate getDeveloperTestManager] getStandingManager] getSortedRankArrayByRank] count];
	
	// ff there's no data yet, return enough rows to fill the screen
    if (count == 0)
	{
        return defaultRows;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"StandingCell";
    
    // if rank array is empty display loading text
    if ([[[[appDelegate getDeveloperTestManager] getStandingManager] getSortedRankArrayByRank] count] == 0 && indexPath.row == 0){
        StandingsCell *cell = (StandingsCell *)[self.standingTableView dequeueReusableCellWithIdentifier:identifier];
		cell.teamLabel.text = @"Loading…";
        cell.numberLabel.hidden = YES;
        cell.pointPLabel.hidden = YES;
        cell.pointRestLabel.hidden = YES;
        cell.pointPtsLabel.hidden = YES;
        cell.rankArrowImageView.hidden = YES;
		return cell;
    }
    
    StandingsCell *cell = (StandingsCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    // get ranking element from rankingarray of index.row
    Ranking *ranking = [[[[appDelegate getDeveloperTestManager] getStandingManager] getSortedRankArrayByRank] objectAtIndex:indexPath.row];
    
    // set text for label
    cell.teamLabel.text = [ranking clubName];
    
    if(indexPath.row < 9){
        cell.numberLabel.text = [NSString stringWithFormat:@"0%d", indexPath.row + 1];
    } else {
        cell.numberLabel.text = [NSString stringWithFormat:@"%d", indexPath.row + 1];
    }
    
    cell.rankArrowImageView.hidden = NO;
    
    // set image if team is on the higher position then before in ranking table
    if([[ranking lastRank] integerValue] > [[ranking rank] integerValue]){
        UIImage *image = [UIImage imageNamed:@"arrowDown.png"];
        cell.rankArrowImageView.image = image;
    } else if ([[ranking lastRank] integerValue] == [[ranking rank] integerValue]){
        //if position didn't change, then hide imageView
        cell.rankArrowImageView.hidden = YES;
    }
    // set text for label
    cell.pointPLabel.text = [ranking matchesTotal];
    cell.pointRestLabel.text = [NSString stringWithFormat:@"%@   %@   %@   %@", [ranking matchesWon], [ranking matchesDraw], [ranking matchesLost], [ranking goalsPro]];
    cell.pointPtsLabel.text = [ranking points];
    
    // show hidden labels
    cell.numberLabel.hidden = NO;
    cell.pointPLabel.hidden = NO;
    cell.pointRestLabel.hidden = NO;
    cell.pointPtsLabel.hidden = NO;
    
    return cell;
}

// height of the table row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

// reload tableView id data loaded
-(void)reloadStandingTableView{
    [self.standingTableView reloadData];
}

@end
