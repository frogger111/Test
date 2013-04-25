//
//  Round.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Round : NSObject{
    NSString *roundId;
    NSString *name;
    NSString *startDate;
    NSString *endDate;
    NSString *type;
    NSString *groups;
    NSString *hasOutGroupMatches;
    NSString *lastUpdated;
    
    // groups
    
    NSMutableArray *groupsOrResultableArray;
}

@property (nonatomic, retain) NSString *roundId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSString *endDate;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *groups;
@property (nonatomic, retain) NSString *hasOutGroupMatches;
@property (nonatomic, retain) NSString *lastUpdated;

// rounds

@property (nonatomic, retain) NSMutableArray *groupsOrResultableArray;

-(id)initWithGroupsOrResultableArray;

@end
