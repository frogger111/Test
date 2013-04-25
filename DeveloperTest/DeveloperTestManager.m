//
//  DeveloperTestManager.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "DeveloperTestManager.h"
#import "NewsManager.h"
//#import "ScoresManager.h"
#import "StandingManager.h"
@implementation DeveloperTestManager{
    ViewStatus viewStatus;
}

@synthesize newsArray;
@synthesize viewStatus;

-(id)initWithOperations{
    if(self  = [super init]){
        newsArray = [[NSMutableArray alloc] init];
        newsManager = [[NewsManager alloc] initNewsManager];
        scoresManager = [[ScoresManager alloc] initScoresManager];
        standingManager = [[StandingManager alloc] initStandingManager];
        viewStatus = NEWS;
    }
    return self;
}

// begin all party :)
-(void) beginParty{
    [newsManager startDownloadNews];
    [scoresManager startDownloadScores];
    [standingManager startDownloadStandings];
}

// return newsManager
-(NewsManager *)getNewsManager{
    return newsManager;
}

// return scoresManager
-(ScoresManager *)getScoresManager{
    return scoresManager;
}

// return newsstandingManager
-(StandingManager *)getStandingManager{
    return standingManager;
}
@end
