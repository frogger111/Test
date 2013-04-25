//
//  NewsDownloader.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NewsParserDelegate;

@interface NewsDownloader : NSObject{
    NSMutableData *activeDownload;
    NSURLConnection *newsConnection;
    NSMutableData  *newsData;
    NSOperationQueue *queue;
    NSMutableArray *newsList;
    
    id<NewsParserDelegate> delegate;
}

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *newsConnection;
@property (nonatomic, retain) NSMutableData *newsData;
@property (nonatomic, retain) NSOperationQueue *queue;
@property (nonatomic, retain) NSMutableArray *newsList;
@property (nonatomic, retain) id<NewsParserDelegate> delegate;
- (void)startDownload:(NSMutableArray *)newsArray;

- (void)cancelDownload;

@end

@protocol NewsParserDelegate

@required
- (void)callReloadNewsArray:(NSMutableArray *)array;

@end

