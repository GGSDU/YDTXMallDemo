//
//  CallMobile.m
//  YDTX
//
//  Created by 舒通 on 2016/12/23.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "CallMobile.h"

@implementation CallMobile


- (instancetype)initWithFrame:(CGRect)frame mobileNum:(NSString *)num {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapAction:)];
        [self addGestureRecognizer:tap];
        
        UIView *callView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-220*HeightScale, ScreenWidth, 220*HeightScale)];
        callView.backgroundColor = [UIColor whiteColor];
        [self addSubview:callView];
        
        
        //联系商家label
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"联系商家";
        [titleLabel setFont:[UIFont systemFontOfSize:24]];
        titleLabel.textColor = [UIColor colorWithRed:0.090 green:0.780 blue:0.839 alpha:1.000];
        [callView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(callView).offset(22*HeightScale);
            make.centerX.equalTo(callView.mas_centerX);
        }];

        //号码label
        UILabel *NumLabel = [UILabel new];
        NumLabel.text = num;
        [NumLabel setFont:[UIFont systemFontOfSize:15]];
        NumLabel.textColor = [UIColor colorWithWhite:0.424 alpha:1.000];
        [callView addSubview:NumLabel];
        self.mobileLabel = NumLabel;
        [NumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(titleLabel.mas_bottom).offset(20*HeightScale);
            make.centerX.equalTo(titleLabel.mas_centerX);
        }];

        
        
        //电话咨询Btn
        UIButton *TelBtn = [[UIButton alloc]init];
        [TelBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形2"] forState:UIControlStateNormal];
        [TelBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
        TelBtn.titleLabel.textColor = [UIColor whiteColor];
        TelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [TelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [callView addSubview:TelBtn];
        
        [TelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(NumLabel.mas_bottom).offset(20);
            make.centerX.equalTo(NumLabel);
        }];
        
        //取消拨打电话
        UIButton *CancelBtn = [[UIButton alloc]init];
        [CancelBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形2拷贝"] forState:UIControlStateNormal];
        [CancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        CancelBtn.titleLabel.textColor = [UIColor whiteColor];
        CancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [CancelBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [callView addSubview:CancelBtn];
        
        [CancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(TelBtn.mas_bottom).offset(20);
            make.centerX.equalTo(TelBtn);
        }];

        
        
        
    }
    
    return self;
}

#pragma mark -- delegate---
- (void) buttonAction:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"电话咨询"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(didCallBtnTag)]) {
            [_delegate didCallBtnTag];
        }
    }
//    取消拨打电话
    else if ([sender.titleLabel.text isEqualToString:@"取消"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(didCancelCall)]) {
            [_delegate didCancelCall];
        }
    }
    
}

#pragma mark 取消拨打
- (void)TapAction:(UITapGestureRecognizer *)tag {
    if (_delegate && [_delegate respondsToSelector:@selector(didCancelCall)]) {
        [_delegate didCancelCall];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
