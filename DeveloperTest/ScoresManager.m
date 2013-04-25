//
//  ScroresManager.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 22.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "ScoresManager.h"
#import "ScoreXMLParser.h"
#import "Method.h"
#import "Parameter.h"
#import "Competition.h"
#import "Season.h"
#import "Round.h"
#import "Group.h"
#import "Match.h"
#import "Score.h"

@implementation ScoresManager{
    ScoresDownloader *scoresDownloader;
}

@synthesize scoresArray;
@synthesize scoreDownloadDelegate;
@synthesize timer;

-(id)initScoresManager{
    if(self = [super init]){
        self.scoresArray = [[NSMutableArray alloc] init];
        scoresDownloader = [[ScoresDownloader alloc] init];
        scoresDownloader.delegate = self;
    }
    
    return  self;
}

// begin download operations with period
-(void)startDownloadingOperationsWitchPeriod:(NSTimeInterval)period{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:period target:self selector:@selector(startDownloadScores) userInfo:nil repeats:YES];
}

// stop period operations
-(void)stopPeriodOperations{
    if(timer != nil){
        [self.timer invalidate];
    }
}

// begin download
-(void)startDownloadScores{
    [scoresDownloader startDownload:scoresArray];
}

// delegate method set scores array and sending delegate to score controllerView
-(void)callReloadScoresArray:(NSMutableArray *)array{
    scoresArray = array;
    [scoreDownloadDelegate reloadScoreTableView];
}

// return competition array
-(NSMutableArray *)getCompetisionArray{
    if([self.scoresArray count] > 0){
        Score *score = [self.scoresArray objectAtIndex:0];
        return [score competitionsArray];
    }
    return nil;
}

// return season array
-(NSMutableArray *)getSeasonArray{
    if([[self getCompetisionArray] count] > 0){
        Competition *comp = [[self getCompetisionArray] objectAtIndex:0];
        return  [comp seasonsArray];
    }
    return nil;
}

// return round array
-(NSMutableArray *)getRoundArray{
    if([[self getSeasonArray] count] > 0){
        Season *season = [[self getSeasonArray] objectAtIndex:0];
        return [season roundsArray];
    }
    return nil;
}

// return group array
-(NSMutableArray *)getGroupArray{
    if([[self getRoundArray] count] > 0){
        Round *round = [[self getRoundArray] objectAtIndex:0];
        return [round groupsOrResultableArray];
    }
    return nil;
}

// return match array
-(NSMutableArray *)getMatchArray{
    if([[self getGroupArray] count] > 0){
        Group *group = [[self getGroupArray] objectAtIndex:0];
        return [group matchesArray];
    }
    return nil;
}

// return mathod array
-(NSMutableArray *)getMethodArray{
    if([self.scoresArray count] > 0){
        Score *score = [self.scoresArray objectAtIndex:0];
        return [score methodsArray];
    }
    return nil;
}

// return Property dictionary
-(NSMutableDictionary *)getPropertyDictionary{
    if([[self getMethodArray] count] > 0){
        Method *method = [[self getMethodArray] objectAtIndex:0];
        return [method parametersDictionary];
    }
    return nil;
}

@end
