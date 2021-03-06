//
//  ProblemViewController.h
//  ecomap
//
//  Created by Inna Labuskaya on 2/14/15.
//  Copyright (c) 2015 SoftServe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EcomapProblem.h"
#import "EcomapProblemDetails.h"

@protocol EcomapProblemViewDelegate <NSObject>

- (void)showEcomapProblem:(EcomapProblem *)problem;

@end

@interface ProblemViewController : UIViewController

@property (nonatomic) NSUInteger problemID;

@end
