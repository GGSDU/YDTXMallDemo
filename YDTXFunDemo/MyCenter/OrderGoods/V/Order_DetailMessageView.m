//
//  Order_DetailMessageView.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/13.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_DetailMessageView.h"


@interface Order_DetailMessageView ()
@property (nonatomic, strong) UIView *messageBackGroundView;//商品信息展示底部视图
@property (nonatomic, strong) UIView *priceBackGroundView;//运费优惠付款金额底部视图
@property (nonatomic, strong) UIView *BtnGroundView;//联系商家底部视图

@property (nonatomic, strong) UIImageView *goodsImageView;//商品图片
@property (nonatomic, strong) UILabel *goodsNameLabel;//商品名称
@property (nonatomic, strong) UILabel *goodsPriceLabel;//商品价格
@property (nonatomic, strong) UILabel *goodsType;//商品型号
@property (nonatomic, strong) UILabel *goodsNumLabel;//商品数量


@property (nonatomic, strong) UILabel *chargeLabel;//运费
@property (nonatomic, strong) UILabel *chargeNumLabel;//运费额
@property (nonatomic, strong) UILabel *privilegeLabel;//优惠
@property (nonatomic, strong) UILabel *privilegeNumLabel;//优惠额
@property (nonatomic, strong) UILabel *paymentLabel;//付款
@property (nonatomic, strong) UILabel *paymentNumLabel;//付款额

@property (nonatomic, strong) UIButton *contactMerchant;//联系商家
@property (nonatomic, strong) UIButton *contactPlatform;//联系平台

//@property (nonatomic, strong) UILabel *orderNum;//订单号
//@property (nonatomic, strong) UILabel *orderCreat_time;//下单时间


@end

@implementation Order_DetailMessageView

#pragma mark lazy
- (UIView *)messageBackGroundView {
    if (!_messageBackGroundView) {
        _messageBackGroundView = [[UIView alloc]init];
//        _messageBackGroundView.backgroundColor = [UIColor colorWithRed:249.0 / 255 green:249.0 / 255 blue:249.0 / 255 alpha:1.0];
        _messageBackGroundView.backgroundColor = RGB(249, 249, 249);
        [self addSubview:_messageBackGroundView];
        [_messageBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.left.mas_equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 83*HeightScale));
        }];
    }
    
    return _messageBackGroundView;
}

- (UIView *)priceBackGroundView {
    if (!_priceBackGroundView) {
        _priceBackGroundView = [[UIView alloc]init];
        _priceBackGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_priceBackGroundView];
        [_priceBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageBackGroundView.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 90*HeightScale));
        }];
    }
    return _priceBackGroundView;
}

- (UIView *)BtnGroundView {
    if (!_BtnGroundView) {
        _BtnGroundView = [[UIView alloc]init];
        _BtnGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BtnGroundView];
        [_BtnGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceBackGroundView.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 51*HeightScale));
        }];
        
        
        UIView *topLineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
        topLineView.backgroundColor = RGB(232, 232, 232);
        [_BtnGroundView addSubview:topLineView];
        UIView *centerLineView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth/2-0.5, 1, 1, 50*HeightScale)];
        centerLineView.backgroundColor = RGB(232, 232, 232);
        [_BtnGroundView addSubview:centerLineView];
        
        
    }
    return _BtnGroundView;
}


