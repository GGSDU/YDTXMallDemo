//
//  UIView+Extension.h
//  WeChat
//
//  Created by JW on 16/4/16.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

// 在分类中声明@property, 只会生成方法的声明, 不会生成方法的实现和成员变量
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;



// 一个控件是否正显示在主窗口上
- (BOOL)isShowingOnKeyWindow;

// 从xib加载view
+ (instancetype)viewFromNib;

@end
