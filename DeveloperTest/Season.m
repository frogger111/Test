//
//  Season.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Season.h"

@implementation Season

@synthesize seasonId;
@synthesize name;
@synthesize startDate;
@synthesize endDate;
@synthesize serviceLevel;
@synthesize lastUpdated;

// rounds
@synthesize roundsArray;

-(id)initWithRounds{
    if(self = [super init]){
        roundsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}


@end
