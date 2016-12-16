//
//  Order_Status-AddressView.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_Status-AddressView.h"

#import "OrderGoodsModel.h"


@interface Order_Status_AddressView ()

@property (nonatomic, strong) UIImageView *statusBackGroundImgV;//状态信息的底部视图
@property (nonatomic, strong) UIImageView *statusImgV;//状态图片
@property (nonatomic, strong) UILabel *statusLabel;//状态
@property (nonatomic, strong) UILabel *descriptionLabel;//描述文字


@property (nonatomic, strong) UIView *receiveBackGroundView;//收货地址的底部视图
@property (nonatomic, strong) UIImageView *locationImg;//位置图标
@property (nonatomic, strong) UILabel *nameLabel;//收货人
@property (nonatomic, strong) UILabel *mobileLabel;//手机号
@property (nonatomic, strong) UILabel *addressLabel;//地址


@end

@implementation Order_Status_AddressView
#pragma mark lazy
- (UIImageView *)statusBackGroundImgV {
    if (!_statusBackGroundImgV) {
        _statusBackGroundImgV = [UIImageView new];
        _statusBackGroundImgV.image = [UIImage imageNamed:@"statusBackGroundImg"];
        [self addSubview:_statusBackGroundImgV];
        [_statusBackGroundImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 100*HeightScale));
            make.left.mas_equalTo(self.mas_left);
        }];
    }
    return _statusBackGroundImgV;
}

- (UIImageView *)statusImgV {
    if (!_statusImgV) {
        _statusImgV = [UIImageView new];
        
        [self.statusBackGroundImgV addSubview:_statusImgV];
        [_statusImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.statusBackGroundImgV.mas_left).offset(98*WidthScale);
            make.top.mas_equalTo(self.statusBackGroundImgV.mas_top).offset(30*HeightScale);
            make.size.mas_equalTo(CGSizeMake(50*WidthScale, 50*WidthScale));
        }];
    }
    return _statusImgV;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        [_statusLabel sizeToFit];
        _statusLabel.font = [UIFont systemFontOfSize:20*HeightScale];
        _statusLabel.textColor = [UIColor whiteColor];
        
        [self.statusBackGroundImgV addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.statusImgV.mas_top);
            make.left.mas_equalTo(self.statusImgV.mas_right).offset(12*WidthScale);
            
        }];
    }
    return _statusLabel;
}

- (UILabel *)descriptionLabel {
    if (!_descriptionLabel) {
        _descriptionLabel = [UILabel new];
        [_descriptionLabel sizeToFit];
        
        _descriptionLabel.textColor = [UIColor whiteColor];
        _descriptionLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.statusBackGroundImgV addSubview:_descriptionLabel];
        [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.statusLabel.mas_left).offset(12*WidthScale);
            make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(10*HeightScale);
        }];
    }
    return _descriptionLabel;
}



- (UIView *)receiveBackGroundView {
    if (!_receiveBackGroundView) {
        _receiveBackGroundView = [UIView new];
        _receiveBackGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_receiveBackGroundView];
        [_receiveBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.statusBackGroundImgV.mas_bottom);
            make.left.mas_equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 67*HeightScale));
        }];
    }
    return _receiveBackGroundView;
}


- (UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [UIImageView new];
        _locationImg.image = [UIImage imageNamed:@"order-status-location"];
        [self.receiveBackGroundView addSubview:_locationImg];
        [_locationImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.receiveBackGroundView.mas_left).offset(10*WidthScale);
//            make.topMargin.mas_equalTo(self.receiveBackGroundView.mas_top).offset(15*HeightScale);

            make.centerY.mas_equalTo(self.receiveBackGroundView.centerY);
            make.size.mas_equalTo(CGSizeMake(15*WidthScale, 15*WidthScale));
        }];
    }
    
    return _locationImg;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        [_nameLabel sizeToFit];
        _nameLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _nameLabel.textColor = [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1];
        _nameLabel.text = @"收货人:";
        [self.receiveBackGroundView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.receiveBackGroundView.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.locationImg.mas_right).offset(10*WidthScale);
            
        }];
    }
    return _nameLabel;
}

- (UILabel *)mobileLabel {
 
    if (!_mobileLabel) {
        _mobileLabel = [UILabel new];
        [_mobileLabel sizeToFit];
        _mobileLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _mobileLabel.textColor = [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1];
        [self.receiveBackGroundView addSubview:_mobileLabel];
        [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.receiveBackGroundView.mas_right).offset(-10*HeightScale);
            make.top.mas_equalTo(self.nameLabel.mas_top);
            
        }];
    }
    return _mobileLabel;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        [_addressLabel sizeToFit];
        _addressLabel.textColor = [UIColor colorWithRed:102.0 / 255.0 green:102.0 / 255.0 blue:102.0 / 255.0 alpha:1];
        _addressLabel.text  = @"地址是:";
        _addressLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.receiveBackGroundView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10*HeightScale);
            
        }];
    }
    return _addressLabel;
}



- (instancetype)initWithFrame:(CGRect)frame orderModel:(OrderGoodsModel *)model {
    
    if (self = [super initWithFrame:frame]) {
        
        NSString *style = nil;
//        Status: -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
        if ([model.status isEqualToString:@"-1"]) {
            style = @"已取消";
        } else if ([model.status isEqualToString:@"0"]){
            style = @"待付款";
            } else if ([model.status isEqualToString:@"1"]){
                style = @"已完成";
                } else if ([model.status isEqualToString:@"2"]){
                  style = @"待收货";
                    } else if ([model.status isEqualToString:@"3"]){
                     style = @"退款";
                        } else if ([model.status isEqualToString:@"4"]){
                        style = @"加入购物车";
                            }
        
        if ([style isEqualToString:@"已完成"]) {
            self.statusImgV.image = [UIImage imageNamed:@"finishStatusImg"];
            self.statusLabel.text = style;
            self.descriptionLabel.text = @"生活就是买买买~";
        }else {
            self.statusImgV.image = [UIImage imageNamed:@"WaitStatusImg"];
            self.statusLabel.text = style;
            self.descriptionLabel.text = @"再不付款就成别人的啦~";
        }
       
        
        
        
       
       self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.prov,model.city,model.area,model.address];
        self.mobileLabel.text = model.mobile;
        
        
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
