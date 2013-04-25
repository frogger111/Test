//
//  ThumbDownloader.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsItem;
@class NewsViewController;

@protocol ThumbDownloaderDelegate;

@interface ThumbDownloader : NSObject{
    NewsItem *newsItem;
    NSIndexPath *indexPathInTableView;
    id <ThumbDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property (nonatomic, retain) NewsItem *newsItem;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, retain) id <ThumbDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;

@end

@protocol ThumbDownloaderDelegate

@required
- (void)thumbsDidLoad:(NSIndexPath *)indexPath;



@end
