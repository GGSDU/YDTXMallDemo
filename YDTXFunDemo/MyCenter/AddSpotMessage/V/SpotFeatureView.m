//
//  SpotFeatureView.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/19.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "SpotFeatureView.h"

@interface SpotFeatureView ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIView *backView;

@end

@implementation SpotFeatureView

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.text = @"塘口特色（可多选）";
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:15*HeightScale];
        [_label sizeToFit];
        [self addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10);
            
        }];
    }
    
    return _label;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.userInteractionEnabled = YES;
        [self addSubview:_backView];
        
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.label.mas_left);
            make.bottom.mas_equalTo(self.mas_bottom);
//            make.height.mas_equalTo(100*HeightScale);
            make.width.mas_equalTo(ScreenWidth);
        }];
        
        
    }
    return _backView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    
    NSArray *array = @[@"停车位",@"餐饮",@"住宿",@"棋牌",@"夜钓"];
    
    if (self) {
        self.userInteractionEnabled = YES;
        
        CGFloat width = (ScreenWidth-30)/3;
        for (int i = 0; i < 5; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(width*(i%3), i/3*40*HeightScale, width, 40*HeightScale);
            button.tag = 10+i;
            
            
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
            button.userInteractionEnabled = YES;
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
            if (i == 3) {
                [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
            }
            
            [self.backView addSubview:button];
            
            NSLog(@"self.backView frame is:%f",self.backView.frame.size.height);
            
        }
        
        
    }
    
    
    return self;
    
}

- (void) buttonAction:(UIButton *)sender {
    
    
    if (_delegate  && [_delegate respondsToSelector:@selector(didClickSpotStypeBtn:tag:)]) {
        [_delegate didClickSpotStypeBtn:sender tag:sender.tag];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
