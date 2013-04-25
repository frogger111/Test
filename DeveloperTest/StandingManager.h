//
//  StandingManager.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 25.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StandingDownloader.h"

@protocol StandingDownloadDelegate;

@interface StandingManager : NSObject <StandingParserDelegate>{
    id<StandingDownloadDelegate> standingDownloadDelegate;
    NSMutableArray *standingArray;
}

@property (nonatomic, retain) id<StandingDownloadDelegate> standingDownloadDelegate;
@property (nonatomic, retain) NSMutableArray *standingArray;

-(id)initStandingManager;
-(void)startDownloadStandings;

-(NSMutableArray *)getMethodArray;
-(NSMutableDictionary *)getPropertyDictionary;
-(NSMutableArray *)getCompetisionArray;
-(NSMutableArray *)getSeasonArray;
-(NSMutableArray *)getRoundArray;
-(NSMutableArray *)getResultableArray;
-(NSMutableArray *)getRankingArray;
-(NSArray *)getSortedRankArrayByRank;
@end

@protocol StandingDownloadDelegate

@required
-(void)reloadStandingTableView;

@end