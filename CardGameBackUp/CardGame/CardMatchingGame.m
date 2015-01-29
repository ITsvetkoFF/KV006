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
        _cardsToMatch = [[NSMutableArray alloc] init];
        _movesHistory = [[NSMutableArray alloc] init];
        self.mode = 2;
    }
    return self;
}


- (NSMutableArray*)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray*)chosenCards {
    if (!_chosenCards) _chosenCards = [[NSMutableArray alloc] init];
    return _chosenCards;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)choseCardAtIndex:(NSUInteger)index {
    History * move2 = [[History alloc] init];
    History * move = [[History alloc] init];
    Card *card = [self cardAtIndex:index];
    move2.cardOne = card;
    move2.chosen = true;
    [_movesHistory addObject:move2];
    if (!card.isMatched) {
        if (card.isChosen) {
            move.cardOne = card;
            move.chosen = false;
            [_movesHistory addObject:move];
            card.chosen = NO;
            [_cardsToMatch removeObject:card];
        } else {
            // match against another card
            if (self.mode == 2) {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        move.cardOne = card;
                        move.cardTwo = otherCard;
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                            move.matched = true;

                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            move.matched = false;
                        }
                        [_movesHistory addObject:move];
                        break;
                    }
                }
            } else if (self.mode == 3) {
                if ([_cardsToMatch count] < 2) {
                    [_cardsToMatch addObject:card];
                } else if ([_cardsToMatch count] == 2){
                    move.cardOne = _cardsToMatch[0];
                    move.cardTwo = _cardsToMatch[1];
                    move.cardThree = card;
                    int matchScore = [card match:@[_cardsToMatch[0], _cardsToMatch[1]]];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        ((Card*)_cardsToMatch[0]).matched = YES;
                        ((Card*)_cardsToMatch[1]).matched = YES;
                        card.matched = YES;
                        [_cardsToMatch removeAllObjects];
                        move.matched = true;
                        [_movesHistory addObject:move];
                        return;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        ((Card*)_cardsToMatch[0]).chosen = NO;
                        ((Card*)_cardsToMatch[1]).chosen = NO;
                        [_cardsToMatch removeAllObjects];
                        [_cardsToMatch addObject:card];
                        move.matched = false;
                        [_movesHistory addObject:move];
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
