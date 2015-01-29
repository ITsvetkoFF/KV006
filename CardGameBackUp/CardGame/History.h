//
//  History.h
//  CardGame
//
//  Created by Anton Kovernik on 14.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface History : NSObject

@property (nonatomic, strong) Card* cardOne;
@property (nonatomic, strong) Card* cardTwo;
@property (nonatomic, strong) Card* cardThree;
@property (nonatomic) BOOL matched;
@property (nonatomic) BOOL chosen;


@end
