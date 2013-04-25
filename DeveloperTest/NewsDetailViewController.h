//
//  NewsDetailViewController.h
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NewsItem;

@interface NewsDetailViewController : UIViewController <UIWebViewDelegate>{
    NewsItem *newsItem;
    UIWebView *webView;
}

@property (nonatomic, retain) NewsItem *newsItem;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

-(IBAction)backSelector:(id)sender;

@end
