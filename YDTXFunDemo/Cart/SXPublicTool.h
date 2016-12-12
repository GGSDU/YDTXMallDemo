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


+ (void)addKeyboardWillShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardWillShowNotificationObserver:(id)observer object:(nullable id)anObject;


+ (void)addKeyboardDidShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardDidShowNotificationObserver:(id)observer object:(nullable id)anObject;


+ (void)addKeyboardWillHideNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject;
+ (void)removeKeyboardWillHideNotificationObserver:(id)observer object:(nullable id)anObject;


@end
