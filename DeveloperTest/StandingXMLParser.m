//
//  StandingXMLParser.m
//  DeveloperTest
//
//  Created by Tobiasz Parys on 23.04.2013.
//  Copyright (c) 2013 PerformGroup. All rights reserved.
//

#import "StandingXMLParser.h"
#import "Standing.h"
#import "Method.h"
#import "Parameter.h"
#import "Competition.h"
#import "Season.h"
#import "Round.h"
#import "Group.h"
#import "Match.h"
#import "Resultstable.h"
#import "Ranking.h"
static NSString *kGsmrs = @"gsmrs";

static NSString *kMethod = @"method";
static NSString *kMethodId = @"method_id";

static NSString *kParameter = @"parameter";
static NSString *kName = @"name"; //
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
static NSString *kLastPlayedmatchDate = @"last_playedmatch_date";

static NSString *kRound = @"round";
static NSString *kRoundId = @"roundId";
static NSString *kOrderMethod = @"ordermethod";
static NSString *kGroups = @"groups";
static NSString *kHasOutGroupMatches = @"has_outgroup_matches";

static NSString *kResultstable = @"resultstable";

static NSString *kRanking = @"ranking";
static NSString *kRank = @"rank";
static NSString *kLastRank = @"last_rank";
static NSString *kZoneStart = @"zone_start";
static NSString *kTeamId = @"team_id";
static NSString *kClubName = @"club_name";
static NSString *kCountryCode = @"countrycode";
static NSString *kMatchesTotal = @"matches_total";
static NSString *kMatchesWon = @"matches_won";
static NSString *kMatchesDraw = @"matches_draw";
static NSString *kMatchesLost = @"matches_lost";
static NSString *kGoalsProg = @"goals_pro";
static NSString *kGoalsAgainst = @"goals_against";
static NSString *kPoints = @"points";

@interface StandingXMLParser ()
@property (nonatomic, copy) ArrayBlock completionHandler;
@property (nonatomic, retain) NSData *dataToParse;
@property (nonatomic, retain) NSMutableArray *workingArray;
@property (nonatomic, retain) Standing *standing;
@property (nonatomic, retain) NSMutableString *workingPropertyString;
@property (nonatomic, retain) NSArray *elementsToParse;
@property (nonatomic, assign) BOOL storingCharacterData;

@property (nonatomic, strong) Method *method;
@property (nonatomic, strong) Parameter *parameter;
@property (nonatomic, strong) Competition *competition;
@property (nonatomic, strong) Season *season;
@property (nonatomic, strong) Round *round;
@property (nonatomic, strong) Group *group;
@property (nonatomic, strong) Resultstable *resultable;
@property (nonatomic, strong) Ranking *ranking;

@end

@implementation StandingXMLParser

@synthesize completionHandler, errorHandler, dataToParse, workingArray, standing, workingPropertyString, elementsToParse, storingCharacterData;
@synthesize  method, parameter, competition, season, round, resultable, ranking;
- (id)initWithData:(NSData *)data completionHandler:(ArrayBlock)handler
{
    self = [super init];
    if (self != nil)
    {
        self.dataToParse = data;
        self.completionHandler = handler;
        self.elementsToParse = [NSArray arrayWithObjects: kMethod, kMethodId, kName, kParameter, kValue, kCompetition, kCompetitionId, kTeamtype, kDisplayOrder, kType, kAreaId, kAreaName, kLastUpdated, kSoccerType, kSeason, kSeasonId, kStartDate, kEndDate, kServiceLevel,kLastPlayedmatchDate, kRound, kRoundId,kOrderMethod, kGroups, kHasOutGroupMatches,kResultstable, kRanking, kRank,kLastRank, kZoneStart, kTeamId, kClubName, kCountryCode, kMatchesTotal, kMatchesWon, kMatchesDraw, kMatchesLost, kGoalsProg, kGoalsAgainst, kPoints, nil];
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
        self.standing = [[Standing alloc] initWithArrays];
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
    } else if ([elementName isEqualToString:kRound]){
        self.round = [[Round alloc] initWithGroupsOrResultableArray];
        self.round.roundId = [attributeDict objectForKey:kRoundId];
        self.round.name = [attributeDict objectForKey:kName];
        self.round.startDate = [attributeDict objectForKey:kStartDate];
        self.round.endDate = [attributeDict objectForKey:kEndDate];
        self.round.type = [attributeDict objectForKey:kType];
        self.round.groups = [attributeDict objectForKey:kGroups];
        self.round.hasOutGroupMatches = [attributeDict objectForKey:kHasOutGroupMatches];
        self.round.lastUpdated = [attributeDict objectForKey:kLastUpdated];
    } else if ([elementName isEqualToString:kResultstable]){
        self.resultable = [[Resultstable alloc] initWithRankingArray];
        self.resultable.type = [attributeDict objectForKey:kType];
    } else if ([elementName isEqualToString:kRanking]){
        self.ranking = [[Ranking alloc] init];
        self.ranking.rank = [attributeDict objectForKey:kRank];
        self.ranking.lastRank = [attributeDict objectForKey:kLastRank];
        self.ranking.zoneStart = [attributeDict objectForKey:kZoneStart];
        self.ranking.teamId = [attributeDict objectForKey:kTeamId];
        self.ranking.clubName = [attributeDict objectForKey:kClubName];
        self.ranking.countryCode = [attributeDict objectForKey:kCountryCode];
        self.ranking.areaId = [attributeDict objectForKey:kAreaId];
        self.ranking.matchesTotal = [attributeDict objectForKey:kMatchesTotal];
        self.ranking.matchesWon = [attributeDict objectForKey:kMatchesWon];
        self.ranking.matchesDraw = [attributeDict objectForKey:kMatchesDraw];
        self.ranking.matchesLost = [attributeDict objectForKey:kMatchesLost];
        self.ranking.goalsPro = [attributeDict objectForKey:kGoalsProg];
        self.ranking.goalsAgainst = [attributeDict objectForKey:kGoalsAgainst];
        self.ranking.points = [attributeDict objectForKey:kPoints];
        
    }
    
    storingCharacterData = [elementsToParse containsObject:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    if (self.standing)
	{
        storingCharacterData = [elementsToParse containsObject:elementName];
        if (storingCharacterData)
        {
            
            [workingPropertyString setString:@""];  // clear the string for next time
            if ([elementName isEqualToString:kMethod]) {
                [[self.standing methodsArray] addObject:method];
                self.method = nil;
            } else if ([elementName isEqualToString:kParameter]){
                [[method parametersDictionary] setValue:[self.parameter value] forKey:[self.parameter name]];
            } else if ([elementName isEqualToString:kCompetition]){
                [[self.standing competitionsArray] addObject:self.competition];
                self.competition = nil;
            } else if ([elementName isEqualToString:kSeason]){
                [[competition seasonsArray] addObject:self.season];
                self.season = nil;
            } else if ([elementName isEqualToString:kRound]){
                [[self.season roundsArray] addObject:self.round];
                self.round = nil;
            } else if ([elementName isEqualToString:kResultstable]){
                [[self.round groupsOrResultableArray] addObject:self.resultable];
                self.resultable = nil;
            } else if ([elementName isEqualToString:kRanking]){
                [[self.resultable rankingArray] addObject:self.ranking];
                self.ranking = nil;
            }
            
        } else if ([elementName isEqualToString:kGsmrs]) {
            [self.workingArray addObject:self.standing];
            self.standing = nil;
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
