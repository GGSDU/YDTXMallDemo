//
//  CartCellOperationView.m
//  YDTXFunDemo
//
//  Created by Story5 on 08/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CartCellOperationView.h"

@interface CartCellOperationView ()

@property (nonatomic,strong) UILabel *totalPriceLabel;
@property (nonatomic,strong) UIButton *operationButton;


@end

@implementation CartCellOperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - public methods
- (void)updateOperationButtonTitle:(NSString *)title
{
    [_operationButton setTitle:title forState:UIControlStateNormal];
    
    
    if ([title isEqualToString:@"结算"]) {
        _totalPriceLabel.hidden = NO;
    } else if ([title isEqualToString:@"删除"]) {
        _totalPriceLabel.hidden = YES;
    }
}

- (void)updateTotalPrice:(float)price
{
    NSString *priceString = [NSString stringWithFormat:@"合计: ¥%.2f",price];
    NSRange blackRange = [priceString rangeOfString:@"合计: "];
    NSRange allRange = [priceString rangeOfString:priceString];
    NSMutableAttributedString *masPrice = [[NSMutableAttributedString alloc] initWithString:priceString];
    [masPrice addAttribute:NSForegroundColorAttributeName value:RGB(255, 75, 1) range:allRange];
    [masPrice addAttribute:NSForegroundColorAttributeName value:RGB(56, 56, 56) range:blackRange];
    
    _totalPriceLabel.attributedText = masPrice;
}

#pragma mark - touch event
- (void)allChooseButtonClicked:(UIButton *)aSender
{
    aSender.selected = !aSender.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(cartCellOperationView:didSelectedAllChooseButton:)]) {
        [_delegate performSelector:@selector(cartCellOperationView:didSelectedAllChooseButton:) withObject:self withObject:aSender];
    }
}

- (void)operationButtonClicked:(UIButton *)aSender
{
    if ([aSender.currentTitle isEqualToString:@"结算"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(cartCellOperationView:didSelectedSettleAccountButton:)]) {
            [_delegate performSelector:@selector(cartCellOperationView:didSelectedSettleAccountButton:) withObject:self withObject:aSender];
        }
    } else if ([aSender.currentTitle isEqualToString:@"删除"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(cartCellOperationView:didSelectedDeleteListButton:)]) {
            [_delegate performSelector:@selector(cartCellOperationView:didSelectedDeleteListButton:) withObject:self withObject:aSender];
        }
    }
}

#pragma mark - init UI
- (void)createUI{
    
    // allChooseButton
    _allChooseButton = [[UIButton alloc] init];
    [_allChooseButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Normal"] forState:UIControlStateNormal];
    [_allChooseButton setImage:[UIImage imageNamed:@"Cart_CellStatusButton_Selected"] forState:UIControlStateSelected];
    [_allChooseButton addTarget:self action:@selector(allChooseButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_allChooseButton];
    [_allChooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    // allChooseLabel
    UILabel *allChooseLabel = [[UILabel alloc] init];
    allChooseLabel.font = [UIFont systemFontOfSize:15];
    allChooseLabel.adjustsFontSizeToFitWidth = YES;
    allChooseLabel.textColor = RGB(56, 56, 56);
    allChooseLabel.text = @"全选";
    [self addSubview:allChooseLabel];
    [allChooseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(_allChooseButton).offset(0);
        make.left.equalTo(_allChooseButton.mas_right).offset(10);
        
    }];
    
    [_allChooseButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(allChooseLabel.mas_left).offset(-10);
        
    }];
    
    // totalPricelabel
    float defaultPrice = 0.0f;
    _totalPriceLabel = [[UILabel alloc] init];
    _totalPriceLabel.font = allChooseLabel.font;
    _totalPriceLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_totalPriceLabel];
    [self updateTotalPrice:defaultPrice];
    [_totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_allChooseButton).offset(0);
        make.left.greaterThanOrEqualTo(allChooseLabel.mas_right);
    }];
    
    // settleAccountButton
    _operationButton = [[UIButton alloc] init];
    _operationButton.backgroundColor = RGB(255, 75, 1);
    _operationButton.titleLabel.font = [UIFont systemFontOfSize:18];
    _operationButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [_operationButton setTitle:@"结算" forState:UIControlStateNormal];
    [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_operationButton addTarget:self action:@selector(operationButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_operationButton];
    [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.width.mas_equalTo(100);
        make.height.equalTo(self.mas_height);
    }];
    
    [_totalPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_operationButton.mas_left).offset(-10);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
