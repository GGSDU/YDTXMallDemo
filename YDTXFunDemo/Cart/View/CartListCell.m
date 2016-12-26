//
//  CartListCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CartListCell.h"


@interface CartListCell ()

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIImageView *infoImageView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UILabel *priceLabel;


@property (nonatomic,strong) UIButton *disabledButton;
@property (nonatomic,strong) UILabel *disabledLabel;

@end

@implementation CartListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createView];
    }
    return self;
}

#pragma mark - public methods
- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.backgroundColor = enabled ?  RGB(255, 255, 255) : RGB(244, 244, 244);
    self.mainView.backgroundColor = self.backgroundColor;
    self.mainView.userInteractionEnabled = enabled;
    
    self.disabledLabel.hidden = enabled;
    self.adjustNumberView.hidden = !self.disabledLabel.hidden;
    enabled ? [self.mainView sendSubviewToBack:self.disabledLabel] : [self.mainView bringSubviewToFront:self.disabledLabel];
}

- (void)setEdited:(BOOL)edited
{
    _edited = edited;
    self.disabledButton.hidden = self.enabled || edited;
    self.cellSelectButton.hidden = !self.disabledButton.hidden;
}

- (void)updateDisabledCellEditStaus:(BOOL)edited
{
    self.disabledButton.hidden = edited;
    self.cellSelectButton.hidden = edited;
}

- (void)updateCellStatusButtonSelected:(BOOL)selected
{
    _cellSelectButton.selected = selected;
}

- (void)setProductNumber:(int)productNumber
{
    NSAssert(productNumber >= 1, @"productNumber must >= 1");
    _productNumber = productNumber;
    _adjustNumberView.number = _productNumber;
    
}

- (void)setUpdateNumberBlock:(UpdateNumberBlock)updateNumberBlock
{
    _updateNumberBlock = updateNumberBlock;
    self.adjustNumberView.updateNumberBlock = _updateNumberBlock;
}

- (void)setCartProductModel:(CartProductModel *)cartProductModel
{
    _cartProductModel = cartProductModel;
    
    [self.infoImageView sd_setImageWithURL:[SXPublicTool getImageURLByURLString:cartProductModel.images_url]];
    self.label.text = cartProductModel.goods_name;
    self.detailLabel.text = [NSString stringWithFormat:@"型号:%@",cartProductModel.models];
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f",cartProductModel.price];
    self.productNumber = cartProductModel.nums;
    
    
    self.adjustNumberView.maxValue = cartProductModel.quantity;
}

#pragma mark - touch event
- (void)cellStatusButtonClick:(UIButton *)aSender
{
    _cellSelectButton.selected = !_cellSelectButton.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(cartListCell:didSelectedCell:)]) {
        [_delegate performSelector:@selector(cartListCell:didSelectedCell:) withObject:self withObject:self.cartProductModel];
    }
}


#pragma mark - UI
- (void)createView
{
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainView];
    }
    
    [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(37);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
//        make.edges.equalTo(self.contentView);
    }];
    
    if (_cellSelectButton == nil) {
        _cellSelectButton = [[UIButton alloc] init];
        [_cellSelectButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Normal"] forState:UIControlStateNormal];
        [_cellSelectButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Selected"] forState:UIControlStateSelected];
        [_cellSelectButton addTarget:self action:@selector(cellStatusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cellSelectButton];
    }
    [_cellSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mainView.mas_centerY);
        make.centerX.equalTo(self.mainView.mas_left).dividedBy(2);
        //            make.left.greaterThanOrEqualTo(self.mainView.mas_left);
        //            make.right.lessThanOrEqualTo(self.infoImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
}


- (UIButton *)disabledButton
{
    if (_disabledButton == nil) {
        _disabledButton = [[UIButton alloc] init];
        _disabledButton.layer.cornerRadius = 5;
        _disabledButton.backgroundColor = RGB(169, 169, 169);
        _disabledButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_disabledButton setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_disabledButton setTitle:@"失效" forState:UIControlStateNormal];
        [self.contentView addSubview:_disabledButton];
    }
    
    [_disabledButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mainView.mas_centerY);
        make.centerX.equalTo(self.mainView.mas_left).dividedBy(2);
        //            make.left.greaterThanOrEqualTo(self.mainView.mas_left);
        //            make.right.lessThanOrEqualTo(self.infoImageView.mas_left);
        make.size.mas_equalTo(CGSizeMake(30, 18));
    }];
    return _disabledButton;
}

- (UIImageView *)infoImageView
{
    if (_infoImageView == nil) {
        _infoImageView = [[UIImageView alloc] init];
     
        [self.mainView addSubview:_infoImageView];
        
        [_infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_top).offset(15);
            make.left.equalTo(self.mainView);
            make.right.equalTo(self.label.mas_left).offset(-10);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _infoImageView;
}

- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15];
        _label.adjustsFontSizeToFitWidth = YES;
        _label.textColor = RGB(58, 58, 58);
        _label.numberOfLines = 2;
        [self.mainView addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_top).offset(22);
            make.left.equalTo(self.infoImageView.mas_right).offset(10);
            make.bottom.equalTo(self.detailLabel.mas_top).offset(-15);
            [make.right.equalTo(self.priceLabel.mas_left).offset(-40) priorityLow];
            
        }];
    }
    return _label;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        _detailLabel.textColor = RGB(183, 183, 183);
        [self.mainView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.label.mas_bottom).offset(15);
            make.left.equalTo(self.label.mas_left).offset(0);
//            make.bottom.equalTo(self.adjustNumberView).offset(-12);
            make.right.equalTo(self.label.mas_right).offset(0);
            
        }];
    }
    return _detailLabel;
}


- (UILabel *)priceLabel
{
    if (_priceLabel == nil) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = RGB(238, 69, 66);
        [self.mainView addSubview:_priceLabel];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_top).offset(22);
            make.left.equalTo(self.label.mas_right).offset(40);
            [make.right.equalTo(self.mainView.mas_right).offset(-10) priorityHigh];
        }];
    }
    return _priceLabel;
}

- (SXAdjustNumberView *)adjustNumberView
{
    if (_adjustNumberView == nil) {
        _adjustNumberView = [[SXAdjustNumberView alloc] init];
        __weak typeof(self) weakSelf = self;
        _adjustNumberView.updateNumberBlock = ^(int number) {
            weakSelf.cartProductModel.nums = number;
        };
        [self.mainView addSubview:_adjustNumberView];
    }
    [_adjustNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.detailLabel.mas_bottom).offset(12);
        make.left.equalTo(self.label.mas_left).offset(0);
        make.bottom.equalTo(self.infoImageView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    return _adjustNumberView;
}

- (UILabel *)disabledLabel
{
    if (_disabledLabel == nil) {
        _disabledLabel = [[UILabel alloc] init];
        _disabledLabel.adjustsFontSizeToFitWidth = YES;
        _disabledLabel.font = [UIFont systemFontOfSize:15];
        _disabledLabel.textColor = RGB(183, 183, 183);
        _disabledLabel.text = @"宝贝已失效";
        [self.mainView addSubview:_disabledLabel];
        
        
        _disabledLabel.hidden = YES;
        [self.mainView sendSubviewToBack:_disabledLabel];
    }
    [_disabledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(12);
        make.left.equalTo(self.label.mas_left).offset(0);
        make.bottom.equalTo(self.infoImageView.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    return _disabledLabel;
}

@end
