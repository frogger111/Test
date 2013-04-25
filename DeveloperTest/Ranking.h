//
//  Ranking.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ranking : NSObject{
    NSString *rank;
    NSString *lastRank;
    NSString *zoneStart;
    NSString *teamId;
    NSString *clubName;
    NSString *countryCode;
    NSString *areaId;
    NSString *matchesTotal;
    NSString *matchesWon;
    NSString *matchesDraw;
    NSString *matchesLost;
    NSString *goalsPro;
    NSString *goalsAgainst;
    NSString *points;
}

@property (nonatomic, retain) NSString *rank;
@property (nonatomic, retain) NSString *lastRank;
@property (nonatomic, retain) NSString *zoneStart;
@property (nonatomic, retain) NSString *teamId;
@property (nonatomic, retain) NSString *clubName;
@property (nonatomic, retain) NSString *countryCode;
@property (nonatomic, retain) NSString *areaId;
@property (nonatomic, retain) NSString *matchesTotal;
@property (nonatomic, retain) NSString *matchesWon;
@property (nonatomic, retain) NSString *matchesDraw;
@property (nonatomic, retain) NSString *matchesLost;
@property (nonatomic, retain) NSString *goalsPro;
@property (nonatomic, retain) NSString *goalsAgainst;
@property (nonatomic, retain) NSString *points;

@end
