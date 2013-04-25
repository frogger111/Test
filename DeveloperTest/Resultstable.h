//
//  Ranking.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Resultstable : NSObject{
    NSString *type;
    
    NSMutableArray *rankingArray;
}

@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSMutableArray *rankingArray;

-(id)initWithRankingArray;

@end
