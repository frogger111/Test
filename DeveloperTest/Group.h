//
//  Group.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject{
    NSString *groupId;
    NSString *name;
    NSString *details;
    NSString *winner;
    NSString *lastUpdated;
    NSString *orderMethod;
    NSString *groups;
    // matches
    NSMutableArray *matchesArray;
}

@property (nonatomic, retain) NSString *groupId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *details;
@property (nonatomic, retain) NSString *winner;
@property (nonatomic, retain) NSString *lastUpdated;
@property (nonatomic, retain) NSString *orderMethod;
@property (nonatomic, retain) NSString *groups;

@property (nonatomic, retain) NSMutableArray *matchesArray;


-(id)initWithMatches;

@end
