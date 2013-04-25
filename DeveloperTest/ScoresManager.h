//
//  ScroresManager.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 22.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoresDownloader.h"

@protocol ScoreDownloadDelegate;

@interface ScoresManager : NSObject <ScoreParserDelegate>{
    id<ScoreDownloadDelegate> scoreDownloadDelegate;
    NSMutableArray *scoresArray;
}

@property (nonatomic, retain) id<ScoreDownloadDelegate> scoreDownloadDelegate;
@property (nonatomic, retain) NSMutableArray *scoresArray;
@property (nonatomic, strong) NSTimer *timer;

-(id)initScoresManager;
-(void)startDownloadScores;
-(void)startDownloadingOperationsWitchPeriod:(NSTimeInterval)period;
-(void)stopPeriodOperations;
-(NSMutableArray *)getMethodArray;
-(NSMutableDictionary *)getPropertyDictionary;
-(NSMutableArray *)getCompetisionArray;
-(NSMutableArray *)getSeasonArray;
-(NSMutableArray *)getRoundArray;
-(NSMutableArray *)getGroupArray;
-(NSMutableArray *)getMatchArray;
@end

@protocol ScoreDownloadDelegate

@required
-(void)reloadScoreTableView;

@end