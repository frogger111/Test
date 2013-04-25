//
//  StandingManager.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 25.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "StandingManager.h"
#import "StandingXMLParser.h"
#import "Method.h"
#import "Parameter.h"
#import "Competition.h"
#import "Season.h"
#import "Round.h"
#import "Group.h"
#import "Resultstable.h"
#import "Ranking.h"
#import "Standing.h"

@implementation StandingManager{
    StandingDownloader *standingDownloader;
}

@synthesize standingArray;
@synthesize standingDownloadDelegate;


-(id)initStandingManager{
    if(self = [super init]){
        self.standingArray = [[NSMutableArray alloc] init];
        standingDownloader = [[StandingDownloader alloc] init];
        standingDownloader.delegate = self;
    }
    
    return  self;
}

// begin download
-(void)startDownloadStandings{
    [standingDownloader startDownload:standingArray];
}

// delegate method set standing array and sending delegate to standing controllerView
-(void)callReloadStandingArray:(NSMutableArray *)array{
    standingArray = array;
    [standingDownloadDelegate reloadStandingTableView];
}

// return competition array
-(NSMutableArray *)getCompetisionArray{
    if([self.standingArray count] > 0){
        Standing *standing = [self.standingArray objectAtIndex:0];
        return [standing competitionsArray];
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

// return Round array
-(NSMutableArray *)getRoundArray{
    if([[self getSeasonArray] count] > 0){
        Season *season = [[self getSeasonArray] objectAtIndex:0];
        return [season roundsArray];
    }
    return nil;
}
// return resultable array
-(NSMutableArray *)getResultableArray{
    if([[self getRoundArray] count] > 0){
        Round *round = [[self getRoundArray] objectAtIndex:0];
        return [round groupsOrResultableArray];
    }
    return nil;
}
// return ranking array
-(NSMutableArray *)getRankingArray{
    if([[self getResultableArray] count] > 0){
        Resultstable *resultable = [[self getResultableArray] objectAtIndex:0];
        return [resultable rankingArray];
    }
    return nil;
}

// return mathod array
-(NSMutableArray *)getMethodArray{
    if([self.standingArray count] > 0){
        Standing *standing = [self.standingArray objectAtIndex:0];
        return [standing methodsArray];
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


// sort rankingarraby by rank
-(NSArray *)getSortedRankArrayByRank{
    NSArray *sorted = [[self getRankingArray] sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 isKindOfClass:[Ranking class]] && [obj2 isKindOfClass:[Ranking class]]) {
            Ranking *r1 = obj1;
            Ranking *r2 = obj2;
            
            if ([r1.rank integerValue] < [r2.rank integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if ([r1.rank integerValue] > [r2.rank integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    return sorted;
}

@end

