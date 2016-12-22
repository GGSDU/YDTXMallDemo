//
//  MarketGoodsModelCell.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/22.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "MarketGoodsModelCell.h"
@interface MarketGoodsModelCell()

@property (weak, nonatomic) IBOutlet UIButton *modelBtn;


@end

@implementation MarketGoodsModelCell

- (void)awakeFromNib {
    [self setup];
    [super awakeFromNib];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
        
    }
    return self;
}

-(void)setup{
    _modelBtn.layer.borderColor = RGB(211, 211, 211).CGColor;
    _modelBtn.layer.borderWidth = 0.8;
    _modelBtn.layer.cornerRadius = 5;
    _modelBtn.layer.masksToBounds = YES;


}

-(void)setMarketProductModel:(marketProductModel *)marketProductModel{
    _marketProductModel = marketProductModel;

    [_modelBtn setTitle:marketProductModel.model forState:UIControlStateNormal];
    
}
@end
