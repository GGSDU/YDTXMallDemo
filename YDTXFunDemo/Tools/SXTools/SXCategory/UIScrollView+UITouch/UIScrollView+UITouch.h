//
//  UIScrollView+UITouch.h
//  IkasaInteriorIphone
//
//  Created by Story5 on 15/7/28.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//



/*
 *  解决UIScrollView不能响应UITouch的问题
 */

#import <UIKit/UIKit.h>

@interface UIScrollView (UITouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
