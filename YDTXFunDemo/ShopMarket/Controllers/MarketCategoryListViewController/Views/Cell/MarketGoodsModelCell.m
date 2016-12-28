//
//  MarketGoodsModelCell.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/22.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "MarketGoodsModelCell.h"
@interface MarketGoodsModelCell()





@end

@implementation MarketGoodsModelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];

    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
    }
    return self;
}

-(void)setup{
    self.layer.borderColor = RGB(211, 211, 211).CGColor;
    self.layer.borderWidth = 0.8;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;

//    [self.modelBtn setTitleColor:RGB(250, 250, 250) forState:UIControlStateNormal];
//    [self.modelBtn setTitleColor:RGB(255, 114, 0) forState:UIControlStateSelected];
}

-(void)setMarketProductModel:(MarketProductModel *)marketProductModel{
    _marketProductModel = marketProductModel;

    
    if (marketProductModel.quantity == 0 || !marketProductModel.quantity ) {
        
        self.userInteractionEnabled = NO;
        [_modelBtn setTitleColor:RGB(211, 211, 211) forState:UIControlStateNormal];
    }
    
    
    
    [_modelBtn setTitle:marketProductModel.model forState:UIControlStateNormal];
    
    
}


#pragma 提供给外部的方法




@end
