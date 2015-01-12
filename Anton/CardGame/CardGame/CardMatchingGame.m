//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Anton Kovernik on 08.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end

@implementation CardMatchingGame

- (NSMutableArray*)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray*)chosenCards {
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}



-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.matchingString = @"";
        
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)choseCardAtIndexTwo:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.matchingString = [NSString stringWithFormat:@"Card %@ chosen", card.contents];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.matchingString = [NSString stringWithFormat:@"Card %@ closed", card.contents];
        } else {
            // match against another card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:otherCard];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        NSString *tempStr = (matchScore == 1) ? [NSString stringWithFormat:@" by suite you have earned %d points", matchScore * MATCH_BONUS] : [NSString stringWithFormat:@" by rank you have earned %d points", matchScore * MATCH_BONUS];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ matched with card %@ %@", card.contents, otherCard.contents, tempStr];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        self.matchingString = [NSString stringWithFormat:@"Card %@ did not matched with card %@ you've lost %d points", card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (void)choseCardAtIndexThree:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    self.matchingString = [NSString stringWithFormat:@"Card %@ chosen", card.contents];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            [self.chosenCards removeObject:card];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ closed", card.contents];
        } else {
            if ([self.chosenCards count] == 2) {
                card.chosen = YES;
                Card * first = self.chosenCards[0];
                Card * second = self.chosenCards[1];
                int firstMatch = [first match:second];
                int secondMatch = [first match:card];
                int thirdMatch = [second match:card];
                NSLog(@"First: %@", first.contents);
                NSLog(@"Second: %@", second.contents);
                NSLog(@"Third: %@", card.contents);
                if (firstMatch || secondMatch || thirdMatch) {
                    first.matched = YES;
                    second.matched = YES;
                    card.matched = YES;
                    if (firstMatch && secondMatch) {
                        NSString *tempStr = (firstMatch == 1) ? [NSString stringWithFormat:@" by suite you have earned %d points", (firstMatch + secondMatch) * MATCH_BONUS] : [NSString stringWithFormat:@" by rank you have earned %d points", (firstMatch + secondMatch) * MATCH_BONUS];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ matched with card %@ and card %@ %@", first.contents, second.contents, card.contents, tempStr];
                        self.score += (firstMatch + secondMatch) * MATCH_BONUS;
                    } else if (firstMatch) {
                        NSString *tempStr = (firstMatch == 1) ? [NSString stringWithFormat:@" by suite you have earned %d points", (firstMatch) * MATCH_BONUS] : [NSString stringWithFormat:@" by rank you have earned %d points", (firstMatch + secondMatch) * MATCH_BONUS];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ matched with card %@ and card %@ did not match with other cards %@", first.contents, second.contents, card.contents, tempStr];
                        self.score += (firstMatch) * MATCH_BONUS;
                    } else if (secondMatch) {
                        NSString *tempStr = (secondMatch == 1) ? [NSString stringWithFormat:@" by suite you have earned %d points", (secondMatch) * MATCH_BONUS] : [NSString stringWithFormat:@" by rank you have earned %d points", (firstMatch + secondMatch) * MATCH_BONUS];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ matched with card %@ and card %@ did not match with other cards %@", first.contents, card.contents, second.contents, tempStr];
                        self.score += (secondMatch) * MATCH_BONUS;
                    } else if (thirdMatch) {
                        NSString *tempStr = (thirdMatch == 1) ? [NSString stringWithFormat:@" by suite you have earned %d points", (thirdMatch) * MATCH_BONUS] : [NSString stringWithFormat:@" by rank you have earned %d points", (firstMatch + secondMatch) * MATCH_BONUS];
                        self.matchingString = [NSString stringWithFormat:@"Card %@ matched with card %@ and card %@ did not match with other cards %@", second.contents, card.contents, first.contents, tempStr];
                        self.score += (thirdMatch) * MATCH_BONUS;
                    }
                    [self.chosenCards removeAllObjects];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    self.matchingString = [NSString stringWithFormat:@"No one of those cards did match %@ %@ %@ you've lost %d points", card.contents, first.contents, second.contents, MISMATCH_PENALTY];
                    first.chosen = NO;
                    second.chosen = NO;
                    [self.chosenCards removeObject:first];
                    [self.chosenCards removeObject:second];
                    [self.chosenCards addObject:card];
                }
            } else {
                [self.chosenCards addObject:card];
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }

        }
    }
}


- (Card *)cardAtIndex:(NSUInteger)index {
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
