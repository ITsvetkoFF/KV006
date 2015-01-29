//
//  SetCardGameViewController.m
//  CardGame
//
//  Created by Anton Kovernik on 13.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"

@interface SetCardGameViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyView;

@end

@implementation SetCardGameViewController

- (Deck*)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSAttributedString*)titleForCard:(Card*)card {
    return card.contents;
}

- (void)viewDidAppear:(BOOL)animated {
  //  [self createDeck];
    [self showCards];
    self.game.mode = 3;
}

- (UIImage*)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardchosen" : @"cardfront"];
}

- (void)updateUI:(UIButton*)sender {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        if (cardButton == sender) {
            [cardButton setAttributedTitle:[self titleForCard:card]
                                  forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
        } else {
            [cardButton setAttributedTitle:[self titleForCard:card]
                                  forState:UIControlStateNormal];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                                  forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    }
    [self setHistory];
}

- (void)resetGame {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                              usingDeck:[self createDeck]];
    self.game.started = false;
    self.game.mode = 3;
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

- (void) showCards {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
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


@end
