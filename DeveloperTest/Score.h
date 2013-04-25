//
//  Scores.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject{
    //methods
    NSMutableArray *methodsArray;
    
    //competitions
    NSMutableArray *competitionsArray;
}

@property (nonatomic, retain) NSMutableArray *methodsArray;
@property (nonatomic, retain) NSMutableArray *competitionsArray;

-(id)initWithArrays;

@end
