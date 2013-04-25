//
//  Method.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Method : NSObject{
    NSString *methodId;
    NSString *name;
    
    // parameters
    
    NSMutableArray *parametersArray;
    NSMutableDictionary *parametersDictionary;
}

@property (nonatomic, retain) NSString *methodId;
@property (nonatomic, retain) NSString *name;

// parameters

@property (nonatomic, retain) NSMutableArray *parametersArray;
@property (nonatomic, strong) NSMutableDictionary *parametersDictionary;
-(id)initWithParameters;

@end
