//
//  SXPublicTool.h
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:(r) * 1.00f / 255 green:(g) * 1.00f / 255 blue:(b) * 1.00f / 255 alpha:1.00]

@interface SXPublicTool : NSObject 

+ (UIWindow *)keyWindow;

#pragma mark - tip
/**
 Show a UIAlertController on the windows.rootViewController
 
 @param title           The tip title.
 @param message         The tip message.
 @param cancelTitle     The title on cancel action.
 @param cancelHandler   A block object to be executed when you clicked the cancel action.
 @param confirmTitle    The title on confirm action.
 @param confirmHandler  A block object to be executed when you clicked the confirm action.
 */
+ (void)showAlertControllerWithTitle:(nullable NSString *)title
                            meassage:(nullable NSString *)message
                         cancelTitle:(nullable NSString *)cancelTitle
                       cancelHandler:(nullable void (^)(UIAlertAction * _Nullable action))cancelHandler
                        confirmTitle:(nullable NSString *)confirmTitle
                      confirmHandler:(nullable void (^)(UIAlertAction * _Nullable action))confirmHandler;


#pragma mark - keyboard notification
+ (void)addKeyboardWillShowNotificationObserver:(nonnull id)observer selector:(nonnull SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardWillShowNotificationObserver:(nonnull id)observer object:(nullable id)anObject;


+ (void)addKeyboardDidShowNotificationObserver:(nonnull id)observer selector:(nonnull SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardDidShowNotificationObserver:(nonnull id)observer object:(nullable id)anObject;


+ (void)addKeyboardWillHideNotificationObserver:(nonnull id)observer selector:(nonnull SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardWillHideNotificationObserver:(nonnull id)observer object:(nullable id)anObject;


@end
