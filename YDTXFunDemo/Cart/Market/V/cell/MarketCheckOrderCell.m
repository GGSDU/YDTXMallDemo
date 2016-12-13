//
//  MarketCheckOrderCell.m
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketCheckOrderCell.h"

@implementation MarketCheckOrderCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    if(self){
    
        [self setUI];
    }
    
    return self;
}

-(void)setUI{

//顶层的一个父view
//    for (UIView *view in self.subviews) {
//        NSLog(@"***** %p,%@",view,NSStringFromClass([view class]));
//    }
    NSLog(@"%p , contentView bounds = %@",self,NSStringFromCGRect(self.contentView.bounds));
    UIView *baseView = [[UIView alloc]init];
//    baseView.backgroundColor = [UIColor redColor];
//    baseView.frame = CGRectMake(0, 0, 370, 70);
    [self.contentView addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        NSLog(@"height");
        make.height.mas_equalTo(130);
        NSLog(@"top");
        make.top.equalTo(self.contentView);
        NSLog(@"leading");
        make.leading.equalTo(self.contentView);
        NSLog(@"trailing");
        make.trailing.equalTo(self.contentView);


//        make.edges.equalTo(self.contentView);
    }];
    
    //商品图片imgView
    UIImageView *ImgView = [[UIImageView alloc]init];
    ImgView.backgroundColor = [UIColor redColor];
    [baseView addSubview:ImgView];
    [ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(baseView).offset(15);
        make.leading.equalTo(baseView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //商品名Label
    UILabel *goodsNameLabel = [[UILabel alloc]init];
    goodsNameLabel.numberOfLines = 2;
    goodsNameLabel.font = [UIFont systemFontOfSize:15];
    goodsNameLabel.text = @"钓箱";
    goodsNameLabel.textColor = [UIColor colorForHex:@"313131"];
    [baseView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ImgView);
        make.leading.equalTo(ImgView.mas_trailing).offset(10);
        make.trailing.equalTo(baseView).offset(-10);
    }];
    
    //型号Label
    UILabel *modelLabel = [[UILabel alloc]init];
    modelLabel.textColor = [UIColor colorForHex:@"7b7b7b"];
    modelLabel.font = [UIFont systemFontOfSize:15];
    modelLabel.text = @"型号:";
    [baseView addSubview:modelLabel];
    [modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(goodsNameLabel);
        make.top.equalTo(goodsNameLabel.mas_bottom).offset(18);
        make.trailing.equalTo(baseView).offset(-10);
    }];
    
    [goodsNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(modelLabel.mas_top).offset(-18);
    }];
    
    //价格Label
    UILabel *priceLabel =[[UILabel alloc]init];
    priceLabel.textColor = [UIColor colorForHex:@"e84a3e"];
    priceLabel.text = @"¥108";
    priceLabel.font = [UIFont systemFontOfSize:15];
    [baseView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(modelLabel.mas_bottom).offset(18);
        make.leading.equalTo(modelLabel);
        make.width.mas_equalTo(60);
    }];
    
    [modelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(priceLabel.mas_top).offset(-18);
    }];
    
    //购买数量Label
    UILabel *numLabel = [[UILabel alloc]init];
    numLabel.textColor = [UIColor colorForHex:@"666666"];
    numLabel.font = [UIFont systemFontOfSize:15];
    numLabel.text = @"x1";
    [baseView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.trailing.equalTo(baseView).offset(-10);
    }];
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
