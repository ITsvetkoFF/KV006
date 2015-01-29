//
//  SetPlayingCard.m
//  CardGame
//
//  Created by Anton Kovernik on 13.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "SetPlayingCard.h"
#import <UIKit/UIKit.h>

@implementation SetPlayingCard

+ (NSArray *)validSuits {
    return @[ @"▲", @"●", @"■" ];
}

+ (NSArray *)validShades {
    return @[ @1, @2, @3 ];
}

+ (NSArray *)validColors {
    return @[ @1, @2, @3 ];
}

+ (NSArray *)rankStrings
{
    return @[ @"?", @"1", @"2", @"3"];
}
@synthesize suit = _suit;

- (NSString*)suit {
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (void)setSuit:(NSString *)suit {
   // NSLog(@"%@", suit);
    if ([[SetPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (id)init
{
    self = [super init];
    
    if (self) {
        self.numberOfMatchingCards = 3;
    }
    
    return self;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == self.numberOfMatchingCards - 1) {
        NSMutableArray *colors = [[NSMutableArray alloc] init];
        NSMutableArray *symbols = [[NSMutableArray alloc] init];
        NSMutableArray *shadings = [[NSMutableArray alloc] init];
        NSMutableArray *numbers = [[NSMutableArray alloc] init];
        [colors addObject:self.color];
        [symbols addObject:self.suit];
        [shadings addObject:self.shade];
        [numbers addObject:@(self.rank)];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetPlayingCard class]]) {
                SetPlayingCard *otherSetCard = (SetPlayingCard *)otherCard;
                if (![colors containsObject:otherSetCard.color])
                    [colors addObject:otherSetCard.color];
                if (![symbols containsObject:otherSetCard.suit])
                    [symbols addObject:otherSetCard.suit];
                if (![shadings containsObject:otherSetCard.shade])
                    [shadings addObject:otherSetCard.shade];
                if (![numbers containsObject:@(otherSetCard.rank)])
                    [numbers addObject:@(otherSetCard.rank)];
                if (([colors count] == 1 || [colors count] == self.numberOfMatchingCards)
                    && ([symbols count] == 1 || [symbols count] == self.numberOfMatchingCards)
                    && ([shadings count] == 1 || [shadings count] == self.numberOfMatchingCards)
                    && ([numbers count] == 1 || [numbers count] == self.numberOfMatchingCards)) {
                    score = 4;
                }
            }
        }
    }
    
    return score;
}


- (NSMutableAttributedString*)contents {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.suit];
    for (int i = 1; i < self.rank; i++) {
        [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:self.suit]];
    }
    UIColor *color;
    //NSLog(@"%d", [self.color intValue]);
    if ([self.color intValue] == RedColor) {
        color = [UIColor redColor];
    } else if ([self.color intValue] == GreenColor) {
        color = [UIColor greenColor];
    } else if ([self.color intValue] == PurpleColor) {
        color = [UIColor purpleColor];
    }
    [str addAttributes:@{ NSForegroundColorAttributeName : color }
                 range:NSMakeRange( 0, [str length])];
    
    if ([self.shade intValue] == OpenShade) {
        [str addAttributes:@{ NSStrokeWidthAttributeName : @3,
                              NSStrokeColorAttributeName : color }
                       range:NSMakeRange( 0, [str length])];
    } else if ([self.shade intValue] == StripedShade) {
        [str addAttributes:@{ NSUnderlineStyleAttributeName : [NSNumber numberWithInt:NSUnderlineStyleSingle] }
                     range:NSMakeRange( 0, [str length])];
    }
    return str;
}


@end
