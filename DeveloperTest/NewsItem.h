//
//  News.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enclosure.h"
@interface NewsItem : NSObject{
    NSString *guid;
    NSString *title;
    NSString *pubDate;
    Enclosure *enclosure;
    NSString *description;
    NSString *link;
    NSString *category;
    UIImage *thumb;
    
}

@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) Enclosure *enclosure;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *category;

@property (nonatomic, retain) UIImage *thumb;

@end
