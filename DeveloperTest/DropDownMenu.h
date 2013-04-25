//
//  DropDownMenu.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 20.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class DropDownMenu;
@protocol DropDownDelegate
- (void) dropDownDelegateMethod: (DropDownMenu *) sender;
@end

@interface DropDownMenu : UIView <UITableViewDelegate, UITableViewDataSource> {
    NSString *animationDirection;
    UIImageView *imgView;
    CGRect screenRect;
    CGFloat screenWidth;
    AppDelegate *appDelegate;
}
@property (nonatomic, retain) id <DropDownDelegate> delegate;
@property (nonatomic, retain) NSString *animationDirection;
-(void)hideDropDown:(UIButton *)button;
- (id)initDropDown:(UIButton *)button height:(CGFloat *)height array:(NSArray *)array direction :(NSString *)direction;

@end

