//
//  SetView.h
//  CardGame
//
//  Created by Anton Kovernik on 26.01.15.
//  Copyright (c) 2015 Anton Kovernik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) NSUInteger number;

@property (nonatomic) BOOL chosen;

@end

