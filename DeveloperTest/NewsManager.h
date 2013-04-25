//
//  NewsManager.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThumbDownloader.h"
#import "NewsDownloader.h"
@class NewsItem;
@class ThumbDownloader;
@protocol ThumbsNewsDownloadDelegate;
@protocol NewsDownloadDelegate;


@interface NewsManager : NSObject <ThumbDownloaderDelegate, NewsParserDelegate>{
    
    id<ThumbsNewsDownloadDelegate> delegate;
    id<NewsDownloadDelegate> newsDownloadDelegate;
    NSMutableDictionary *thumbnailTasks;
    NSMutableArray *newsArray;
}

@property (nonatomic, retain) id<ThumbsNewsDownloadDelegate> delegate;
@property (nonatomic, retain) id<NewsDownloadDelegate> newsDownloadDelegate;
@property (nonatomic, retain) NSMutableArray *newsArray;

-(id)initNewsManager;
-(void)startDownloadThumb:(NewsItem *)newsItem forIndexPath:(NSIndexPath *)indexPath;
-(void)startDownloadNews;
@property (nonatomic, retain) NSMutableDictionary *thumbnailTasks;

@end

@protocol ThumbsNewsDownloadDelegate

@required
- (void)rowImage:(UIImage *)image didLoad:(NSIndexPath *)indexPath;

@end

@protocol NewsDownloadDelegate

@required
-(void)reloadNewsTableView;

@end