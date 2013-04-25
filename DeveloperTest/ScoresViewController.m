//
//  ScoresViewController.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "ScoresViewController.h"
#import "ScoresCell.h"
#import "AppDelegate.h"
#import "Score.h"
#import "Group.h"
#import "Match.h"

#define defaultRows     1

@interface ScoresViewController ()

@end

@implementation ScoresViewController{
    AppDelegate *appDelegate;
}

@synthesize dropDownButton;
@synthesize scoreTableView;
@synthesize dateLabel;
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
    appDelegate = [[UIApplication sharedApplication] delegate];
    [[appDelegate getDeveloperTestManager] getScoresManager].scoreDownloadDelegate = self;
    NSString *date = [[[[appDelegate getDeveloperTestManager] getScoresManager] getPropertyDictionary] objectForKey:@"date"];
    dateLabel.text = date;
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
    int count = [[[[appDelegate getDeveloperTestManager] getScoresManager] getGroupArray] count];
	
	// if there's no data yet, return enough rows to fill the screen
    if (count == 0)
	{
        return defaultRows;
    }
    return count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     // Return the number of rows in the section.
    int count = [[[[appDelegate getDeveloperTestManager] getScoresManager] getMatchArray] count];
	
	// if there's no data yet, return enough rows to fill the screen
    if (count == 0)
	{
        return defaultRows;
    }
    return count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    Group *group = [[[[appDelegate getDeveloperTestManager] getScoresManager] getGroupArray] objectAtIndex:section];
    return [group name];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // set custom View for header in section
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor grayColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.origin.x+2.0,0.0,tableView.frame.size.width-12.0,18.0)];
    headerLabel.text = [tableView.dataSource tableView:tableView titleForHeaderInSection:section];
    headerLabel.font = [UIFont boldSystemFontOfSize:14.0];
    headerLabel.textAlignment = UITextAlignmentLeft;
    headerLabel.backgroundColor = [UIColor grayColor];
    headerLabel.textColor = [UIColor whiteColor];
    
    [view addSubview:headerLabel];
    
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"ScoresCell";

    if ([[[[appDelegate getDeveloperTestManager] getScoresManager] scoresArray] count] == 0 && indexPath.row == 0){
        ScoresCell *cell = (ScoresCell *)[self.scoreTableView dequeueReusableCellWithIdentifier:identifier];
		cell.teamOneLabel.text = @"Loading…";
        cell.teamTwoLabel.hidden = YES;
        cell.scoreLabel.hidden = YES;
        cell.scoreBackgroundView.hidden = YES;
		return cell;
    }
    
    ScoresCell *cell = (ScoresCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.teamTwoLabel.hidden = NO;
    cell.scoreLabel.hidden = NO;
    cell.scoreBackgroundView.hidden = NO;
    
    Group *groupArray = [[[[appDelegate getDeveloperTestManager] getScoresManager] getGroupArray] objectAtIndex:indexPath.section];
    NSMutableArray *matchesArray = [groupArray matchesArray];

    Match *match = [matchesArray objectAtIndex:indexPath.row];
    cell.teamOneLabel.text = [match teamAName];
    cell.teamTwoLabel.text = [match teamBName];
    
    cell.scoreLabel.text = [NSString stringWithFormat:@"%@-%@", [match fsA], [match fsB]];
    
    // set background for row
    if(indexPath.row % 2 == 0){
        cell.contentView.backgroundColor = [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0f];
    } else {
        cell.contentView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
    }
    
    return cell;
}

// height of the table row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}

// reload scoreTableView
-(void)reloadScoreTableView{
    [self.scoreTableView reloadData];
    NSString *date = [[[[appDelegate getDeveloperTestManager] getScoresManager] getPropertyDictionary] objectForKey:@"date"];
    dateLabel.text = date;
}
@end
