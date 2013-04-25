//
//  Parameter.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parameter : NSObject{
    NSString *name;
    NSString *value;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *value;

@end
