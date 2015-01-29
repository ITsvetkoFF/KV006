//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Anton Kovernik on 08.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//


#import "Deck.h"
#import "History.h"


@interface CardMatchingGame : NSObject

@property (nonatomic, strong) NSString *matchingString;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, getter=isStarted) BOOL started;
@property (nonatomic, assign) NSInteger mode;
@property (nonatomic, strong) NSMutableArray *cardsToMatch;
@property (nonatomic, strong) NSMutableArray *movesHistory;
- (instancetype)initWithCardCount:(NSUInteger)count  usingDeck:(Deck *)deck;
- (void)choseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@end
