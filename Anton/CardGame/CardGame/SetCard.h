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

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

+ (NSArray *)validColors;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSUInteger)maxNumber;

@end
