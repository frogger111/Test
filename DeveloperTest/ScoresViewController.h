//
//  ScoresViewController.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"
#import "ScoresDownloader.h"

@interface ScoresViewController : UIViewController <DropDownDelegate, UITableViewDataSource, UITableViewDelegate, ScoreDownloadDelegate>{
    DropDownMenu *dropDownMenu;
}


@property (nonatomic, retain) IBOutlet UIButton *dropDownButton;
@property (nonatomic, retain) IBOutlet UITableView *scoreTableView;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;

-(IBAction)dropDownSelector:(id)sender;
-(void)reload;

@end
