//
//  NewsDetailViewController.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NewsItem.h"
@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

@synthesize newsItem;
@synthesize webView;
@synthesize backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // rotate button
    backButton.transform = CGAffineTransformMakeRotation(M_PI / 2);
    backButton.frame = CGRectMake(0, 0, 30, 49);
    NSString *urlAddress = [self.newsItem link];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    // load content into webView
    [webView loadRequest:requestObj];
    
}

- (BOOL)webView:(UIWebView *)theWebView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // resize webView 
    theWebView.scalesPageToFit = YES;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)backSelector:(id)sender{
    // back to previous controllerView
    [self.navigationController popViewControllerAnimated:YES];
}

@end
