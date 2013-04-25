//
//  Round.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Round.h"

@implementation Round

@synthesize roundId;
@synthesize name;
@synthesize startDate;
@synthesize endDate;
@synthesize type;
@synthesize groups;
@synthesize hasOutGroupMatches;
@synthesize lastUpdated;

// groups

@synthesize groupsOrResultableArray;

-(id)initWithGroupsOrResultableArray{
    if(self = [super init]) {
        groupsOrResultableArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