#pragma mark control view
- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [UIImageView new];
        _goodsImageView.layer.cornerRadius = 5;
        _goodsImageView.layer.masksToBounds = YES;
        _goodsImageView.image = [UIImage imageNamed:@"order-status-location"];
        [self.messageBackGroundView addSubview:_goodsImageView];
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageBackGroundView.mas_top).offset(12*HeightScale);
            make.left.mas_equalTo(self.messageBackGroundView.mas_left).offset(10*HeightScale);
            make.size.mas_equalTo(CGSizeMake(60*WidthScale, 60*WidthScale));
        }];
        
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel ) {
        _goodsNameLabel = [UILabel new];
        _goodsNameLabel.numberOfLines = 2;
        [_goodsNameLabel sizeToFit];
        _goodsNameLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _goodsNameLabel.textColor = RGB(36, 36, 36);
        [self.messageBackGroundView addSubview:_goodsNameLabel];
        [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageBackGroundView.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.goodsImageView.mas_right).offset(15*HeightScale);
            make.width.mas_equalTo(ScreenWidth/2);
            
        }];
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceLabel {
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [UILabel new];
        [_goodsPriceLabel sizeToFit];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.messageBackGroundView addSubview:_goodsPriceLabel];
        [_goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.messageBackGroundView.mas_right).offset(-10*WidthScale);
            make.top.mas_equalTo(self.goodsNameLabel.mas_top);
            
        }];
    }
    return _goodsPriceLabel;
}


- (UILabel *)goodsType {
    if (!_goodsType) {
        _goodsType = [UILabel new];
        [_goodsType sizeToFit];
        _goodsType.font = [UIFont systemFontOfSize:14*HeightScale];
        _goodsType.textColor = RGB(185, 185, 185);
        [self.messageBackGroundView addSubview:_goodsType];
        [_goodsType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.goodsNameLabel.mas_left);
            make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).offset(12*HeightScale);
        }];
    }
    return _goodsType;
}

- (UILabel *)goodsNumLabel {
    if (!_goodsNumLabel) {
        _goodsNumLabel = [UILabel new];
        [_goodsNumLabel sizeToFit];
        _goodsNumLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _goodsNumLabel.textColor = RGB(185, 185, 185);
        [self.messageBackGroundView addSubview:_goodsNumLabel];
        [_goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsType.mas_top);
            make.right.mas_equalTo(self.goodsPriceLabel.mas_right);
        }];
    }
    return _goodsNumLabel;
}


- (UILabel *)chargeLabel {
    if (!_chargeLabel) {
        _chargeLabel = [UILabel new];
        [_chargeLabel sizeToFit];
        _chargeLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _chargeLabel.textColor = RGB(46, 46, 46);
        _chargeLabel.text = @"运费";
        [self.priceBackGroundView addSubview:_chargeLabel];
        [_chargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceBackGroundView.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.priceBackGroundView.mas_left).offset(10*WidthScale);
        }];
    }
    return _chargeLabel;
}
- (UILabel *)chargeNumLabel {
    if (!_chargeNumLabel) {
        _chargeNumLabel = [UILabel new];
        [_chargeNumLabel sizeToFit];
        _chargeNumLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _chargeNumLabel.textColor = RGB(46, 46, 46);
        [self.priceBackGroundView addSubview:_chargeNumLabel];
        [_chargeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chargeLabel.mas_top);
            make.right.mas_equalTo(self.priceBackGroundView.mas_right).offset(-10*WidthScale);
        }];
    }
    return _chargeNumLabel;
}

- (UILabel *)privilegeLabel {
    if (!_privilegeLabel) {
        _privilegeLabel = [UILabel new];
        [_privilegeLabel sizeToFit];
        _privilegeLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _privilegeLabel.text = @"优惠";
        _privilegeLabel.textColor = RGB(46, 46, 46);
        [self.priceBackGroundView addSubview:_privilegeLabel];
        [_privilegeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.chargeLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.chargeLabel.mas_left);
            
        }];
    }
    return _privilegeLabel;
}
- (UILabel *)privilegeNumLabel {
    if (!_privilegeNumLabel) {
        _privilegeNumLabel = [UILabel new];
        [_privilegeNumLabel sizeToFit];
        _privilegeNumLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _privilegeNumLabel.textColor = RGB(46, 46, 46);
        [self.priceBackGroundView addSubview:_privilegeNumLabel];
        [_privilegeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.privilegeLabel.mas_top);
            make.right.mas_equalTo(self.chargeNumLabel.mas_right);
            
        }];
    }
    return _privilegeNumLabel;
}

