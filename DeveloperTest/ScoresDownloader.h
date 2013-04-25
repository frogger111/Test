//
//  ScoresDownloader.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 24.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScoreParserDelegate;

@interface ScoresDownloader : NSObject {
    NSMutableData *activeDownload;
    NSURLConnection *scoreConnection;
    NSMutableData  *scoreData;
    NSOperationQueue *queue;
    NSMutableArray *scoreList;

    id<ScoreParserDelegate> delegate;
}

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *scoreConnection;
@property (nonatomic, retain) NSMutableData *scoreData;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableArray *scoreList;
@property (nonatomic, retain) id<ScoreParserDelegate> delegate;
- (void)startDownload:(NSMutableArray *)scoreArray;

- (void)cancelDownload;

@end

@protocol ScoreParserDelegate

@required
- (void)callReloadScoresArray:(NSMutableArray *)array;

@end
