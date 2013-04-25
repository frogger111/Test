//
//  Standing.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 25.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Standing.h"

@implementation Standing

@synthesize methodsArray;
@synthesize competitionsArray;

-(id)initWithArrays{
    if (self = [super init]) {
        methodsArray = [[NSMutableArray alloc] init];
        competitionsArray = [[NSMutableArray alloc] init];
    }
    
    return  self;
}

@end
