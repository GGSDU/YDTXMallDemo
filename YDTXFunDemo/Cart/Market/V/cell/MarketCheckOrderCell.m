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

        [self setBasic];
        [self setUI];
    }
    
    return self;
}


-(void)setBasic{

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor colorForHex:@"eeeeee"];

}
-(void)setUI{

//顶层的一个父view

    UIView *topBaseView = [[UIView alloc]init];
    topBaseView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:topBaseView];
    [topBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(130);
        make.top.equalTo(self.contentView);
        make.leading.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);

    }];
    
    //商品图片imgView
    UIImageView *ImgView = [[UIImageView alloc]init];
    ImgView.backgroundColor = [UIColor redColor];
    [topBaseView addSubview:ImgView];
    [ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBaseView).offset(15);
        make.leading.equalTo(topBaseView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //商品名Label
    UILabel *goodsNameLabel = [[UILabel alloc]init];
    goodsNameLabel.numberOfLines = 2;
    goodsNameLabel.font = [UIFont systemFontOfSize:15];
    goodsNameLabel.text = @"钓箱";
    goodsNameLabel.textColor = [UIColor colorForHex:@"313131"];
    [topBaseView addSubview:goodsNameLabel];
    [goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ImgView);
        make.leading.equalTo(ImgView.mas_trailing).offset(10);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
    //型号Label
    UILabel *modelLabel = [[UILabel alloc]init];
    modelLabel.textColor = [UIColor colorForHex:@"7b7b7b"];
    modelLabel.font = [UIFont systemFontOfSize:15];
    modelLabel.text = @"型号:";
    [topBaseView addSubview:modelLabel];
    [modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(goodsNameLabel);
        make.top.equalTo(goodsNameLabel.mas_bottom).offset(18);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
    [goodsNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(modelLabel.mas_top).offset(-18);
    }];
    
    //价格Label
    UILabel *priceLabel =[[UILabel alloc]init];
    priceLabel.textColor = [UIColor colorForHex:@"e84a3e"];
    priceLabel.text = @"¥108";
    priceLabel.font = [UIFont systemFontOfSize:15];
    [topBaseView addSubview:priceLabel];
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
    [topBaseView addSubview:numLabel];
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(priceLabel);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
/*
 *底部父View
 *
 */
    UIView *bottomBaseView = [[UIView alloc]init];
    [self.contentView addSubview:bottomBaseView];
    bottomBaseView.backgroundColor = [UIColor whiteColor];
    [bottomBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBaseView.mas_bottom).offset(10);
        make.leading.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
        
    }];



    /*
     购买数量View
     */
    UIView *buyNumView = [[UIView alloc]init];
