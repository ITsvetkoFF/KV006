//
//  InfoActions.h
//  ecomap
//
//  Created by Vasya on 3/7/15.
//  Copyright (c) 2015 SoftServe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoActions : NSObject
+ (void)showAlertViewWithTitile:(NSString *)title andMessage:(NSString *)message;

//Show action sheet with login oprions
//Sender can be nill. It is required for iPad to present popover in right position (since action sheet is presented in popover on iPad)
//dismissBlock can be nill. Set it if you need some action to be done after success login.
+ (void)showLogitActionSheetFromSender:(id)sender actionAfterSuccseccLogin:(void (^)(void))dismissBlock;

//Show popup for 1.5 sec. User
+ (void)showPopupWithMesssage:(NSString *)message;
@end
