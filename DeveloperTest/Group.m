//
//  Group.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize groupId;
@synthesize name;
@synthesize details;
@synthesize winner;
@synthesize lastUpdated;
@synthesize orderMethod;
@synthesize groups;
// matches
@synthesize matchesArray;

-(id)initWithMatches{
    if(self = [super init]){
        matchesArray = [[NSMutableArray alloc] init];
    }
    
    return  self;
}

@end
