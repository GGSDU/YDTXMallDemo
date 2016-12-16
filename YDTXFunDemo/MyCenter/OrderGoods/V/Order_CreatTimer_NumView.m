//
//  Order_CreatTimer_NumView.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/13.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_CreatTimer_NumView.h"
#import "OrderGoodsModel.h"

@interface Order_CreatTimer_NumView  ()


@property (nonatomic, strong) UILabel *orderNumLabel;//订单号
@property (nonatomic, strong) UILabel *creat_timeLabel;//下单时间


@end


@implementation Order_CreatTimer_NumView

- (UILabel *)orderNumLabel {
    if (!_orderNumLabel) {
        _orderNumLabel = [UILabel new];
        [_orderNumLabel sizeToFit];
        _orderNumLabel.textColor = RGB(146, 146, 146);
        _orderNumLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self addSubview:_orderNumLabel];
        [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10*WidthScale);
        }];
    }
    return _orderNumLabel;
}

- (UILabel *)creat_timeLabel {
    if (!_creat_timeLabel) {
        _creat_timeLabel = [UILabel new];
        [_creat_timeLabel sizeToFit];
        _creat_timeLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _creat_timeLabel.textColor = RGB(146, 146, 146);
        [self addSubview:_creat_timeLabel];
        [_creat_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.orderNumLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.orderNumLabel.mas_left);
        }];
    }
    return _creat_timeLabel;
}


- (instancetype)initWithFrame:(CGRect)frame orderModel:(OrderGoodsModel *)model {
    if (self = [super initWithFrame:frame]) {
        
        self.orderNumLabel.text = [@"订单号：" stringByAppendingString:model.goods_order_num];
        self.creat_timeLabel.text = [@"下单时间：" stringByAppendingString:model.create_time];
        
        
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
