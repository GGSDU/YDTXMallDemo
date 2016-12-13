//
//  SXPublicTool.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SXPublicTool.h"

@implementation SXPublicTool

#pragma mark - 
+ (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark - tip
+ (void)showAlertControllerWithTitle:(nullable NSString *)title
                            meassage:(nullable NSString *)message
                         cancelTitle:(nullable NSString *)cancelTitle
                       cancelHandler:(nullable void (^)(UIAlertAction * _Nonnull action))cancelHandler
                        confirmTitle:(nullable NSString *)confirmTitle
                      confirmHandler:(nullable void (^)(UIAlertAction * _Nonnull action))confirmHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //cancel
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
    [alert addAction:cancelAction];
    //confirm
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    [alert addAction:confirmAction];
    //present
    UIWindow *window = [SXPublicTool keyWindow];
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NSNotificationCenter
/**
 *  NSNotificationCenter
 */
+ (void)addKeyboardWillShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardWillShowNotification object:anObject];
}

+ (void)addKeyboardDidShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject
{
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardDidShowNotification object:anObject];
    
}

+ (void)addKeyboardWillHideNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardWillHideNotification object:anObject];
    
}

+ (void)removeKeyboardWillShowNotificationObserver:(id)observer object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

}

+ (void)removeKeyboardDidShowNotificationObserver:(id)observer object:(nullable id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];

}

+ (void)removeKeyboardWillHideNotificationObserver:(id)observer object:(nullable id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
