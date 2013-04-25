//
//  StandingDownloader.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 25.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StandingParserDelegate;

@interface StandingDownloader : NSObject{
    NSMutableData *activeDownload;
    NSURLConnection *standingConnection;
    NSMutableData  *standingData;
    NSOperationQueue *queue;
    NSMutableArray *standingList;
    
    id<StandingParserDelegate> delegate;
}

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *standingConnection;
@property (nonatomic, retain) NSMutableData *standingData;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableArray *standingList;
@property (nonatomic, retain) id<StandingParserDelegate> delegate;

- (void)startDownload:(NSMutableArray *)standingArray;

- (void)cancelDownload;


@end

@protocol StandingParserDelegate

@required
- (void)callReloadStandingArray:(NSMutableArray *)array;

@end