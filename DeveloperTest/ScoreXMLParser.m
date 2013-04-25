//
//  ScoreXMLParser.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 21.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "ScoreXMLParser.h"
#import "AppDelegate.h"
#import "Score.h"
#import "Method.h"
#import "Parameter.h"
#import "Competition.h"
#import "Season.h"
#import "Round.h"
#import "Group.h"
#import "Match.h"


static NSString *kGsmrs = @"gsmrs";
static NSString *kMethod = @"method";
static NSString *kMethodId = @"method_id";
static NSString *kName = @"name"; //
static NSString *kParameter = @"parameter";
static NSString *kValue = @"value";

static NSString *kCompetition = @"competition";
static NSString *kCompetitionId = @"competition_id";
static NSString *kTeamtype = @"teamtype";
static NSString *kDisplayOrder = @"display_order";
static NSString *kType = @"type"; //
static NSString *kAreaId = @"area_id";
static NSString *kAreaName = @"area_name";
static NSString *kLastUpdated = @"last_updated"; //
static NSString *kSoccerType = @"soccertype";

static NSString *kSeason = @"season";
static NSString *kSeasonId = @"season_id";
static NSString *kStartDate = @"start_date"; //
static NSString *kEndDate = @"end_date"; //
static NSString *kServiceLevel = @"service_level";

static NSString *kRound = @"round";
static NSString *kRoundId = @"roundId";
static NSString *kGroups = @"groups";
static NSString *kHasOutGroupMatches = @"has_outgroup_matches";

static NSString *kGroup = @"group";
static NSString *kGroupId = @"group_id";
static NSString *kDetails = @"details";
static NSString *kWinner = @"winner"; //

static NSString *kMatch = @"match";
static NSString *kMatchId = @"match_id";
static NSString *kDateUtc = @"date_utc";
static NSString *kTimeUtc = @"time_utc";
static NSString *kDateLondon = @"date_london";
static NSString *kTimeLondon = @"time_london";

static NSString *kTeamAId = @"team_A_id";
static NSString *kTeamAName = @"team_A_name";
static NSString *kTeamACountry = @"team_A_country";

static NSString *kTeamBId = @"team_B_id";
static NSString *kTeamBName = @"team_B_name";
static NSString *kTeamBCountry = @"team_B_country";

static NSString *kStatus = @"status";
static NSString *kGameWeek = @"gameweek";
static NSString *kFsA = @"fs_A";
static NSString *kFsB = @"fs_B";
static NSString *kHtsA = @"hts_A";
static NSString *kHtsB = @"hts_B";

static NSString *kEtsA = @"ets_A";
static NSString *kEtsB = @"ets_B";

static NSString *kPsA = @"ps_A";
static NSString *kPsB = @"ps_B";



@interface ScoreXMLParser ()
@property (nonatomic, copy) ArrayBlock completionHandler;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;

@property (nonatomic, retain) Score *score;
@property (nonatomic, strong) Method *method;
@property (nonatomic, strong) Parameter *parameter;
@property (nonatomic, strong) Competition *competition;
@property (nonatomic, strong) Season *season;
@property (nonatomic, strong) Round *round;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) Match *match;

@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;
@end

@implementation ScoreXMLParser

@synthesize completionHandler, errorHandler, dataToParse, workingArray, workingPropertyString, elementsToParse, storingCharacterData;
@synthesize score, method, parameter, competition, season, round, group, match;

