//
//  EcomapStatsParser.h
//  ecomap
//
//  Created by ohuratc on 09.02.15.
//  Copyright (c) 2015 SoftServe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EcomapURLFetcher.h"

// Titles for "Top Of The Problems" charts

#define ECOMAP_MOST_VOTED_PROBLEMS_CHART_TITLE @"ТОП 10 популярних проблем"
#define ECOMAP_MOST_SEVERE_PROBLEMS_CHART_TITLE @"ТОП 10 важливих проблем"
#define ECOMAP_MOST_COMMENTED_PROBLEMS_CHART_TITLE @"ТОП 10 обговорюваних проблем"

typedef enum {
    EcomapMostVotedProblemsTopList,
    EcomapMostSevereProblemsTopList,
    EcomapMostCommentedProblemsTopList
} EcomapKindfOfTheProblemsTopList;

@interface EcomapStatsParser : NSObject

+ (NSArray *)paticularTopChart:(EcomapKindfOfTheProblemsTopList)kindOfChart from:(NSArray *)topChart;

+ (NSUInteger)integerForNumberLabelForInstanceNumber:(NSUInteger)num inGeneralStatsArray:(NSArray *)generalStats;

+ (NSString *)stringForNameLabelForInstanceNumber:(NSUInteger)number;

+ (NSString *)scoreOfProblem:(NSDictionary *)problem forChartType:(EcomapKindfOfTheProblemsTopList)kindOfChart;

+ (UIImage *)scoreImageOfProblem:(NSDictionary *)problem forChartType:(EcomapKindfOfTheProblemsTopList)kindOfChart;

+ (UIColor *)colorForProblemType:(NSUInteger)problemTypeID;

@end
