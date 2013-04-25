//
//  Standing.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 25.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Standing : NSObject{
    NSMutableArray *methodsArray;
    NSMutableArray *competitionsArray;
}

@property (nonatomic, strong) NSMutableArray *methodsArray;
@property (nonatomic, strong) NSMutableArray *competitionsArray;

-(id)initWithArrays;
@end
