//
//  MarketMaskView.m
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketMaskView.h"

#import "PPNumberButton.h"
@interface MarketMaskView ()

@property(strong,nonatomic)UIView *maskView;//遮罩view
@property(strong,nonatomic)UIView *baseView;//进行商品信息选择的baseView


@end




@implementation MarketMaskView
//Lazy


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];//创建界面
    }
    return self;
}


//布局界面
-(void)setUI{
    
//底部的maskView
    
    UIView *maskView = [[UIView alloc]initWithFrame:self.bounds];
    
    [maskView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    self.maskView = maskView;
    [self addSubview:maskView];
    //添加点击手势  当用户点击的时候移除self
    UITapGestureRecognizer *tapRemoveSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(RemoveSelf)];
    [maskView addGestureRecognizer:tapRemoveSelf];
    
//baseView
     UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, YDTXScreenH , YDTXScreenW, 418)];
    
    baseView.backgroundColor = [UIColor yellowColor];
    self.baseView = baseView;
//    baseView.userInteractionEnabled = NO;
    [self addSubview:baseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        baseView.frame = CGRectMake(0, YDTXScreenH -418, YDTXScreenW, 418);
        
    }];


//右上角的关闭btn
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"market_MaskView_closeBtn"] forState:UIControlStateNormal];
    [baseView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(baseView).offset(-10);
        make.centerY.equalTo(baseView.mas_top);
    }];
    
//imageView
    UIImageView *ImgView = [[UIImageView alloc]init];
    ImgView.backgroundColor = [UIColor redColor];
    ImgView.layer.borderWidth = 2;
    ImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    ImgView.layer.cornerRadius = 5;
    ImgView.layer.masksToBounds = YES;
    [baseView addSubview:ImgView];
    [ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125, 125));
        make.leading.equalTo(baseView).offset(15);
        make.top.equalTo(baseView).offset(-15);
    }];

//商品Label
    UILabel *goodsTitleLabel = [[UILabel alloc]init];
    goodsTitleLabel.numberOfLines = 2;
    goodsTitleLabel.font = [UIFont systemFontOfSize:16];
    goodsTitleLabel.textColor = [UIColor blackColor];
    goodsTitleLabel.text = @"台钓箱2016新款迷你小钓箱轻便轻巧钓箱22L";
    [baseView addSubview:goodsTitleLabel];
    [goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ImgView.mas_trailing).offset(10);
        make.top.equalTo(baseView).offset(30);
        make.trailing.equalTo(baseView).offset(-10);
    }];
    
//价格Label
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.numberOfLines = 1;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.text = @"¥108";
    [baseView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(goodsTitleLabel);
        make.top.equalTo(goodsTitleLabel.mas_bottom).offset(20);
    }];
    
//型号Label
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"型号";
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.textColor = [UIColor blackColor];
    [baseView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ImgView);
        make.top.equalTo(ImgView.mas_bottom).offset(15);
        
    }];
    

    //购买数量Label
    UILabel *buyNumLabel = [[UILabel alloc]init];
    buyNumLabel.text = @"购买数量";
    buyNumLabel.font = [UIFont systemFontOfSize:16];
    buyNumLabel.textColor = [UIColor blackColor];
    [baseView addSubview:buyNumLabel];
    [buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(ImgView);
        make.top.equalTo(typeLabel.mas_bottom).offset(75);
        
    }];
    

//加入购物车btn
    UIButton *addToCartBtn = [[UIButton alloc]init];
    [addToCartBtn setBackgroundColor:[UIColor orangeColor]];
    addToCartBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [addToCartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [baseView addSubview:addToCartBtn];
    [addToCartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(baseView);
        make.leading.equalTo(baseView);
        make.trailing.equalTo(baseView);
        make.height.mas_equalTo(50);
    }];
    
    
//加减数量btn与textfiled

    
    PPNumberButton *numberButton = [[PPNumberButton alloc]init];;
    numberButton.shakeAnimation = YES;
//    numberButton.increaseImage = [UIImage imageNamed:@"购物车添加"];
//    numberButton.decreaseImage = [UIImage imageNamed:@"购物车减少"];
    //设置边框颜色
    numberButton.borderColor = [UIColor grayColor];
    
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    numberButton.inputFieldFont = 14;
    
    numberButton.resultBlock = ^(NSString *num){
        NSLog(@"%@",num);
    };
    
    [baseView addSubview:numberButton];
    [numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyNumLabel);
        make.trailing.equalTo(baseView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    
}

-(void)RemoveSelf{
//首先移除自己
    
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, YDTXScreenH , YDTXScreenW, 418);
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];

       //将父视图还原
        if ([self.delegate respondsToSelector:@selector(removeMarketVCAnimation)]) {
            
            [self.delegate removeMarketVCAnimation];
        }
    }];
    
    
    


}

-(void)creatWithImgUrl:(NSString *)ImgUrl Title:(NSString *)title Price:(NSString *)price DataArray:(NSArray *)dataArr BtnTitle:(NSString *)btnTitle{




}
@end
