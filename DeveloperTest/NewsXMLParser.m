//
//  NewsParser.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "NewsXMLParser.h"
#import "NewsItem.h"
#import "Enclosure.h"
#import "AppDelegate.h"
// string contants found in the RSS feed

static NSString *kChannel = @"channel";
static NSString *kItem = @"item";
static NSString *kEnclosure = @"enclosure";
static NSString *kLenght = @"length";
static NSString *kUrl = @"url";
static NSString *kType = @"type";

static NSString *kGuid = @"guid";
static NSString *kTitle = @"title";
static NSString *kPubDate = @"pubDate";
static NSString *kDescription = @"description";
static NSString *kLink = @"link";
static NSString *kCategory = @"category";

@interface NewsXMLParser ()
@property (nonatomic, copy) ArrayBlock completionHandler;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) NewsItem *newsItem;
@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;
@end

@implementation NewsXMLParser

@synthesize completionHandler, errorHandler, dataToParse, workingArray, newsItem, workingPropertyString, elementsToParse, storingCharacterData;

- (id)initWithData:(NSData *)data completionHandler:(ArrayBlock)handler
{
    self = [super init];
    if (self != nil)
    {
        self.dataToParse = data;
        self.completionHandler = handler;
        self.elementsToParse = [NSArray arrayWithObjects:kChannel, kGuid, kTitle, kPubDate, kDescription, kLink, kCategory, nil];
    }
    return self;
}

// -------------------------------------------------------------------------------
//	main:
//  Given data to parse, use NSXMLParser and process all the top paid apps.
// -------------------------------------------------------------------------------
- (void)main
{
	
	self.workingArray = [NSMutableArray array];
    self.workingPropertyString = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not
	// desirable because it gives less control over the network, particularly in responding to
	// connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:dataToParse];
	[parser setDelegate:self];
    [parser parse];
	
	if (![self isCancelled])
    {
        // call our completion handler with the result of our parsing
        self.completionHandler(self.workingArray);
    }
    
    self.workingArray = nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
    
}


#pragma mark -
#pragma mark RSS processing

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:kChannel]) {
        
	} else if([elementName isEqualToString:kItem]) {
        self.newsItem = [[NewsItem alloc] init];
	} else if ([elementName isEqualToString:kEnclosure]){
        Enclosure *enclosure = [[Enclosure alloc] init];
        enclosure.length = [attributeDict objectForKey:kLenght];
        enclosure.url = [attributeDict objectForKey:kUrl];
        enclosure.type = [attributeDict objectForKey:kType];
        newsItem.enclosure = enclosure;
        enclosure = nil;
    }
    
     storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (self.newsItem)
	{
        storingCharacterData = [elementsToParse containsObject:elementName];
        if (storingCharacterData)
        {
            NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [workingPropertyString setString:@""];  // clear the string for next time
            if ([elementName isEqualToString:kGuid]) {
                self.newsItem.guid = trimmedString;
            } else if ([elementName isEqualToString:kTitle]) {
                self.newsItem.title = trimmedString;
            } else if ([elementName isEqualToString:kPubDate]) {
                self.newsItem.pubDate = trimmedString;
            } else if ([elementName isEqualToString:kDescription]) {
                self.newsItem.description = trimmedString;
            } else if ([elementName isEqualToString:kLink]) {
                self.newsItem.link = trimmedString;
            } else if ([elementName isEqualToString:kCategory]) {
                self.newsItem.category = trimmedString;
            }
        } else if ([elementName isEqualToString:kItem]) {
            [self.workingArray addObject:self.newsItem];
            self.newsItem = nil;
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (storingCharacterData)
    {
        [workingPropertyString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    self.errorHandler(parseError);
}

@end
