//
//  ProductDisplayView.m
//  YDTXFunDemo
//
//  Created by Story5 on 15/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "DisplayView.h"

#pragma mark - model
@implementation DisplayModel

@end

#pragma mark - view
@implementation DisplayView

- (void)setDisplayModel:(DisplayModel *)displayModel
{
    if (_displayModel == nil) {
        _displayModel = [[DisplayModel alloc] init];
    }
    
    _displayModel.imageURL = displayModel.imageURL;
    _displayModel.infoString = displayModel.infoString;
    _displayModel.price = displayModel.price;
    _displayModel.vipPrice = displayModel.vipPrice;
    _displayModel.saleNumber = displayModel.saleNumber;
    
    [self updateViewWithDisplayModel:_displayModel];
}

- (void)updateViewWithDisplayModel:(DisplayModel *)displayModel
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:displayModel.imageURL]
                      placeholderImage:[UIImage imageNamed:@"InfoImage"]];
    self.infoLabel.text = displayModel.infoString;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",displayModel.price];
    self.vipPriceLabel.text = [NSString stringWithFormat:@"会员:%.2f",displayModel.vipPrice];
    self.saleLabel.text = [NSString stringWithFormat:@"月销量%d",displayModel.saleNumber];
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
            make.size.mas_equalTo(CGSizeMake(175, 175));
            make.right.equalTo(self.mas_right);
        }];
    }
    return _imageView;
}

- (UILabel *)infoLabel
{
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.numberOfLines = 2;
        _infoLabel.font = [UIFont systemFontOfSize:15];
        _infoLabel.adjustsFontSizeToFitWidth = YES;
        _infoLabel.textColor = RGB(46, 46, 46);
        [self addSubview:_infoLabel];
        
        [_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(12);
            make.left.equalTo(self.mas_left).offset(12);
            make.bottom.equalTo(self.priceLabel.mas_top).offset(-12);
            make.right.equalTo(self.mas_right).offset(-12);
        }];
    }
    return _infoLabel;
}

- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.textColor = RGB(252, 28, 28);
        [self addSubview:_priceLabel];
        
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoLabel.mas_bottom).offset(12);
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self.saleLabel.mas_top).offset(-12);
        }];
    }
    return _priceLabel;
}

- (UILabel *)vipPriceLabel
{
    if (_vipPriceLabel == nil) {
        _vipPriceLabel = [[UILabel alloc] init];
        _vipPriceLabel.font = self.priceLabel.font;
        _vipPriceLabel.adjustsFontSizeToFitWidth = YES;
        _vipPriceLabel.textColor = RGB(252, 104, 6);
        [self addSubview:_vipPriceLabel];
        
        [_vipPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoLabel.mas_bottom).offset(12);
            make.bottom.equalTo(self.saleLabel.mas_top).offset(-12);
            make.right.equalTo(self).offset(-12);
        }];
    }
    return _vipPriceLabel;
}

- (UILabel *)saleLabel
{
    if (_saleLabel == nil) {
        _saleLabel = [[UILabel alloc] init];
        _saleLabel.font = [UIFont systemFontOfSize:10];
        _saleLabel.adjustsFontSizeToFitWidth = YES;
        _saleLabel.textColor = RGB(175, 175, 175);
        [self addSubview:_saleLabel];
        
        [_saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom).offset(12);
            make.left.equalTo(self).offset(12);
            make.bottom.equalTo(self).offset(-12);
        }];
    }
    return _saleLabel;
}

@end
