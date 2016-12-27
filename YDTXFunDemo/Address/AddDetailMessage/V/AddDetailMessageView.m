//
//  AddDetailMessageView.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "AddDetailMessageView.h"


@interface AddDetailMessageView ()<UITextFieldDelegate>

@end

@implementation AddDetailMessageView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIView *reminderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 38*HeightScale)];
        reminderView.backgroundColor = [UIColor colorWithDisplayP3Red:234.0 / 255 green:234.0 / 255 blue:234.0 / 255 alpha:1];
        [self addSubview:reminderView];
      
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 38)];
        
        label.text = @"请正确填写您的收货地址，确保商品正确到达";
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithDisplayP3Red:176.0 / 255 green:176.0 / 255 blue:176.0 / 255 alpha:1];
        [reminderView addSubview:label];
        
        NSArray *array = @[@"收货人姓名",@"手机号码",@"省市区",@"详细地址,街道,楼牌号等",@"邮编"];
        UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 38*HeightScale, ScreenWidth, 230*HeightScale+0.5*array.count)];
        backGroundView.backgroundColor = [UIColor whiteColor];
        [self addSubview:backGroundView];
        
            for (int i = 0; i<array.count;i++ ) {
                NSString *placeholder = array[i];
                UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 46.5*HeightScale*i, ScreenWidth-20, 46*HeightScale)];
                textField.placeholder = placeholder;
                textField.tag = i+10;
                textField.delegate = self;
                
                textField.backgroundColor = [UIColor whiteColor];
                if (i == 2) {
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = CGRectMake(0, 0, ScreenWidth, textField.size.height);
                    button.backgroundColor = [UIColor redColor];
                    [textField addSubview:button];
                    [button addTarget:self action:@selector(addAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
                }
                
                [backGroundView addSubview:textField];
                
                
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46*HeightScale+46.5*HeightScale*i, ScreenWidth, 0.5)];
                lineView.backgroundColor = [UIColor colorWithDisplayP3Red:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1];
                [backGroundView addSubview:lineView];
                
            }

        
        UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY([self viewWithTag:14].frame)+56*HeightScale, ScreenWidth, 40)];
        defaultView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:defaultView];
        
        
        UILabel *defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth/3*2, 30)];
        defaultLabel.text = @"设为默认";
        defaultLabel.textColor = [UIColor blackColor];
        [defaultView addSubview:defaultLabel];
        
        UISwitch *Switch = [[UISwitch alloc]init];
        [defaultView addSubview:Switch];
        [Switch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(defaultView.mas_right).offset(-10);
            make.centerY.mas_equalTo(defaultView.mas_centerY);
        }];
    }
    
    return self;
}

- (void)addAddressBtn:(UIButton *)sender {
    UITextField *textField = [self viewWithTag:12];
    
    textField.text = @"点击按钮";
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
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
