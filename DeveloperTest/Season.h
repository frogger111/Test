//
//  Season.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Season : NSObject{
    NSString *seasonId;
    NSString *name;
    NSString *startDate;
    NSString *endDate;
    NSString *serviceLevel;
    NSString *lastUpdated;
    
    // rounds
    NSMutableArray *roundsArray;
}

@property (nonatomic, retain) NSString *seasonId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, retain) NSString *serviceLevel;
@property (nonatomic, retain) NSString *lastUpdated;

// rounds
@property (nonatomic, retain) NSMutableArray *roundsArray;

-(id)initWithRounds;

@end