//    buyNumView.backgroundColor = [UIColor redColor];
    [bottomBaseView addSubview:buyNumView];
    [buyNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBaseView);
        make.leading.equalTo(bottomBaseView);
        make.trailing.equalTo(bottomBaseView);
        make.height.mas_equalTo(45);
    }];
    
    
    //购买数量TitleLabel
    UILabel *numTitleLabel = [[UILabel alloc]init];
    numTitleLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    numTitleLabel.font = [UIFont systemFontOfSize:15];
    numTitleLabel.text = @"购买数量";
    [buyNumView addSubview:numTitleLabel];
    [numTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyNumView);
        make.leading.equalTo(buyNumView).offset(15);
    }];
    
    //购买数量Label
    UILabel *bottomNumLabel = [[UILabel alloc]init];
    bottomNumLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    bottomNumLabel.font = [UIFont systemFontOfSize:15];
    bottomNumLabel.text = @"1";
    [buyNumView addSubview:bottomNumLabel];
    [bottomNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyNumView);
        make.trailing.equalTo(buyNumView).offset(-10);
    }];
    //添加分割线
    //分割线
    UIView * separateLineView = [[UIView alloc]init];
    separateLineView.backgroundColor = [UIColor colorForHex:@"e0e0e0"];
    [buyNumView addSubview:separateLineView];
    [separateLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(buyNumView).offset(15);
        make.trailing.equalTo(buyNumView).offset(-10);
        make.bottom.equalTo(buyNumView);
         make.height.mas_equalTo(1);
    }];


    
    
    
    /*
     优惠券View
     */
    //手势
    UITapGestureRecognizer *discountViewTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapDiscountView)];
    
    UIView *discountView = [[UIView alloc]init];
    [discountView addGestureRecognizer:discountViewTapGes];
    [bottomBaseView addSubview:discountView];
    [discountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buyNumView.mas_bottom);
        make.leading.equalTo(bottomBaseView);
        make.trailing.equalTo(bottomBaseView);
        make.height.mas_equalTo(45);
    }];
    
    
    //优惠券TitleLabel
    UILabel *discountTitleLabel = [[UILabel alloc]init];
    discountTitleLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    discountTitleLabel.font = [UIFont systemFontOfSize:15];
    discountTitleLabel.text = @"优惠券";
    [discountView addSubview:discountTitleLabel];
    [discountTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(discountView);
        make.leading.equalTo(discountView).offset(15);
    }];
    
    
    //view最右边的箭头button
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_rightBtn"] forState:UIControlStateNormal];
    rightBtn.userInteractionEnabled = NO;
    [discountView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(discountView).offset(-10);
        make.centerY.equalTo(discountView);
        
    }];
    

    
    //优惠情况Label
    UILabel *discountConditionLabel = [[UILabel alloc]init];
    discountConditionLabel.textColor = [UIColor colorForHex:@"9e9c9d"];
    discountConditionLabel.font = [UIFont systemFontOfSize:15];
    discountConditionLabel.text = @"无可用";
    [discountView addSubview:discountConditionLabel];
    [discountConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(discountView);
        make.trailing.equalTo(rightBtn.mas_leading).offset(-5);
    }];
    //添加分割线
    //分割线
    UIView * discountSeparateLine = [[UIView alloc]init];
    discountSeparateLine.backgroundColor = [UIColor colorForHex:@"e0e0e0"];
    [discountView addSubview:discountSeparateLine];
    [discountSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(discountView).offset(15);
        make.trailing.equalTo(discountView).offset(-10);
        make.bottom.equalTo(discountView);
        make.height.mas_equalTo(1);
    }];
    
    
    
    
    
    
    /*
     配送方式View
     */
    
    //手势
        UITapGestureRecognizer *distributeWayViewTapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapDistributeWayView)];
    UIView *distributeWayView = [[UIView alloc]init];
    [distributeWayView addGestureRecognizer:distributeWayViewTapGes];
    [bottomBaseView addSubview:distributeWayView];
    [distributeWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(discountView.mas_bottom);
        make.leading.equalTo(bottomBaseView);
        make.trailing.equalTo(bottomBaseView);
        make.height.mas_equalTo(45);
    }];
    
    
    //配送方式TitleLabel
    UILabel *distributeWayLabel = [[UILabel alloc]init];
    distributeWayLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    distributeWayLabel.font = [UIFont systemFontOfSize:15];
    distributeWayLabel.text = @"配送方式";
    [distributeWayView addSubview:distributeWayLabel];
    [distributeWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distributeWayView);
        make.leading.equalTo(distributeWayView).offset(15);
    }];
    
    
    //view最右边的箭头button
    UIButton *distributeRightBtn = [[UIButton alloc]init];
    [distributeRightBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_rightBtn"] forState:UIControlStateNormal];
    distributeRightBtn.userInteractionEnabled = NO;
    [distributeWayView addSubview:distributeRightBtn];
    [distributeRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(distributeWayView).offset(-10);
        make.centerY.equalTo(distributeWayView);
        
    }];
    
    
    
    //配送情况Label
    UILabel *distributeConditionLabel = [[UILabel alloc]init];
    distributeConditionLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    distributeConditionLabel.font = [UIFont systemFontOfSize:15];
    distributeConditionLabel.text = @"快递 免邮";
    [distributeWayView addSubview:distributeConditionLabel];
    [distributeConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(distributeWayView);
        make.trailing.equalTo(distributeRightBtn.mas_leading).offset(-5);
    }];
    //添加分割线
    //分割线
    UIView * distributeSeparateLine = [[UIView alloc]init];
    distributeSeparateLine.backgroundColor = [UIColor colorForHex:@"e0e0e0"];
    [distributeWayView addSubview:distributeSeparateLine];
    [distributeSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(distributeWayView).offset(15);
        make.trailing.equalTo(distributeWayView).offset(-10);
        make.bottom.equalTo(distributeWayView);
        make.height.mas_equalTo(1);
    }];

    
    /*
     *  小计View
     */
    UIView *partCountView = [[UIView alloc]init];
    [bottomBaseView addSubview:partCountView];
    [partCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(distributeWayView.mas_bottom);
        make.leading.equalTo(bottomBaseView);
        make.trailing.equalTo(bottomBaseView);
        make.bottom.equalTo(bottomBaseView);
    }];
    //小计Label
    
    UILabel *partCountLabel = [[UILabel alloc]init];
    partCountLabel.backgroundColor = [UIColor whiteColor];
    partCountLabel.font = [UIFont systemFontOfSize:15];
    partCountLabel.text = @"共1件商品    小计：¥108";
    partCountLabel.textAlignment = NSTextAlignmentRight;
    
    //处理富文本
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:partCountLabel.text];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorForHex:@"e84a3e"]
                    range:NSMakeRange(12, partCountLabel.text.length - 12)];
    partCountLabel.attributedText = attrStr;
    
    [partCountView addSubview:partCountLabel];
    [partCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partCountView);
        make.trailing.equalTo(partCountView).offset(-10);
    }];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark --TapGestureMethod
-(void)TapDiscountView{

    NSLog(@"-TapDiscountView-");

}

-(void)TapDistributeWayView{

    NSLog(@"-TapDistributeWayView-");


}
@end
