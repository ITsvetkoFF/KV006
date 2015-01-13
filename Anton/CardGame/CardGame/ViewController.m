//
//  ViewController.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"


@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControll;
@property (weak, nonatomic) IBOutlet UILabel *moves;

@end

@implementation ViewController


- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.started = false;
    }
    return _game;
}


- (Deck *)createDeck {          // abstract
    return nil;
}


- (IBAction)touchCardButon:(UIButton*)sender {

    NSUInteger chosenButonIndex = [self.cardButtons indexOfObject:sender];
    if ([self.segmentControll selectedSegmentIndex] == 0)
        [self.game choseCardAtIndexTwo:chosenButonIndex];
    else
        [self.game choseCardAtIndexThree:chosenButonIndex];
    [self updateUI:sender];
    if (!self.game.isStarted) {
        self.game.started = true;
        self.segmentControll.enabled = NO;
    }
    
}


- (void)updateUI:(UIButton*)sender {
    
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if (cardButton == sender) {
            [UIView transitionWithView:cardButton
                              duration:0.4
                               options:[cardButton.currentTitle length] ? UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight
                                animations:^{
                                    [cardButton setTitle:[self titleForCard:card]
                                                forState:UIControlStateNormal];
                                    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                                          forState:UIControlStateNormal];
                                } // endblock
                                completion:^(BOOL finished) {
                                }];
        } else {
            [cardButton setTitle:[self titleForCard:card]
                        forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.moves.text = _game.matchingString;
    }
}
- (IBAction)resetButton:(UIButton *)sender {
    [self resetGame];
}
- (IBAction)cardsChanged:(id)sender {
    
}

- (void)viewDidLoad {
    
}

- (void)resetGame {
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    _game.started = false;
    self.segmentControll.enabled = YES;
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        cardButton.enabled = YES;
        [UIView transitionWithView:cardButton
                          duration:0.4
                           options:[cardButton.currentTitle length] ? UIViewAnimationOptionTransitionFlipFromLeft :UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [cardButton setTitle:[self titleForCard:card]
                                        forState:UIControlStateNormal];
                            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                                  forState:UIControlStateNormal];
                        } // endblock
                        completion:^(BOOL finished) {
                        }];

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSString*)titleForCard:(Card*)card {
    return card.isChosen ? card.contents : @"";
}


- (UIImage*)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
