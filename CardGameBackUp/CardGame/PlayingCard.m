//
//  PlayingCard.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSAttributedString*)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:[rankStrings[self.rank] stringByAppendingString:self.suit]];
    return str;
}

@synthesize suit = _suit;

- (NSString*)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}
  

- (int)match:(NSArray *)otherCards {
    int score = 0;
    PlayingCard *card = otherCards[0];
    if (card.rank == self.rank) {
        score = 4;
    } else if ([card.suit isEqualToString:self.suit]) {
        score = 1;
    }
    return score;
}

@end
