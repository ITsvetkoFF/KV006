//
//  Card.m
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(Card *)otherCards {
    int score = 0;
   
        if ([otherCards.contents isEqualToString:self.contents]) {
            score = 1;
        }
   
    return score;
}




@end
