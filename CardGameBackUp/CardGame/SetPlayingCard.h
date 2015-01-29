//
//  SetPlayingCard.h
//  CardGame
//
//  Created by Anton Kovernik on 13.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "PlayingCard.h"

typedef NS_ENUM(NSUInteger, CardShade) {
    SolidShade = 1,
    OpenShade = 2,
    StripedShade = 3
};

typedef NS_ENUM(NSUInteger, CardColors) {
    RedColor = 1,
    GreenColor = 2,
    PurpleColor = 3
};

@interface SetPlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) NSNumber* shade;
@property (nonatomic) NSNumber* color;


+ (NSArray *)validSuits;
+ (NSArray *)validShades;
+ (NSArray *)validColors;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end
