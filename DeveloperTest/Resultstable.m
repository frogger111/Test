//
//  Ranking.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Resultstable.h"

@implementation Resultstable

@synthesize type;
@synthesize rankingArray;

-(id)initWithRankingArray{
    if(self = [super init]) {
        rankingArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
