//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Anton Kovernik on 08.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//


#import "Deck.h"



@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count  usingDeck:(Deck *)deck;

- (void)choseCardAtIndexTwo:(NSUInteger)index;
- (void)choseCardAtIndexThree:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;

@end
