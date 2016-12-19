//
//  UIScrollView+UITouch.m
//  IkasaInteriorIphone
//
//  Created by Story5 on 15/7/28.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)
/**
 *  2016.02.17 by Story5 暂时注释
 *  有待后期解决处理
 *  暂时注释原因,给UIScrollView添加UITouch类别touch事件会导致
 *  UITextField手写键盘输入闪退bug
 *  控制台崩溃log为   
 *  -[UIWindow endDisablingInterfaceAutorotationAnimated:] called on <UIRemoteKeyboardWindow: 0x17357740; frame = (0 0; 320 480); opaque = NO; autoresize = W+H; layer = <UIWindowLayer: 0x17357a80>> without matching -beginDisablingInterfaceAutorotation. Ignoring.
 *  -[UIKBBlurredKeyView candidateList]: unrecognized selector sent to instance 0x15e19760
 *  Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[UIKBBlurredKeyView candidateList]: unrecognized selector sent to instance 0x15e19760'
 */
//
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    
//    [[self nextResponder] touchesBegan:touches withEvent:event];
//    [super touchesBegan:touches withEvent:event];
//}
//
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//        
//    [[self nextResponder] touchesMoved:touches withEvent:event];
//    [super touchesMoved:touches withEvent:event];
//    
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//        
//    [[self nextResponder] touchesEnded:touches withEvent:event];
//    [super touchesEnded:touches withEvent:event];
//}

@end
