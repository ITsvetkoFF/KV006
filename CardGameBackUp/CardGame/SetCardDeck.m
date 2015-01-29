//
//  SetCardDeck.m
//  CardGame
//
//  Created by Anton Kovernik on 13.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString* suit in [SetPlayingCard validSuits]) {
            for (NSNumber *color in [SetPlayingCard validColors]) {
                for (NSNumber *shade in [SetPlayingCard validShades]) {
                   for (NSUInteger rank = 1; rank <= [SetPlayingCard maxRank]; rank++) {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.rank = rank;
                        card.suit = suit;
                        card.shade = shade;
                        card.color = color;
                        [self addCard:card];
                    }
                }
           }
        }
    }
    NSLog(@"%d", [self.cards count]);
    return self;
}

@end
