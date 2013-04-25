//
//  Match.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Match : NSObject{
    NSString *matchId;
    NSString *dateUtc;
    NSString *timeUtc;
    NSString *dateLondon;
    NSString *timeLondon;
    
    NSString *teamAId;
    NSString *teamAName;
    NSString *teamACountry;
    
    NSString *teamBId;
    NSString *teamBName;
    NSString *teamBCountry;
    
    NSString *status;
    NSString *gameWeek;
    NSString *winner;
    NSString *fsA;
    NSString *fsB;
    NSString *htsA;
    NSString *htsB;
    NSString *etsA;
    NSString *etsB;
    NSString *psA;
    NSString *psB;
    
    NSString *lastUpdated;
}

@property (nonatomic, retain) NSString *matchId;
@property (nonatomic, retain) NSString *dateUtc;
@property (nonatomic, retain) NSString *timeUtc;
@property (nonatomic, retain) NSString *dateLondon;
@property (nonatomic, retain) NSString *timeLondon;

@property (nonatomic, retain) NSString *teamAId;
@property (nonatomic, retain) NSString *teamAName;
@property (nonatomic, retain) NSString *teamACountry;

@property (nonatomic, retain) NSString *teamBId;
@property (nonatomic, retain) NSString *teamBName;
@property (nonatomic, retain) NSString *teamBCountry;

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) NSString *gameWeek;
@property (nonatomic, retain) NSString *winner;
@property (nonatomic, retain) NSString *fsA;
@property (nonatomic, retain) NSString *fsB;
@property (nonatomic, retain) NSString *htsA;
@property (nonatomic, retain) NSString *htsB;
@property (nonatomic, retain) NSString *etsA;
@property (nonatomic, retain) NSString *etsB;
@property (nonatomic, retain) NSString *psA;
@property (nonatomic, retain) NSString *psB;

@property (nonatomic, retain) NSString *lastUpdated;

@end
