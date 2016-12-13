//
//  PPNumberButton.h
//  PPNumberButton
//
//  Created by AndyPang on 16/8/31.
//  Copyright © 2016年 AndyPang. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol PPNumberButtonDelegate <NSObject>
@optional
/** 加减按钮点击响应的代理回调*/
- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSString *)number;
@end

IB_DESIGNABLE
@interface PPNumberButton : UIView

- (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)numberButtonWithFrame:(CGRect)frame;

/** 加减按钮的Block回调*/
@property (nonatomic, copy) void(^resultBlock)(NSString *number);
/** 代理*/
@property (nonatomic, weak) id<PPNumberButtonDelegate> delegate;

#pragma mark - 自定义样式属性设置
/** 是否开启抖动动画,默认NO*/
@property (nonatomic, assign ) IBInspectable BOOL shakeAnimation;
/** 为YES时,初始化时减号按钮隐藏(饿了么/百度外卖/美团外卖按钮模式),default is NO*/
@property (nonatomic, assign ) IBInspectable BOOL decreaseHide;

/** 设置边框的颜色,如果没有设置颜色,就没有边框 */
@property (nonatomic, strong ) IBInspectable UIColor *borderColor;

/** 输入框中的内容 */
@property (nonatomic, copy   ) NSString *currentNumber;
/** 输入框中的字体大小 */
@property (nonatomic, assign ) IBInspectable CGFloat inputFieldFont;

/** 加减按钮的字体大小 */
@property (nonatomic, assign ) IBInspectable CGFloat buttonTitleFont;
/** 加按钮背景图片 */
@property (nonatomic, strong ) IBInspectable UIImage *increaseImage;
/** 减按钮背景图片 */
@property (nonatomic, strong ) IBInspectable UIImage *decreaseImage;
/** 加按钮标题 */
@property (nonatomic, copy   ) IBInspectable NSString *increaseTitle;
/** 减按钮标题 */
@property (nonatomic, copy   ) IBInspectable NSString *decreaseTitle;

/** 最小值, default is 1 */
@property (nonatomic, assign ) IBInspectable NSInteger minValue;
/** 最大值 */
@property (nonatomic, assign ) NSInteger maxValue;

@end

#pragma mark - NSString分类
@interface NSString (PPNumberButton)
/**
 字符串 nil, @"", @"  ", @"\n" Returns NO;
 其他 Returns YES.
 */
- (BOOL)pp_isNotBlank;
@end
