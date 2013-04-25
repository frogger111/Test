//
//  DeveloperTestManager.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NewsManager;
@class StandingManager;

#import "ScoresManager.h"
//#import "ScoresManager.h"

@interface DeveloperTestManager : NSObject{
    NSMutableArray *newsArray;
    NewsManager *newsManager;
    ScoresManager *scoresManager;
    StandingManager *standingManager;
}


// enum for dropdown menu
typedef enum {
    NEWS,
    SCORES,
    STANDING
} ViewStatus;

@property ViewStatus viewStatus;
@property (nonatomic, strong) NSMutableArray *newsArray;

-(id)initWithOperations;
-(void)beginParty;
-(NewsManager *)getNewsManager;
-(ScoresManager *)getScoresManager;
-(StandingManager *)getStandingManager;
@end
