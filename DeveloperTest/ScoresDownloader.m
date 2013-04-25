//
//  ScoresDownloader.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 24.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "ScoresDownloader.h"
#import "ScoreXMLParser.h"
@implementation ScoresDownloader

@synthesize scoreList;
@synthesize activeDownload;
@synthesize scoreConnection;
@synthesize scoreData;
@synthesize queue;
@synthesize delegate;
- (void)startDownload:(NSMutableArray *)scoreArray
{
//    appDelegate = [[UIApplication sharedApplication] delegate];
    self.scoreList = scoreArray;
    self.activeDownload = [NSMutableData data];
    // alloc+init and start an NSURLConnection; release on completion/failure
    
    NSString *url = @"http://www.mobilefeeds.performgroup.com/utilities/interviews/techtest/scores.xml";
    
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:
                             [NSURLRequest requestWithURL:
                              [NSURL URLWithString:url]] delegate:self];
    self.scoreConnection = conn;
}

- (void)cancelDownload
{
    [self.scoreConnection cancel];
    self.scoreConnection = nil;
    self.activeDownload = nil;
}

#pragma mark -
#pragma mark NSURLConnection delegate methods

// -------------------------------------------------------------------------------
//	handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    NSLog(@"Error: %@", errorMessage);
}

// -------------------------------------------------------------------------------
//	handleLoadedApps:notif
// -------------------------------------------------------------------------------
- (void)handleLoadedApps:(NSArray *)loadedScores
{
    [delegate callReloadScoresArray:(NSMutableArray *)loadedScores];
}

// -------------------------------------------------------------------------------
//	connection:didReceiveResponse:response
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.scoreData = [NSMutableData data];    // start off with new data
}

// -------------------------------------------------------------------------------
//	connection:didReceiveData:data
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [scoreData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//	connection:didFailWithError:error
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    self.scoreConnection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.scoreConnection = nil;   // release our connection
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // create the queue to run our ParseOperation
    self.queue = [[NSOperationQueue alloc] init];
    
    // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
    // "ownership of appListData has been transferred to the parse operation and should no longer be
    // referenced in this thread.
    //
    ScoreXMLParser *parser = [[ScoreXMLParser alloc] initWithData:scoreData
                                              completionHandler:^(NSArray *list) {
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      
                                                      [self handleLoadedApps:list];
                                                      
                                                  });
                                                  
                                                  self.queue = nil;   // we are finished with the queue and our ParseOperation
                                              }];
    
    parser.errorHandler = ^(NSError *parseError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self handleError:parseError];
            
        });
    };
    
    [queue addOperation:parser]; // this will start the "ParseOperation"
    
    
    // ownership of appListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    self.scoreList = nil;
}


@end
