//
//  Card.h
//  CardGame
//
//  Created by Anton Kovernik on 05.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) Boolean matched;

- (int)match:(NSArray*)otherCards;

@end