- (UILabel *)paymentLabel {
    if (!_paymentLabel) {
        _paymentLabel = [UILabel new];
        [_paymentLabel sizeToFit];
        _paymentLabel.textColor = RGB(46, 46, 46);
        _paymentLabel.text = @"实付款（含运费）";
        _paymentLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        [self.priceBackGroundView addSubview:_paymentLabel];
        [_paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.privilegeLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.privilegeLabel.mas_left);
            
        }];
    }
    return _paymentLabel;
}

- (UILabel *)paymentNumLabel {
    if (!_paymentNumLabel) {
        _paymentNumLabel = [UILabel new];
        _paymentNumLabel.textColor = RGB(248, 28, 28);
        [_paymentNumLabel sizeToFit];
        _paymentNumLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        [self.priceBackGroundView addSubview:_paymentNumLabel];
        [_paymentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.paymentLabel.mas_top);
            make.right.mas_equalTo(self.privilegeNumLabel.mas_right);
            
        }];
        
    }
    return _paymentNumLabel;
}

- (UIButton *)contactMerchant {
    if (!_contactMerchant) {
        _contactMerchant = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactMerchant setTitle:@"联系商家" forState:UIControlStateNormal];
        [_contactMerchant setTitleColor:RGB(92, 92, 92) forState:UIControlStateNormal];
        [self.BtnGroundView addSubview:_contactMerchant];
        [_contactMerchant mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.BtnGroundView.mas_top).offset(1);
            make.left.mas_equalTo(self.BtnGroundView.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth/2-0.5, 50*HeightScale));
            
        }];
        
        
    }
    return _contactMerchant;
}
- (UIButton *)contactPlatform {
    if (!_contactPlatform) {
        _contactPlatform = [UIButton buttonWithType:UIButtonTypeCustom];
        [_contactPlatform setTitleColor:RGB(92, 92, 92) forState:UIControlStateNormal];
        [_contactPlatform setTitle:@"联系平台" forState:UIControlStateNormal];
        [self.BtnGroundView addSubview:_contactPlatform];
        [_contactPlatform mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contactMerchant.mas_top);
            make.left.mas_equalTo(self.contactMerchant.mas_right).offset(1);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth/2-0.5, 50*HeightScale));
        }];
        
    }
    return _contactPlatform;
}


- (instancetype)initWithFrame:(CGRect)frame orderGoodsModel:(OrderGoodsModel *)model {
    
    if (self = [super initWithFrame:frame]) {
        
//        self.priceBackGroundView.backgroundColor = [UIColor grayColor];
        self.BtnGroundView.backgroundColor = [UIColor whiteColor];
        
        [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:[@"http://" stringByAppendingString:model.images_url]] placeholderImage:[UIImage imageNamed:@""]];
        
        self.goodsNameLabel.text = model.goods_name;
        self.goodsPriceLabel.text = model.price;
        self.goodsType.text = [@"型号：" stringByAppendingString:model.models];
        self.goodsNumLabel.text = [@"X" stringByAppendingString:model.nums];
        
        
        self.chargeNumLabel.text = [@"￥" stringByAppendingString:@"0.00"];//运费
        self.privilegeNumLabel.text = @"0.00";// 优惠额
        self.paymentNumLabel.text = model.total_price;//付款额
        
        [self.contactMerchant addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contactPlatform addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)btnAction:(UIButton *)sender {
    NSLog(@"========%@",(UIButton *)sender.titleLabel.text);
    NSString *urlStr = @"13166266570";
    //获取目标号码字符串
    
    urlStr = [NSString stringWithFormat:@"tel://%@",urlStr];
    
    //转换成URL
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //调用系统方法拨号
    [[UIApplication sharedApplication] openURL:url];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
