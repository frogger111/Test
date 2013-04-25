//
//  ScoreXMLParser.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^ArrayBlock)(NSArray *);
typedef void (^ErrorBlock)(NSError *);

@class Score;
@class Method;
@class Parameter;
@class Competition;
@class Season;
@class Round;
@class Group;
@class Match;


@interface ScoreXMLParser : NSOperation <NSXMLParserDelegate>
{
@private
    ArrayBlock      completionHandler;
    ErrorBlock      errorHandler;
    
    NSData          *dataToParse;
    
    NSMutableArray  *workingArray;
    Score *score;
    Method *method;
    Parameter *parameter;
    Competition *competition;
    Season *season;
    Round *round;
    Group *group;
    Match *match;
    
    NSMutableString *workingPropertyString;
    NSArray         *elementsToParse;
    BOOL            storingCharacterData;
}

@property (nonatomic, copy) ErrorBlock errorHandler;

- (id)initWithData:(NSData *)data completionHandler:(ArrayBlock)handler;

@end
