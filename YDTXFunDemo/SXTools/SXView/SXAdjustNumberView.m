//
//  SXAdjustNumberView.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SXAdjustNumberView.h"

#import "Masonry.h"

@interface SXAdjustNumberView ()<UITextFieldDelegate>

@property (nonatomic,strong) UIButton *increaseButton;
@property (nonatomic,strong) UIButton *decreaseButton;
@property (nonatomic,strong) UITextField *numberTextField;

@property (nonatomic,strong) UIButton *tempButton;

@end

@implementation SXAdjustNumberView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
        
        _minValue = 1;
        _maxValue = NSIntegerMax;
        
    }
    return self;
}

#pragma mark - getter/setter
- (void)setMaxValue:(NSInteger)maxValue
{
    NSAssert(maxValue >= _minValue, @"maxValue must >= minValue");
    _maxValue = maxValue;
}

- (void)setNumber:(int)number
{
    NSAssert(number >= _minValue, @"number must >= %ld",_minValue);
    NSCAssert1(number <= _maxValue, @"number must <= %ld",_maxValue);
    
    _number = number;
    
    _numberTextField.text = [NSString stringWithFormat:@"%d",_number];
    
    if (_number > _minValue) {
        _decreaseButton.enabled = YES;
    } else if (_number == _minValue) {
        _decreaseButton.enabled = NO;
    }
    
    if (_number < _maxValue) {
        _increaseButton.enabled = YES;
    } else if (_number == _maxValue) {
        _increaseButton.enabled = NO;
    }
    
    self.updateNumberBlock(number);
}

#pragma mark - textField delegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSString *minValueString = [NSString stringWithFormat:@"%ld",_minValue];
    NSString *maxValueString = [NSString stringWithFormat:@"%ld",_maxValue];
    
    textField.text.integerValue < _minValue ? textField.text = minValueString : nil;
    textField.text.integerValue > _maxValue ? textField.text = maxValueString : nil;
    
    self.number = textField.text.intValue;
}

#pragma mark - touch event
- (void)decreaseButtonClick:(UIButton *)aSender
{
    self.number -= 1;
}

- (void)increaseButtonClick:(UIButton *)aSender
{
    self.number += 1;
}

#pragma mark - init UI
- (void)createUI{
    
    _decreaseButton = [[UIButton alloc] init];
    [_decreaseButton setImage:[UIImage imageNamed:@"Cart_Decrease_Normal"] forState:UIControlStateNormal];
    [_decreaseButton setImage:[UIImage imageNamed:@"Cart_Decrease_Disabled"] forState:UIControlStateDisabled];
    [_decreaseButton addTarget:self action:@selector(decreaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_decreaseButton];
    [_decreaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    
    _increaseButton = [[UIButton alloc] init];
    [_increaseButton setImage:[UIImage imageNamed:@"Cart_Increase"] forState:UIControlStateNormal];
    [_increaseButton addTarget:self action:@selector(increaseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_increaseButton];
    [_increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        
        make.size.equalTo(_decreaseButton);
    }];
    
    
    _numberTextField = [[UITextField alloc] init];
    _numberTextField.textAlignment = NSTextAlignmentCenter;
    _numberTextField.font = [UIFont systemFontOfSize:15];
    _numberTextField.backgroundColor = [UIColor whiteColor];
    _numberTextField.textColor = RGB(28, 28, 28);
    _numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    _numberTextField.delegate = self;
    [self addSubview:_numberTextField];
    [_numberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(_decreaseButton.mas_right).offset(0);
        make.right.equalTo(_increaseButton.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
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
