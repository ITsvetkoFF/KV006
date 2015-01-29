//
//  HistoryControllerViewController.m
//  CardGame
//
//  Created by Anton Kovernik on 14.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "HistoryControllerViewController.h"
#import "Card.h"
#import "History.h"
@interface HistoryControllerViewController ()

@property (weak, nonatomic) IBOutlet UITextView *historyText;

@end

@implementation HistoryControllerViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSMutableAttributedString *textViewText = [[NSMutableAttributedString alloc] init];
    for (History *move in _moves) {
        if (move.cardOne) {
            if (move.cardTwo) {
                if (move.cardThree) {
                    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Cards "];
                    [text appendAttributedString:move.cardOne.contents];
                    [text appendAttributedString:move.cardTwo.contents];
                    [text appendAttributedString:move.cardThree.contents];
                    if (move.matched) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" is a set"]];
                    else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" is not a set"]];
                    [textViewText appendAttributedString:text];
                }
                else {
                    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Cards "];
                    [text appendAttributedString:move.cardOne.contents];
                    [text appendAttributedString:move.cardTwo.contents];
                    if (move.matched) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" matched"]];
                    else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" don't matched"]];
                    [textViewText appendAttributedString:text];
                }
            }
            else {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Card "];
                [text appendAttributedString:move.cardOne.contents];                //self.historyView.attributedText = move.cardOne.contents;
                if (move.chosen) [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" chosen"]];
                else    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@" unchosen"]];
                [textViewText appendAttributedString:text];
            }
        }
        [textViewText appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    }
    _historyText.attributedText = textViewText;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
