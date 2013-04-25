//
//  Method.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "Method.h"

@implementation Method

@synthesize methodId;
@synthesize name;

// parameters

@synthesize parametersArray;
@synthesize parametersDictionary;
-(id)initWithParameters{
    if (self = [super init]) {
        parametersArray = [[NSMutableArray alloc] init];
        parametersDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

@end
