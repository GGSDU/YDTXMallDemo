//
//  OrderTableViewCell.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "OrderListModel.h"



@interface OrderTableViewCell ()

@property (nonatomic, strong) UIView *backGroundView;//订单详情数量的底部视图



@property (nonatomic, strong) UIView *payBackGroundView;//实付信息的底部视图
@property (nonatomic, strong) UIView *delectBackGroundView;//删除按钮的底部视图


@property (nonatomic, strong) UILabel *payDetailLabel;//实付信息\


@property (nonatomic, strong) UIImageView *orderImgV;//商品头像
@property (nonatomic, strong) UILabel *nameLabel;//商品名称
@property (nonatomic, strong) UILabel *orderStatus;//商品状态
@property (nonatomic, strong) UILabel *priceLabel;//价格
@property (nonatomic, strong) UILabel *numLabel;//商品数量


@property (nonatomic, strong) NSMutableArray *arr;//按钮的名字

@end


@implementation OrderTableViewCell

- (NSMutableArray *)arr {
    if (!_arr) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

#pragma mark  lazy
//底部视图 商品信息
- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]init];
        _backGroundView.backgroundColor = RGB(249, 249, 249);
        [self.contentView addSubview:_backGroundView];
        [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top);
            make.width.mas_equalTo(ScreenWidth);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.height.mas_equalTo(83*HeightScale);
        }];
        
    }
    return _backGroundView;
}
//付款金额
- (UIView *)payBackGroundView {
    if (!_payBackGroundView) {
        _payBackGroundView = [[UIView alloc]init];
        _payBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_payBackGroundView];
        
        [_payBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backGroundView.mas_bottom);
            make.left.mas_equalTo(self.backGroundView.mas_left);
            make.height.mas_equalTo(45*HeightScale);
            make.width.mas_equalTo(ScreenWidth);
        }];
        
        UIView *bottomLineView = [[UIView alloc]init];
        bottomLineView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0 / 255.0 green:238.0 / 255.0 blue:238.0 / 255.0 alpha:1];
        [_payBackGroundView addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_payBackGroundView.mas_bottom).offset(-0.8);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 0.8));
            make.left.mas_equalTo(_payBackGroundView.mas_left);
        }];
        
    }
    return _payBackGroundView;
}
//   删除按钮
- (UIView *)delectBackGroundView {
    if (!_delectBackGroundView) {
        _delectBackGroundView = [[UIView alloc]init];
        _delectBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_delectBackGroundView];
        
        [_delectBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.payBackGroundView.mas_bottom);
            make.left.mas_equalTo(self.payBackGroundView.mas_left);
            make.width.mas_equalTo(ScreenWidth);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    return _delectBackGroundView;
}


//控件
- (UILabel *)payDetailLabel {
    if (!_payDetailLabel) {
        _payDetailLabel = [UILabel new];
        [_payDetailLabel sizeToFit];
        _payDetailLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _payDetailLabel.textColor = [UIColor colorWithDisplayP3Red:58.0 / 255.0 green:58.0 / 255.0 blue:58.0 / 255.0 alpha:1];
        
        [self.payBackGroundView addSubview:_payDetailLabel];
        [_payDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.payBackGroundView.centerX);
            make.right.mas_equalTo(self.payBackGroundView.mas_right).offset(-15*WidthScale);
//            make.size.mas_equalTo(CGSizeMake(70*WidthScale, 25*HeightScale));
            make.height.mas_equalTo(25*HeightScale);
        }];
        
    }
    return _payDetailLabel;
}
////////////////////////////////////////////////////////////////////////////
- (UIImageView *)orderImgV {
    if (!_orderImgV) {
        _orderImgV = [UIImageView new];
        _orderImgV.layer.cornerRadius = 5;
        _orderImgV.layer.masksToBounds = YES;
        [self.backGroundView addSubview:_orderImgV];
        [_orderImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(60*HeightScale, 60*HeightScale));
        }];
    }
    
    return _orderImgV;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        [_nameLabel sizeToFit];
        _nameLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _nameLabel.textColor = [UIColor colorWithDisplayP3Red:45.0 / 255.0 green:45.0 / 255.0 blue:45.0 / 255.0 alpha:1];
        _nameLabel.numberOfLines = 2;
        _nameLabel.text = @"商品名";
        [self.backGroundView addSubview:_nameLabel];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(14*HeightScale);
            make.left.mas_equalTo(self.orderImgV.mas_right).offset(12*WidthScale);
            //            make.height.mas_equalTo(0);
            make.right.mas_equalTo(self.mas_right).offset(-70*WidthScale);
            
        }];
        
    }
    
    return _nameLabel;
}

