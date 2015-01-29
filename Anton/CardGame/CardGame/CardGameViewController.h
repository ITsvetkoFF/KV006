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

@interface ViewController : UIViewController

// protected
// for subclasses
- (Deck *)createDeck;          // abstract

@end

