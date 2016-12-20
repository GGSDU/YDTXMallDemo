//
//  CartDefaultView.m
//  YDTXFunDemo
//
//  Created by Story5 on 20/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CartDefaultView.h"

@interface CartDefaultView ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIButton *button;

@end

@implementation CartDefaultView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

- (void)buttonClick:(UIButton *)aSender
{
    NSLog(@"去看看");
}

#pragma mark - createUI
- (void)createUI{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.textColor = RGB(103, 103, 103);
        _label.font = [UIFont systemFontOfSize:16];
        [self addSubview:_label];
    }
    
    if (_button == nil) {
        _button = [[UIButton alloc] init];
        _button.layer.borderColor = RGB(84, 182, 255).CGColor;
        _button.layer.borderWidth = 1;
        _button.layer.cornerRadius = 10;
        [_button setTitleColor:RGB(84, 182, 255) forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];
    }
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(146);
        make.centerX.equalTo(self);
        make.bottom.equalTo(_label.mas_top).offset(-30);
    }];
    
   
    _label.backgroundColor = [UIColor redColor];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageView.mas_bottom).offset(30);
        make.centerX.equalTo(self);
        make.bottom.equalTo(_button.mas_top).offset(-40);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(16);
    }];
    
    
    
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_label).offset(40);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(40);
        
    }];

    
    _imageView.image = [UIImage imageNamed:@"defaultCart"];
    _label.text = @"购物车空空如也～";
    [_button setTitle:@"去看看" forState:UIControlStateNormal];
    
}

@end
