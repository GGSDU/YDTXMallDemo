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

@property (strong, nonatomic) NSMutableArray *btnArr;

@end

@implementation SpotFeatureView

- (NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

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
            button.selected = NO;
            
            
            [button setTitleColor:RGB(113, 113, 113) forState:UIControlStateNormal];
            
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
            
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
/*
 (1=>停车位 2=>餐饮 3=>住宿 4=>棋牌 5=>夜钓)
 */
- (void) buttonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        switch (sender.tag - 10) {
            case 0:{
                [self.btnArr addObject:@"1"];
            }
                break;
            case 1:{
                [self.btnArr addObject:@"2"];
            }
                break;
            case 2:{
                [self.btnArr addObject:@"3"];
            }
                break;
            case 3:{
                [self.btnArr addObject:@"4"];
            }
                break;
            case 4:{
                [self.btnArr addObject:@"5"];
            }
                break;
                
            default:
                break;
        }
 
    } else {
        switch (sender.tag - 10) {
            case 0:{
                [self.btnArr removeObject:@"1"];
            }
                break;
            case 1:{
                [self.btnArr removeObject:@"2"];
            }
                break;
            case 2:{
                [self.btnArr removeObject:@"3"];
            }
                break;
            case 3:{
                [self.btnArr removeObject:@"4"];
            }
                break;
            case 4:{
                [self.btnArr removeObject:@"5"];
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    if (_delegate  && [_delegate respondsToSelector:@selector(didClickSpotStypeBtn:tag:array:)]) {
        [_delegate didClickSpotStypeBtn:sender tag:sender.tag array:self.btnArr];
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
