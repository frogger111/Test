//
//  NewsViewController.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownMenu.h"
#import "ThumbDownloader.h"
#import "NewsManager.h"

@interface NewsViewController : UIViewController <DropDownDelegate, UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate,  ThumbsNewsDownloadDelegate, NewsDownloadDelegate>{
    DropDownMenu *dropDownMenu;
}

@property (nonatomic, retain) IBOutlet UIButton *dropDownButton;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
-(IBAction)dropDownSelector:(id)sender;
-(void)reload;


@end
