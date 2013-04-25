//
//  Competition.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Competition.h"

@implementation Competition

@synthesize competitionId;
@synthesize name;
@synthesize teamtype;
@synthesize displayOrder;
@synthesize type;
@synthesize areaId;
@synthesize areaName;
@synthesize lastUpdated;
@synthesize soccerType;

// seasons

@synthesize seasonsArray;

-(id)initWithSeasons{
    if (self = [super init]) {
        seasonsArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
