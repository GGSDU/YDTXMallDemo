//
//  OrderDrawBackView.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "OrderDrawBackView.h"

@interface OrderDrawBackView ()<UITextViewDelegate>

@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *button;

@end

@implementation OrderDrawBackView

- (UIView *)drawBackStatusBackGroundView {
    if (!_drawBackStatusBackGroundView) {
        _drawBackStatusBackGroundView = [[UIView alloc]init];
        _drawBackStatusBackGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_drawBackStatusBackGroundView];
        
        [_drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(18*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10*WidthScale);
            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    return _drawBackStatusBackGroundView;
}


- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15*HeightScale];
        [self addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left);
            make.width.mas_equalTo(self.drawBackStatusBackGroundView.mas_width);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    
    return _textView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"] forState:UIControlStateNormal];
        [self addSubview:_button];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView.mas_left);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.top.mas_equalTo(self.textView.mas_bottom).offset(20*HeightScale);
        }];
        
    }
    return _button;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self.drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(18*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10*WidthScale);
            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
            make.height.mas_equalTo(40*HeightScale);
        }];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left);
            make.width.mas_equalTo(self.drawBackStatusBackGroundView.mas_width);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    
    
    return self;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200*HeightScale);
    }];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
