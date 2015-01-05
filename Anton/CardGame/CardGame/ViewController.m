//
//  ViewController.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "ViewController.h"
#import "Card.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (nonatomic) int flipCount;
@property (nonatomic) PlayingCardDeck *deck;
@end

@implementation ViewController

- (void)viewDidLoad {
    _deck = [[PlayingCardDeck alloc] init];
//    _cardButton setTitle:_deck forState:
    [_cardButton setTitle:[[_deck drawRandomCard] contents] forState:UIControlStateNormal];
    
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCountChanged to %d", self.flipCount);
}

- (IBAction)touchCardButon:(UIButton*)sender {
    
    [UIView transitionWithView:sender
                      duration:0.4
                       options:[sender.currentTitle length] ? UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight
                    animations:^{
                        if ([sender.currentTitle length]) {
                            [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                                              forState:UIControlStateNormal];
                            [sender setTitle:@"" forState:UIControlStateNormal];
                        }
                        else {
                            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                                              forState:UIControlStateNormal];
                            //[sender setTitle:@"A♣︎" forState:UIControlStateNormal];
                             [sender setTitle:[[_deck drawRandomCard] contents] forState:UIControlStateNormal];
                        }
                    }
                    completion:^(BOOL finished) {
                        
                    }];
    self.flipCount++;
}

@end
