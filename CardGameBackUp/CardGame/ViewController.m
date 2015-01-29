//
//  ViewController.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "ViewController.h"
#import "HistoryControllerViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyView;


@end

@implementation ViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

        if ([segue.destinationViewController isKindOfClass:[HistoryControllerViewController class]]) {
            HistoryControllerViewController *tsvc = (HistoryControllerViewController *)segue.destinationViewController;
            tsvc.moves = self.game.movesHistory;
            //tsvc.textToAnalyze = self.body.textStorage;
        }

}

- (void) setHistory {
    History *move = [self.game.movesHistory lastObject];
    if (move.cardOne) {
        if (move.cardTwo) {
            if (move.cardThree) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Cards "];
                [text appendAttributedString:move.cardOne.contents];
                [text appendAttributedString:move.cardTwo.contents];
                [text appendAttributedString:move.cardThree.contents];
                if (move.matched) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" is a set"]];
                else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" is not a set"]];
                self.historyView.attributedText = text;
            }
            else {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Cards "];
                [text appendAttributedString:move.cardOne.contents];
                [text appendAttributedString:move.cardTwo.contents];
                if (move.matched) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" matched"]];
                else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" don't matched"]];
                self.historyView.attributedText = text;
            }
        }
        else {
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Card "];
            [text appendAttributedString:move.cardOne.contents];                //self.historyView.attributedText = move.cardOne.contents;
            if (move.chosen) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" chosen"]];
            else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" unchosen"]];
            self.historyView.attributedText = text;
            
            
        }
    }
}

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
    [self.game choseCardAtIndex:chosenButonIndex];
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
                                    [cardButton setAttributedTitle:[self titleForCard:card]
                                                forState:UIControlStateNormal];
                                    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                                          forState:UIControlStateNormal];
                                } // endblock
                                completion:^(BOOL finished) {
                                }];
        } else {
            [cardButton setAttributedTitle:[self titleForCard:card]
                        forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.moves.text = _game.matchingString;
    }
    [self setHistory];
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
                            [cardButton setAttributedTitle:[self titleForCard:card]
                                        forState:UIControlStateNormal];
                            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                                  forState:UIControlStateNormal];
                        } // endblock
                        completion:^(BOOL finished) {
                        }];

    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (NSAttributedString*)titleForCard:(Card*)card {
    NSAttributedString *str = (card.isChosen ? card.contents : [[NSAttributedString alloc] initWithString: @""]);
    return str;
}


- (UIImage*)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
