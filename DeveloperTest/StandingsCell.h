//
//  StandingsCell.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StandingsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *numberLabel;
@property (nonatomic, strong) IBOutlet UILabel *teamLabel;

@property (nonatomic, strong) IBOutlet UIImageView *rankArrowImageView;
@property (nonatomic, strong) IBOutlet UILabel *pointPLabel;
@property (nonatomic, strong) IBOutlet UILabel *pointRestLabel;
@property (nonatomic, strong) IBOutlet UILabel *pointPtsLabel;

@end
