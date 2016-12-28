//
//  PayWayView.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/13.
//  Copyright © 2016年 Story5. All rights reserved.
//



#import "PayWayView.h"

@interface PayWayView ()

@property(strong,nonatomic)UIButton *AliPayBtn;//支付宝支付

@property(strong,nonatomic)UIButton *WePayBtn;//微信支付

@end

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
    [baseView addSubview:AliPayView];
    [AliPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView);
        make.leading.equalTo(baseView);
        make.trailing.equalTo(baseView);
        make.bottom.equalTo(baseView.mas_centerY);
    }];
    
    //AliImgView
    UIImageView *AliImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"AliPay_icon"]];
    [AliPayView addSubview:AliImgView];
    [AliImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AliPayView);
        make.leading.equalTo(AliPayView).offset(15);
    }];
    
    
    
    //支付宝支付
    UILabel *AliPayLabel = [[UILabel alloc]init];
    AliPayLabel.text = @"支付宝支付";
    AliPayLabel.font = [UIFont systemFontOfSize:15];
    AliPayLabel.textColor = [UIColor colorForHex:@"333333"];
    [AliPayView addSubview:AliPayLabel];
    [AliPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AliPayView);
        make.leading.equalTo(AliImgView.mas_trailing).offset(10);
    }];
    
    //ChooseAliPayBtn
    UIButton *ChooseAliPayBtn = [[UIButton alloc]init];
    [ChooseAliPayBtn addTarget:self action:@selector(AliPayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [ChooseAliPayBtn setImage:[UIImage imageNamed:@"Pay_circle_icon"] forState:UIControlStateNormal];
    [ChooseAliPayBtn setImage:[UIImage imageNamed:@"Pay_circle_icon_hl"] forState:UIControlStateSelected];
    self.AliPayBtn = ChooseAliPayBtn;
    [AliPayView addSubview:ChooseAliPayBtn];
    [ChooseAliPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(AliPayView);
        make.trailing.equalTo(AliPayView).offset(-10);
    }];
    
    //分割线
    
    UIView *SeparateLine = [[UIView alloc]init];
        SeparateLine.backgroundColor = [UIColor colorForHex:@"e0e0e0"];
        [AliPayView addSubview:SeparateLine];
        [SeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(baseView).offset(15);
            make.trailing.equalTo(baseView);
            make.bottom.equalTo(AliPayView);
            make.height.mas_equalTo(1);
        }];
    
    //微信 微信支付View
    UIView *WePayView = [[UIView alloc]init];
    [baseView addSubview:WePayView];
    [WePayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AliPayView.mas_bottom);
        make.leading.equalTo(baseView);
        make.trailing.equalTo(baseView);
        make.bottom.equalTo(baseView);
    }];

    //WeImgView
    UIImageView *WeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"WePay_icon"]];
    [WePayView addSubview:WeImgView];
    [WeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(WePayView);
        make.leading.equalTo(WePayView).offset(15);
    }];
    
    
    
    //微信支付
    UILabel *WePayLabel = [[UILabel alloc]init];
    WePayLabel.text = @"微信支付";
    WePayLabel.font = [UIFont systemFontOfSize:15];
    WePayLabel.textColor = [UIColor colorForHex:@"333333"];
    [WePayView addSubview:WePayLabel];
    [WePayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(WePayView);
        make.leading.equalTo(WeImgView.mas_trailing).offset(10);
    }];
    
    //ChooseWePayBtn
    UIButton *ChooseWePayBtn = [[UIButton alloc]init];
    [ChooseWePayBtn setImage:[UIImage imageNamed:@"Pay_circle_icon"] forState:UIControlStateNormal];
    [ChooseWePayBtn setImage:[UIImage imageNamed:@"Pay_circle_icon_hl"] forState:UIControlStateSelected];
    [ChooseWePayBtn addTarget:self action:@selector(WePayBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.WePayBtn = ChooseWePayBtn;
    [WePayView addSubview:ChooseWePayBtn];
    [ChooseWePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(WePayView);
        make.trailing.equalTo(WePayView).offset(-10);
    }];

    
}

#pragma mark -- 处理按钮状态支付方式Method

//支付宝按钮处理
-(void)AliPayBtnClick{

    self.AliPayBtn.selected = !self.AliPayBtn.selected;
    if (self.AliPayBtn.selected == YES) {
        
        self.WePayBtn.selected = NO;
        //支付宝支付
        self.payType = isAliPay;
    }else if(self.AliPayBtn.selected == NO){
    
        if (self.WePayBtn.selected == YES) {
            self.payType = isWePay;
        }else{
            self.payType = userNoChoose;
        }

        }
    

}

//微信按钮处理
-(void)WePayBtnClick{

    self.WePayBtn.selected = !self.WePayBtn.selected;
    if (self.WePayBtn.selected == YES) {
        
        self.AliPayBtn.selected = NO;
        //支付宝支付
        self.payType = isWePay;
    }else if(self.WePayBtn.selected == NO){
    
        if (self.AliPayBtn.selected == YES) {
            self.payType = isAliPay;
        }else{
            self.payType = userNoChoose;
        }
    
    }
    
    

}




@end
