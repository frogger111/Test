//
//  Competition.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Competition : NSObject{
    NSString *competitionId;
    NSString *name;
    NSString *teamtype;
    NSString *displayOrder;
    NSString *type;
    NSString *areaId;
    NSString *areaName;
    NSString *lastUpdated;
    NSString *soccerType;
    
    // seasons
    
    NSMutableArray *seasonsArray;
}

@property(nonatomic, retain) NSString *competitionId;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *teamtype;
@property(nonatomic, retain) NSString *displayOrder;
@property(nonatomic, retain) NSString *type;
@property(nonatomic, retain) NSString *areaId;
@property(nonatomic, retain) NSString *areaName;
@property(nonatomic, retain) NSString *lastUpdated;
@property(nonatomic, retain) NSString *soccerType;

// seasons

@property(nonatomic, retain) NSMutableArray *seasonsArray;

-(id)initWithSeasons;

@end
