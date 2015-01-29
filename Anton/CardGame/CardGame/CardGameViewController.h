//
//  ViewController.h
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//
// Abstract cllas

#import <UIKit/UIKit.h>

#import "Deck.h"
#import "CardMatchingGame.h"
#import "Grid.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck; // abstract
- (UIView *)createViewForCard:(Card *)card;
- (void)updateView:(UIView *)view forCard:(Card *)card;
- (void)updateUI;


@property (strong, nonatomic) Grid *grid;
@property (strong, nonatomic) NSString *gameType;
@property (nonatomic) NSUInteger numberOfStartingCards;
@property (nonatomic) CGSize maxCardSize;
@property (nonatomic) BOOL removeMatchingCards;

@end


