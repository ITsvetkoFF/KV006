//
//  SetPlayingCard.m
//  CardGame
//
//  Created by Anton Kovernik on 13.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "SetCard.h"
#import <UIKit/UIKit.h>

@implementation SetCard

@synthesize color = _color, symbol = _symbol, shading = _shading;

- (NSString *)color
{
    return _color ? _color : @"?";
}

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) _color = color;
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) _symbol = symbol;
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) _shading = shading;
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) _number = number;
}

//- (NSString *)contents
//{
//    return [NSString stringWithFormat:@"%@:%@:%@:%lu", self.symbol, self.color, self.shading, (unsigned long)self.number];
//}

+ (NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols
{
    return @[@"oval", @"squiggle", @"diamond"];
}

+ (NSArray *)validShadings
{
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger)maxNumber
{
    return 3;
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
        [symbols addObject:self.symbol];
        [shadings addObject:self.shading];
        [numbers addObject:@(self.number)];
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SetCard class]]) {
                SetCard *otherSetCard = (SetCard *)otherCard;
                if (![colors containsObject:otherSetCard.color])
                    [colors addObject:otherSetCard.color];
                if (![symbols containsObject:otherSetCard.symbol])
                    [symbols addObject:otherSetCard.symbol];
                if (![shadings containsObject:otherSetCard.shading])
                    [shadings addObject:otherSetCard.shading];
                if (![numbers containsObject:@(otherSetCard.number)])
                    [numbers addObject:@(otherSetCard.number)];
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

- (id)init
{
    self = [super init];
    
    if (self) {
        self.numberOfMatchingCards = 3;
    }
    
    return self;
}

- (NSMutableAttributedString*)contents {
//    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.symbol];
//    for (int i = 1; i < self.number; i++) {
//        [str appendAttributedString:[[NSMutableAttributedString alloc] initWithString:self.symbol]];
//    }
//    UIColor *color;
//    //NSLog(@"%d", [self.color intValue]);
//    if ([self.color intValue] == RedColor) {
//        color = [UIColor redColor];
//    } else if ([self.color intValue] == GreenColor) {
//        color = [UIColor greenColor];
//    } else if ([self.color intValue] == PurpleColor) {
//        color = [UIColor purpleColor];
//    }
//    [str addAttributes:@{ NSForegroundColorAttributeName : color }
//                 range:NSMakeRange( 0, [str length])];
//    
//    if ([self.shading intValue] == OpenShade) {
//        [str addAttributes:@{ NSStrokeWidthAttributeName : @3,
//                              NSStrokeColorAttributeName : color }
//                       range:NSMakeRange( 0, [str length])];
//    } else if ([self.shading intValue] == StripedShade) {
//        [str addAttributes:@{ NSUnderlineStyleAttributeName : [NSNumber numberWithInt:NSUnderlineStyleSingle] }
//                     range:NSMakeRange( 0, [str length])];
//    }
    return nil;
}


@end
