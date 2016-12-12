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