- (UILabel *)orderStatus {
    if (!_orderStatus) {
        _orderStatus = [UILabel new];
        _orderStatus.font = [UIFont systemFontOfSize:12*HeightScale];
        _orderStatus.textColor = [UIColor orangeColor];
        [_orderStatus sizeToFit];
        [self.backGroundView addSubview:_orderStatus];
        [_orderStatus mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_top);
            make.right.mas_equalTo(self.mas_right).offset(-15*WidthScale);
            
        }];
    }
    return _orderStatus;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        [_priceLabel sizeToFit];
        _priceLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _priceLabel.textColor = [UIColor colorWithDisplayP3Red:83.0 / 255.0 green:83.0 / 255.0 blue:83.0 / 255.0 alpha:1];
        [self.backGroundView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(14*HeightScale);
            make.left.mas_equalTo(self.orderImgV.mas_right).offset(12*WidthScale);
        }];
        
    }
    return _priceLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel new];
        [_numLabel sizeToFit];
        _numLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        _numLabel.textColor = [UIColor colorWithDisplayP3Red:83.0 / 255.0 green:83.0 / 255.0 blue:83.0 / 255.0 alpha:1];
        [self.backGroundView addSubview:_numLabel];
        [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.priceLabel.mas_top);
            
            make.right.mas_equalTo(self.orderStatus.mas_right);
            
        }];
        
    }
    return _numLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(OrderListModel *)model {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        商品信息
        NSURL *url = [NSURL URLWithString:[@"http://" stringByAppendingString:model.images_url]];
        [self.orderImgV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
        self.orderImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",url]];
        self.nameLabel.text =model.goods_name;
        
        self.priceLabel.text = model.price;
        self.numLabel.text = [NSString stringWithFormat:@"￥%@",model.nums];
        
        NSLog(@"orderlist model is :%@--%@--%@--%@",model.images_url,model.goods_name,model.status,model.price);
//      应付金额
            CGFloat price = 0.0;
            int num = 0;
                price += [model.price floatValue];
                num += [model.nums integerValue];
              self.payDetailLabel.text = [NSString stringWithFormat:@"共%d件商品  实付:￥%0.2f",num,price];
//      订单状态
            [self creatBtnStyle:model.status];

        
        
       
            
        }
        
    

    return self;
}

#pragma mark 根据类型创建不同的button
- (void) creatBtnStyle:(NSString *)style {
    //-1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
    
    [self.delectBackGroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除所有子视图
    
    [self.arr removeAllObjects];
    
    
    if ([style isEqualToString:@"-1"]) {
        self.orderStatus.text = @"已取消";
        
        
    }   else if ([style isEqualToString:@"0"]) {
        self.orderStatus.text = @"待付款";
        [self.arr addObjectsFromArray:@[@"取消订单",@"查看物流",@"继续支付"]];
//        [self.arr addObjectsFromArray:@[@"取消订单",@"继续支付"]];
        
    }   else if ([style isEqualToString:@"1"]) {
        self.orderStatus.text = @"已完成";
        [self.arr addObject:@"删除订单"];
        
    }   else if ([style isEqualToString:@"2"]) {
        self.orderStatus.text = @"待收货";
        [self.arr addObjectsFromArray:@[@"确认收货",@"查看物流",@"退款"]];
        
    }   else if ([style isEqualToString:@"3"]) {
        self.orderStatus.text = @"退款";
        [self.arr addObject:@"删除订单"];
        
    }   else if ([style isEqualToString:@"4"]) {
        self.orderStatus.text = @"加入购物车";
        
        
    }
    

    
    for (int i = 0; i< self.arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10+i;
        
        
        [button setTitleColor:[UIColor colorWithDisplayP3Red:100.0 / 255.0 green:100.0 / 255.0 blue:100.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        button.layer.borderWidth = 0.5;
        button.layer.borderColor = [UIColor colorWithDisplayP3Red:135.0 / 255.0 green:135.0 / 255.0 blue:135.0 / 255.0 alpha:1].CGColor;
        button.layer.cornerRadius = 3;
        
        [button addTarget:self action:@selector(delectAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:self.arr[i] forState:UIControlStateNormal];
        [self.delectBackGroundView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.delectBackGroundView.mas_centerY);
            make.right.mas_equalTo(self.delectBackGroundView.mas_right).offset(-15*WidthScale-(70*WidthScale+10*WidthScale)*i);
            make.size.mas_equalTo(CGSizeMake(70*WidthScale, 25*HeightScale));
        }];
        
    }
    
}


#pragma mark  删除按钮的响应事件
- (void)delectAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(orderTableViewCell:didClickDelectedBtn:tag:)]) {
        [_delegate orderTableViewCell:self didClickDelectedBtn:sender tag:sender.tag] ;
    }
    
}


#pragma mark 拦截frame的set方法
//-(void)setFrame:(CGRect)frame{
//    frame.origin.y += 10;
//    frame.size.height -=10;
//    
//    [super setFrame:frame];
//    
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
