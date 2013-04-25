//
//  StandingsViewController.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"
#import "StandingManager.h"

@interface StandingsViewController : UIViewController <DropDownDelegate, UITableViewDataSource, UITableViewDelegate, StandingDownloadDelegate>{
    DropDownMenu *dropDownMenu;
}

@property (nonatomic, retain) IBOutlet UIButton *dropDownButton;
@property (nonatomic, retain) IBOutlet UITableView *standingTableView;
-(IBAction)dropDownSelector:(id)sender;
-(void)reload;
@end
