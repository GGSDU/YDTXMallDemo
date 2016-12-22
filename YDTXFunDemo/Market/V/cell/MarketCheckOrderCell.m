//
//  MarketCheckOrderCell.m
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketCheckOrderCell.h"

@interface MarketCheckOrderCell ()

@property(strong,nonatomic)UIImageView *ImgView;
@property(strong,nonatomic)UILabel *goodsNameLabel;
@property(strong,nonatomic)UILabel *modelLabel;
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UILabel *numLabel;

@property(strong,nonatomic)UILabel *bottomNumLabel;
@property(strong,nonatomic)UILabel *discountConditionLabel;
@property(strong,nonatomic)UILabel *distributeConditionLabel;
@property(strong,nonatomic)UILabel *partCountLabel;

@end


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
    _ImgView = [[UIImageView alloc]init];
    _ImgView.backgroundColor = [UIColor redColor];
    [topBaseView addSubview:_ImgView];
    [_ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topBaseView).offset(15);
        make.leading.equalTo(topBaseView).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    //商品名Label
    _goodsNameLabel = [[UILabel alloc]init];
    _goodsNameLabel.numberOfLines = 2;
    _goodsNameLabel.font = [UIFont systemFontOfSize:15];
    _goodsNameLabel.text = @"xx";
    _goodsNameLabel.textColor = [UIColor colorForHex:@"313131"];
    [topBaseView addSubview:_goodsNameLabel];
    [_goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_ImgView);
        make.leading.equalTo(_ImgView.mas_trailing).offset(10);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
    //型号Label
    _modelLabel = [[UILabel alloc]init];
    _modelLabel.textColor = [UIColor colorForHex:@"7b7b7b"];
    _modelLabel.font = [UIFont systemFontOfSize:15];
    _modelLabel.text = @"型号:xx";
    [topBaseView addSubview:_modelLabel];
    [_modelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_goodsNameLabel);
        make.top.equalTo(_goodsNameLabel.mas_bottom).offset(18);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
    [_goodsNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_modelLabel.mas_top).offset(-18);
    }];
    
    //价格Label
    _priceLabel =[[UILabel alloc]init];
    _priceLabel.textColor = [UIColor colorForHex:@"e84a3e"];
    _priceLabel.text = @"¥xxx.xx";
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [topBaseView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_modelLabel.mas_bottom).offset(18);
        make.leading.equalTo(_modelLabel);
        make.width.mas_equalTo(60);
    }];
    
    [_modelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_priceLabel.mas_top).offset(-18);
    }];
    
    //购买数量Label
    _numLabel = [[UILabel alloc]init];
    _numLabel.textColor = [UIColor colorForHex:@"666666"];
    _numLabel.font = [UIFont systemFontOfSize:15];
    _numLabel.text = @"x1";
    [topBaseView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLabel);
        make.trailing.equalTo(topBaseView).offset(-10);
    }];
    
    
//    //分割线
//    UIView *topBaseViewSeparateLine = [[UIView alloc]init];
//    topBaseViewSeparateLine.backgroundColor = [UIColor colorForHex:@"e0e0e0"];
//    [topBaseView addSubview:topBaseViewSeparateLine];
//    [topBaseViewSeparateLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(topBaseView);
//        make.trailing.equalTo(topBaseView);
//        make.bottom.equalTo(topBaseView);
//        make.height.mas_equalTo(1);
//    }];
    
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
    _bottomNumLabel = [[UILabel alloc]init];
    _bottomNumLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    _bottomNumLabel.font = [UIFont systemFontOfSize:15];
    _bottomNumLabel.text = @"1";
    [buyNumView addSubview:_bottomNumLabel];
    [_bottomNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _discountConditionLabel = [[UILabel alloc]init];
    _discountConditionLabel.textColor = [UIColor colorForHex:@"9e9c9d"];
    _discountConditionLabel.font = [UIFont systemFontOfSize:15];
    _discountConditionLabel.text = @"无可用";
    [discountView addSubview:_discountConditionLabel];
    [_discountConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _distributeConditionLabel = [[UILabel alloc]init];
    _distributeConditionLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    _distributeConditionLabel.font = [UIFont systemFontOfSize:15];
    _distributeConditionLabel.text = @"快递 免邮";
    [distributeWayView addSubview:_distributeConditionLabel];
    [_distributeConditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    _partCountLabel = [[UILabel alloc]init];
    _partCountLabel.backgroundColor = [UIColor whiteColor];
    _partCountLabel.font = [UIFont systemFontOfSize:15];
    _partCountLabel.text = @"共x件商品    小计：¥xxx";
    _partCountLabel.textAlignment = NSTextAlignmentRight;
    
    //处理富文本
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_partCountLabel.text];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor colorForHex:@"e84a3e"]
                    range:NSMakeRange(12, _partCountLabel.text.length - 12)];
    _partCountLabel.attributedText = attrStr;
    
    [partCountView addSubview:_partCountLabel];
    [_partCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partCountView);
        make.trailing.equalTo(partCountView).offset(-10);
    }];

    
}

#pragma mark --setModel
-(void)setMarketCheckModel:(marketCheckModel *)marketCheckModel{
    _marketCheckModel = marketCheckModel;
    
    _totalPrice += marketCheckModel.price;

}


#pragma mark --TapGestureMethod
-(void)TapDiscountView{

    NSLog(@"-TapDiscountView-");

}

-(void)TapDistributeWayView{

    NSLog(@"-TapDistributeWayView-");


}
@end
