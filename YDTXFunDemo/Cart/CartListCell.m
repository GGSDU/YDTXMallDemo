//
//  CartListCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CartListCell.h"

#import "SXAdjustNumberView.h"

@interface CartListCell ()

@property (nonatomic,retain) UIView *mainView;
@property (nonatomic,retain) UIButton *cellSelectButton;
@property (nonatomic,retain) UIImageView *infoImageView;
@property (nonatomic,retain) UILabel *label;
@property (nonatomic,retain) UILabel *detailLabel;
@property (nonatomic,retain) UILabel *priceLabel;
@property (nonatomic,retain) SXAdjustNumberView *adjustNumberView;

@end

@implementation CartListCell

- (void)dealloc
{
    if (_productModel) {
        [_productModel release];
    }
    
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createView];
    }
    
    return self;
}

#pragma mark - public methods
- (void)updateCellStatusButtonSelected:(BOOL)selected
{
    _cellSelectButton.selected = selected;
}

#pragma mark - touch event
- (void)cellStatusButtonClick:(UIButton *)aSender
{
    _cellSelectButton.selected = !_cellSelectButton.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(cartListCell:didSelectedCell:)]) {
        [_delegate performSelector:@selector(cartListCell:didSelectedCell:) withObject:self withObject:self.productModel];
    }
}


#pragma mark - private methods
- (void)createView
{
    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));
    if (_mainView == nil) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mainView];
        [_mainView release];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    
    if (_cellSelectButton == nil) {
        _cellSelectButton = [[UIButton alloc] init];
        [_cellSelectButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Normal"] forState:UIControlStateNormal];
        [_cellSelectButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Selected"] forState:UIControlStateSelected];
        [_cellSelectButton addTarget:self action:@selector(cellStatusButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.mainView addSubview:_cellSelectButton];
        [_cellSelectButton release];
        [_cellSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mainView.mas_centerY);
            make.centerX.equalTo(self.infoImageView.mas_left).dividedBy(2);
//            make.left.greaterThanOrEqualTo(self.mainView.mas_left);
//            make.right.lessThanOrEqualTo(self.infoImageView.mas_left);
            make.size.mas_equalTo(CGSizeMake(18, 18));
            
        }];
    }
    
    if (_adjustNumberView == nil) {
        _adjustNumberView = [[SXAdjustNumberView alloc] init];
        _adjustNumberView.updateNumberBlock = ^(int number) {
            self.productModel.number = number;
        };
        [self.mainView addSubview:_adjustNumberView];
        [_adjustNumberView release];
        [_adjustNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.detailLabel.mas_bottom).offset(12);
            make.left.equalTo(self.label.mas_left).offset(0);
            make.bottom.equalTo(self.infoImageView.mas_bottom).offset(0);
            make.size.mas_equalTo(CGSizeMake(80, 25));
        }];
    }
}

#pragma mark - getter/setter
- (void)setProductModel:(ProductModel *)productModel
{
    _productModel = [productModel retain];
    
    [self.infoImageView sd_setImageWithURL:[NSURL URLWithString:productModel.infoImageURL] placeholderImage:[UIImage imageNamed:@"Image"]];
    self.label.text = productModel.infoName;
    self.detailLabel.text = productModel.modelType;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",productModel.price];
    self.productNumber = productModel.number;
}

- (UIImageView *)infoImageView
{
    if (_infoImageView == nil) {
        _infoImageView = [[UIImageView alloc] init];
     
        [self.mainView addSubview:_infoImageView];
        [_infoImageView release];
        
        [_infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_top).offset(15);
            make.left.equalTo(self.mainView.mas_left).offset(37);
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
        [_label release];
        
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
        [_detailLabel release];
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
        [_priceLabel release];
        [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_top).offset(22);
            make.left.equalTo(self.label.mas_right).offset(40);
            [make.right.equalTo(self.mainView.mas_right).offset(-10) priorityHigh];
        }];
    }
    return _priceLabel;
}

- (void)setProductNumber:(int)productNumber
{
    NSAssert(productNumber >= 1, @"productNumber must >= 1");
    _productNumber = productNumber;
    _adjustNumberView.number = _productNumber;
    
}

#pragma mark -
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
