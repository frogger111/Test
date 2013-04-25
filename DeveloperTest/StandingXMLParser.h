//
//  StandingXMLParser.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ArrayBlock)(NSArray *);
typedef void (^ErrorBlock)(NSError *);

@class Standing;

@interface StandingXMLParser : NSOperation <NSXMLParserDelegate>
{
@private
    ArrayBlock      completionHandler;
    ErrorBlock      errorHandler;
    
    NSData          *dataToParse;
    
    NSMutableArray  *workingArray;
    Standing       *standing;
    NSMutableString *workingPropertyString;
    NSArray         *elementsToParse;
    BOOL            storingCharacterData;
}

@property (nonatomic, copy) ErrorBlock errorHandler;

- (id)initWithData:(NSData *)data completionHandler:(ArrayBlock)handler;
@end
