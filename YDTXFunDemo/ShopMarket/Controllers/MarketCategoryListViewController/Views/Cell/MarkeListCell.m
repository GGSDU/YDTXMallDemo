//
//  markeListCell.m
//  market
//
//  Created by RookieHua on 2016/12/7.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarkeListCell.h"

@interface MarkeListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *payLabel;
@property (weak, nonatomic) IBOutlet UILabel *total_numLabel;

@end

@implementation MarkeListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(void)setMarkeListModel:(MarketListModel *)markeListModel{
    
    _markeListModel = markeListModel;
    
    //商品图片
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:markeListModel.images_url] placeholderImage:[UIImage imageNamed:@"zwt"]];
    
    //商品名
    self.nameLabel.text = markeListModel.name;
    
    //原价
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",markeListModel.price];
    
    //会员价
    self.payLabel.text = [NSString stringWithFormat:@"￥%.2f",markeListModel.pay];
    
    //月销量
    self.total_numLabel.text = [NSString stringWithFormat:@"月销量：%d",markeListModel.total_num];
    
    

}

@end
