//
//  ScoresCell.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoresCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *teamOneLabel;
@property (nonatomic, strong) IBOutlet UILabel *teamTwoLabel;
@property (nonatomic, strong) IBOutlet UILabel *scoreLabel;
@property (nonatomic, strong) IBOutlet UIView *scoreBackgroundView;

@end
