//
//  Card.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (NSUInteger)numberOfMatchingCards
{
    if (!_numberOfMatchingCards) _numberOfMatchingCards = 2;
    return _numberOfMatchingCards;
}

- (int)match:(NSArray *)otherCards {
    int score = 0;
    Card *card = otherCards[0];
    if ([[card.contents string] isEqualToString:[self.contents string]]) {
        score = 1;
    }
    return score;
}




@end
