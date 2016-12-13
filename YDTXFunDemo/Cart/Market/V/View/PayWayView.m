//
//  PayWayView.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/13.
//  Copyright © 2016年 Story5. All rights reserved.
//



#import "PayWayView.h"

@implementation PayWayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];//创建界面
    }
    return self;
}

//创建界面
-(void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    //父view  tip：use for add payWay View
    UIView *baseView = [[UIView alloc]init];
    [self addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    //支付宝 支付View
    UIView *AliPayView = [[UIView alloc]init];
    AliPayView.backgroundColor = [UIColor redColor];
    [baseView addSubview:AliPayView];
    [AliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView);
        make.leading.equalTo(baseView);
        make.trailing.equalTo(baseView);
        make.bottom.equalTo(baseView.mas_centerY);
    }];
    
    
    
    //微信 微信支付View
//    UIView *AliPayView = [[UIView alloc]init];
//    AliPayView.backgroundColor = [UIColor redColor];
//    [baseView addSubview:AliPayView];
//    [AliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(baseView);
//        make.leading.equalTo(baseView);
//        make.trailing.equalTo(baseView);
//        make.bottom.equalTo(baseView.mas_centerY);
//    }];

}

@end
