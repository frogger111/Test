//
//  DropDownMenu.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "DropDownMenu.h"
#import "QuartzCore/QuartzCore.h"
#import "ScoresViewController.h"
#import "StandingsViewController.h"
#import "NewsViewController.h"


@interface DropDownMenu ()
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) UIButton *btnSender;
@property(nonatomic, retain) NSArray *list;
@end

@implementation DropDownMenu
@synthesize table;
@synthesize btnSender;
@synthesize list;
@synthesize delegate;
@synthesize animationDirection;

- (id)initDropDown:(UIButton *)button height:(CGFloat *)height array:(NSArray *)array direction:(NSString *)direction{
    appDelegate = [[UIApplication sharedApplication] delegate];
    btnSender = button;
    animationDirection = direction;
    if(self = [super init]){
        
        // Initialization code
        screenRect = [[UIScreen mainScreen] bounds];
        screenWidth = screenRect.size.width;
        
        CGRect btn = button.frame;
        self.list = [NSArray arrayWithArray:array];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(0, btn.origin.y, screenWidth, 0);
        }else if ([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(0, btn.origin.y+btn.size.height, screenWidth, 0);
        }
        
        self.layer.masksToBounds = NO;
        self.layer.shadowRadius = 5;
        
        table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,screenWidth, 0)];
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = [UIColor colorWithRed:0 green:80.0f/255.0f blue:118.0f/255.0f alpha:1];
        table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        table.separatorColor = [UIColor grayColor];
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        if ([direction isEqualToString:@"up"]) {
            self.frame = CGRectMake(0, btn.origin.y-*height, screenWidth, 120);
        } else if([direction isEqualToString:@"down"]) {
            self.frame = CGRectMake(0, btn.origin.y+btn.size.height, screenWidth, 120);
        }
        table.frame = CGRectMake(0, 0, screenWidth, 120);
        [UIView commitAnimations];
        [button.superview addSubview:self];
        [self addSubview:table];
    }
    return self;
}

-(void)hideDropDown:(UIButton *)button {
    CGRect btn = button.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    if ([animationDirection isEqualToString:@"up"]) {
        self.frame = CGRectMake(0, btn.origin.y, screenWidth, 0);
    }else if ([animationDirection isEqualToString:@"down"]) {
        self.frame = CGRectMake(0, btn.origin.y+btn.size.height, screenWidth, 0);
    } 
    table.frame = CGRectMake(0, 0, screenWidth, 0);
    [UIView commitAnimations];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text =[list objectAtIndex:indexPath.row];
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.04f alpha:1.0f];
    cell.selectedBackgroundView = v;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:btnSender];
    NSString *log = [NSString stringWithFormat:@"%@", [self.list objectAtIndex:indexPath.row]];
    NSLog(@"%@", log);

    UIStoryboard *st = [UIStoryboard storyboardWithName:[[NSBundle mainBundle].infoDictionary objectForKey:@"UIMainStoryboardFile"] bundle:[NSBundle mainBundle]];
    UINavigationController *navController = (UINavigationController *)[[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    
    if([log isEqualToString:@"Scores"]){
        if([[appDelegate getDeveloperTestManager] viewStatus] != SCORES){
            [appDelegate getDeveloperTestManager].viewStatus = SCORES;
            ScoresViewController *svc = [st instantiateViewControllerWithIdentifier:@"ScoresView"];
            [navController pushViewController:svc animated:YES];
            
        }
    } else if ([log isEqualToString:@"Standings"]){
        if([[appDelegate getDeveloperTestManager] viewStatus] != STANDING){
            [appDelegate getDeveloperTestManager].viewStatus = STANDING;
            StandingsViewController *svc = [st instantiateViewControllerWithIdentifier:@"StandingsView"];
            [navController pushViewController:svc animated:YES];
        }
    } else {
        if([[appDelegate getDeveloperTestManager] viewStatus] != NEWS){
            [appDelegate getDeveloperTestManager].viewStatus = NEWS;
            NewsViewController *svc = [st instantiateViewControllerWithIdentifier:@"NewsView"];
            [navController pushViewController:svc animated:YES];
        }
    }
    
    [self myDelegate];
}

- (void) myDelegate {
    [self.delegate dropDownDelegateMethod:self];
}

@end

