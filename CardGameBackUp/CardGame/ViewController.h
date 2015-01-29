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

@interface ViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (weak, nonatomic) IBOutlet UILabel *moves;

// protected
// for subclasses
- (Deck *)createDeck;          // abstract
- (void)updateUI:(UIButton*)sender;
- (CardMatchingGame *)game;
- (void)resetGame;
@end

