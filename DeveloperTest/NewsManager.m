//
//  NewsManager.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "NewsManager.h"
#import "NewsItem.h"
#import "ThumbDownloader.h"
#import "NewsDownloader.h"
@implementation NewsManager{
    NewsDownloader *newsDownloader;
}

@synthesize delegate;
@synthesize newsDownloadDelegate;
@synthesize thumbnailTasks;
@synthesize newsArray;

-(id)initNewsManager{
    
    if (self = [super init]) {
        self.thumbnailTasks = [[NSMutableDictionary alloc] init];
        self.newsArray = [[NSMutableArray alloc] init];
        newsDownloader = [[NewsDownloader alloc] init];
        newsDownloader.delegate = self;
    }
    
    return self;
}

// begin download
-(void)startDownloadNews{
    
    [newsDownloader startDownload:newsArray];
}

// begin thumbnails download
-(void)startDownloadThumb:(NewsItem *)newsItem forIndexPath:(NSIndexPath *)indexPath{
    
    ThumbDownloader *iconDownloader = [self.thumbnailTasks objectForKey:indexPath];
    if (iconDownloader == nil){
        iconDownloader = [[ThumbDownloader alloc] init];
        iconDownloader.newsItem = newsItem;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [self.thumbnailTasks setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
    }
}

// 
-(void)thumbsDidLoad:(NSIndexPath *)indexPath{
    ThumbDownloader *iconDownloader = [self.thumbnailTasks objectForKey:indexPath];
    if (iconDownloader != nil){
        [delegate rowImage:iconDownloader.newsItem.thumb didLoad:iconDownloader.indexPathInTableView];
    }
    
    // Remove the IconDownloader from the in progress list.
    [self.thumbnailTasks removeObjectForKey:indexPath];
    
}

-(void)callReloadNewsArray:(NSMutableArray *)array{
    newsArray = array;
    [newsDownloadDelegate reloadNewsTableView];
}


@end
