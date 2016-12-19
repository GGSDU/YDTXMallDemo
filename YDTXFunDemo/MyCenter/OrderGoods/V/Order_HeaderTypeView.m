//
//  Order_HeaderTypeView.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "Order_HeaderTypeView.h"

@interface Order_HeaderTypeView  ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation Order_HeaderTypeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        
        
        NSArray *notSelect = @[@"已完成未选中",@"待付款未选中",@"待收货未选中",@"退款未选中"];
        NSArray *typeArray = @[@"已完成",@"待付款",@"待收货",@"退款"];
        
        CGFloat width = ScreenWidth/typeArray.count;
        
        for (int i = 0; i<4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(width*i, 0, width, frame.size.height);
            button.tag = 10+i;
            button.selected = NO;
            button.titleLabel.font = [UIFont systemFontOfSize:12*HeightScale];

            
            [button setTitle:typeArray[i] forState:UIControlStateNormal];
            
            //        字体颜色
            [button setTitleColor:[UIColor colorWithDisplayP3Red:95.0 / 255.0 green:95.0 / 255.0 blue:95.0 / 255.0 alpha:1] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithDisplayP3Red:255.0 / 255.0 green:146.0 / 255.0 blue:2.0 / 255 alpha:1] forState:UIControlStateDisabled];
            
            
            
            //        图片
            [button  setImage:[UIImage imageNamed:notSelect[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:typeArray[i]] forState:UIControlStateDisabled];
            
            
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            //    / button标题的偏移量
            button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+5, -button.imageView.bounds.size.width, 0,0);
            //    // button图片的偏移量
            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width/2,button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
            
            
            [self addSubview:button];
        }
        
    }
    
    return self;
}

#pragma mark - publci methods
- (void)firstClickButton
{
    UIButton *btn = self.subviews[0];
    [self buttonAction:btn];
}

#pragma mark - event
- (void) buttonAction:(UIButton *)sender {
    
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickBtn:tag:)]) {
//        NSLog(@"in delegate %@",_delegate);
        [_delegate didClickBtn:sender tag:sender.tag];
        NSLog(@"didClickBtn:tag: is %ld",(long)sender.tag);
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
