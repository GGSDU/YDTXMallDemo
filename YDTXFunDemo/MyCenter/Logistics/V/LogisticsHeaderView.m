//
//  LogisticsHeaderView.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "LogisticsHeaderView.h"

@interface LogisticsHeaderView ()

@property (nonatomic, strong) UIImageView *goodsImgV;//商品图片
@property (nonatomic, strong) UILabel *logisticsStatusLabel;//物流状态
@property (nonatomic, strong) UILabel *logisticsSourceLabel;//承运来源
@property (nonatomic, strong) UILabel *logisticsNumLabel;//订单编号


@end

@implementation LogisticsHeaderView

- (UIImageView *)goodsImgV {
    if (!_goodsImgV) {
        _goodsImgV = [UIImageView new];
        _goodsImgV.backgroundColor = [UIColor purpleColor];
        [self addSubview:_goodsImgV];
        [_goodsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(12*WidthScale);
            make.size.mas_equalTo(CGSizeMake(60, 60));
            
        }];
    }
    return _goodsImgV;
}

- (UILabel *)logisticsStatusLabel {
    if (!_logisticsStatusLabel) {
        _logisticsStatusLabel = [UILabel new];
        [_logisticsStatusLabel sizeToFit];
        _logisticsStatusLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsStatusLabel.textColor = RGB(40, 40, 40);
        [self addSubview:_logisticsStatusLabel];
        [_logisticsStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImgV.mas_top);
            make.left.mas_equalTo(self.goodsImgV.mas_right).offset(14*HeightScale);
            make.right.mas_equalTo(self.mas_right).offset(-10);
        }];
        
    }
    return _logisticsStatusLabel;
}

- (UILabel *)logisticsSourceLabel {
    if (!_logisticsSourceLabel) {
        _logisticsSourceLabel = [UILabel new];
        [_logisticsSourceLabel sizeToFit];
        _logisticsSourceLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsSourceLabel.textColor = RGB(141, 141, 141);
        [self addSubview:_logisticsSourceLabel];
        [_logisticsSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logisticsStatusLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.logisticsStatusLabel.mas_left);
            make.right.mas_equalTo(self.logisticsStatusLabel.mas_right);
            
        }];
        
    }
    return _logisticsSourceLabel;
}

- (UILabel *)logisticsNumLabel {
    if (!_logisticsNumLabel) {
        _logisticsNumLabel = [UILabel new];
        [_logisticsNumLabel sizeToFit];
        _logisticsNumLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsNumLabel.textColor = RGB(141, 141, 141);
        [self addSubview:_logisticsNumLabel];
        [_logisticsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logisticsSourceLabel.mas_bottom).offset(10*HeightScale);
            make.left.right.mas_equalTo(self.logisticsSourceLabel);
        }];
    }
    return _logisticsNumLabel;
}



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.goodsImgV.image = [UIImage imageNamed:@"market_cart_icon"];
        self.logisticsStatusLabel.text = @"物流状态：运输中";
        self.logisticsSourceLabel.text = @"承运来源：顺丰";
        self.logisticsNumLabel.text = @"运单编号：131231231213131";
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
