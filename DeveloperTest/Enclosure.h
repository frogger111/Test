//
//  Enclosure.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enclosure : NSObject{
    NSString *length;
    NSString *url;
    NSString *type;
}

@property (nonatomic, retain) NSString *length;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *type;


@end