- (id)initWithData:(NSData *)data completionHandler:(ArrayBlock)handler
{
    self = [super init];
    if (self != nil)
    {
        self.dataToParse = data;
        self.completionHandler = handler;
        self.elementsToParse = [NSArray arrayWithObjects:kMethod, kMethodId, kName, kParameter, kValue, kCompetition, kCompetitionId, kTeamtype, kDisplayOrder, kType, kAreaId, kAreaName, kLastUpdated, kSoccerType, kSeason, kSeasonId, kStartDate, kEndDate, kServiceLevel, kRound, kRoundId, kGroups, kHasOutGroupMatches, kGroup, kGroupId, kMatch, kMatchId, kDateUtc, kTimeUtc, kDateLondon, kTimeLondon, kTeamAId, kTeamAName, kTeamACountry, kTeamBId, kTeamBName, kTeamBCountry, kStatus, kGameWeek, kFsA, kFsB, kHtsA, kHtsB, kEtsA, kEtsB, kPsA, kPsB,nil];
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
    if([elementName isEqualToString:kGsmrs]) {
        self.score = [[Score alloc] initWithArrays];
	} else if ([elementName isEqualToString:kMethod]){
        self.method = [[Method alloc] initWithParameters];
        self.method.methodId = [attributeDict objectForKey:kMethodId];
        self.method.name = [attributeDict objectForKey:kName];
    } else if ([elementName isEqualToString:kParameter]){
        self.parameter = [[Parameter alloc] init];
        self.parameter.name = [attributeDict objectForKey:kName];
        self.parameter.value = [attributeDict objectForKey:kValue];
    } else if ([elementName isEqualToString:kCompetition]){
        self.competition = [[Competition alloc] initWithSeasons];
        self.competition.competitionId = [attributeDict objectForKey:kCompetitionId];
        self.competition.name = [attributeDict objectForKey:kName];
        self.competition.teamtype = [attributeDict objectForKey:kTeamtype];
        self.competition.displayOrder = [attributeDict objectForKey:kDisplayOrder];
        self.competition.type = [attributeDict objectForKey:kType];
        self.competition.areaId = [attributeDict objectForKey:kAreaId];
        self.competition.areaName = [attributeDict objectForKey:kAreaName];
        self.competition.lastUpdated = [attributeDict objectForKey:kLastUpdated];
        self.competition.soccerType = [attributeDict objectForKey:kSoccerType];
    } else if ([elementName isEqualToString:kSeason]){
        self.season = [[Season alloc] initWithRounds];
        self.season.seasonId = [attributeDict objectForKey:kSeasonId];
        self.season.name = [attributeDict objectForKey:kName];
        self.season.startDate = [attributeDict objectForKey:kStartDate];
        self.season.endDate = [attributeDict objectForKey:kEndDate];
        self.season.serviceLevel = [attributeDict objectForKey:kServiceLevel];
        self.season.lastUpdated = [attributeDict objectForKey:kLastUpdated];
    }else if ([elementName isEqualToString:kRound]){
        self.round = [[Round alloc] initWithGroupsOrResultableArray];
        self.round.roundId = [attributeDict objectForKey:kRoundId];
        self.round.name = [attributeDict objectForKey:kName];
        self.round.startDate = [attributeDict objectForKey:kStartDate];
        self.round.endDate = [attributeDict objectForKey:kEndDate];
        self.round.type = [attributeDict objectForKey:kType];
        self.round.groups = [attributeDict objectForKey:kGroups];
        self.round.hasOutGroupMatches = [attributeDict objectForKey:kHasOutGroupMatches];
        self.round.lastUpdated = [attributeDict objectForKey:kLastUpdated];
    } else if ([elementName isEqualToString:kGroup]){
        self.group = [[Group alloc] initWithMatches];
        self.group.groupId = [attributeDict objectForKey:kGroupId];
        self.group.name = [attributeDict objectForKey:kName];
        self.group.details = [attributeDict objectForKey:kDetails];
        self.group.winner = [attributeDict objectForKey:kWinner];
        self.group.lastUpdated = [attributeDict objectForKey:kLastUpdated];
    } else if ([elementName isEqualToString:kMatch]){
        self.match = [[Match alloc] init];
        self.match.matchId = [attributeDict objectForKey:kMatchId];
        self.match.dateUtc = [attributeDict objectForKey:kDateUtc];
        self.match.timeUtc = [attributeDict objectForKey:kTimeUtc];
        self.match.dateLondon = [attributeDict objectForKey:kDateLondon];
        self.match.dateLondon = [attributeDict objectForKey:kTimeLondon];
        
        self.match.teamAId = [attributeDict objectForKey:kTeamAId];
        self.match.teamAName = [attributeDict objectForKey:kTeamAName];
        self.match.teamACountry = [attributeDict objectForKey:kTeamACountry];
        self.match.teamBId = [attributeDict objectForKey:kTeamBId];
        self.match.teamBName = [attributeDict objectForKey:kTeamBName];
        self.match.teamBCountry = [attributeDict objectForKey:kTeamBCountry];
        
        self.match.status = [attributeDict objectForKey:kStatus];
        self.match.gameWeek = [attributeDict objectForKey:kGameWeek];
        self.match.winner = [attributeDict objectForKey:kWinner];
        
        self.match.fsA = [attributeDict objectForKey:kFsA];
        self.match.fsB = [attributeDict objectForKey:kFsB];
        self.match.htsA = [attributeDict objectForKey:kHtsA];
        self.match.htsB = [attributeDict objectForKey:kHtsB];
        self.match.etsA = [attributeDict objectForKey:kEtsA];
        self.match.etsB = [attributeDict objectForKey:kEtsB];
        self.match.psA = [attributeDict objectForKey:kPsA];
        self.match.psB = [attributeDict objectForKey:kPsB];
        self.match.lastUpdated = [attributeDict objectForKey:kLastUpdated];
        
    }
    
    storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (self.score)
	{
        storingCharacterData = [elementsToParse containsObject:elementName];
        if (storingCharacterData)
        {
//            NSString *trimmedString = [workingPropertyString stringByTrimmingCharactersInSet:
//                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [workingPropertyString setString:@""];  // clear the string for next time
            if ([elementName isEqualToString:kMethod]) {
                [[self.score methodsArray] addObject:self.method];
                self.method = nil;
            } else if ([elementName isEqualToString:kParameter]){
//                [[method parametersArray] addObject:self.parameter];
                [[method parametersDictionary] setValue:[self.parameter value] forKey:[self.parameter name]];
                self.parameter = nil;
            } else if ([elementName isEqualToString:kCompetition]){
                [[self.score competitionsArray] addObject:self.competition];
                self.competition = nil;
            } else if ([elementName isEqualToString:kSeason]){
                [[competition seasonsArray] addObject:self.season];
                self.season = nil;
            } else if ([elementName isEqualToString:kRound]){
                [[self.season roundsArray] addObject:self.round];
                self.round = nil;
            } else if ([elementName isEqualToString:kGroup]){
                [[self.round groupsOrResultableArray] addObject:self.group];
                self.group = nil;
            } else if ([elementName isEqualToString:kMatch]){
                [[self.group matchesArray] addObject:self.match];
                self.match = nil;
            }
        } else if ([elementName isEqualToString:kGsmrs]) {
            [self.workingArray addObject:self.score];
            self.score = nil;
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
