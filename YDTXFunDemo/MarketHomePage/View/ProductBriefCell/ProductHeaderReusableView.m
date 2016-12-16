//
//  ProductHeaderReusableView.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ProductHeaderReusableView.h"

@implementation ProductHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

#pragma mark -
- (void)createUI{
    
    
    _label = [[UILabel alloc] init];
    _label.textColor = RGB(252, 104, 6);
    _label.font = [UIFont systemFontOfSize:16];
    _label.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    UIImageView *leftLine = [[UIImageView alloc] init];
    leftLine.backgroundColor = RGB(210, 208, 209);
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(_label.mas_left).offset(-10);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *rightLine = [[UIImageView alloc] init];
    rightLine.backgroundColor = RGB(210, 208, 209);
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(_label.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-10);
        make.height.mas_equalTo(1);
    }];
}

@end
