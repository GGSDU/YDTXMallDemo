//
//  SpotTextFileView.m
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "SpotTextFileView.h"
#import "SGLocationPickerView.h"

@interface SpotTextFileView ()<UITextFieldDelegate>

@end

@implementation SpotTextFileView


- (instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)placeholdList {
    self = [super initWithFrame:frame];
    
    if (self) {
        for (int i = 0; i < placeholdList.count; i++) {
            UITextField *textFiel = [[UITextField alloc]initWithFrame:CGRectMake(10*WidthScale, 44*HeightScale*i, ScreenWidth-20*WidthScale, 44*HeightScale)];
            textFiel.font = [UIFont systemFontOfSize:15*HeightScale];
            textFiel.textColor = RGB(89, 89, 89);
            textFiel.delegate = self;
            textFiel.placeholder = placeholdList[i];
            textFiel.tag = 10+i;
            [self addSubview:textFiel];
            
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 45*HeightScale*(i+1), ScreenWidth, 1*HeightScale)];
            view.backgroundColor = RGB(190, 191, 196);
            [self addSubview:view];
            
            if ([textFiel.placeholder isEqualToString:@"省市区"]) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, 0, super.frame.size.width, super.frame.size.height);
                [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                [textFiel addSubview:button];
                
            }
            
            
        }

    }
    
    return self;
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(didEditEndString:tag:)]) {
        [_delegate didEditEndString:textField.text tag:textField.tag];
    }
    
    return YES;
}


- (void)buttonAction:(UIButton *)sender {
    
    UITextField *textField = (UITextField *)sender.superview;
    NSLog(@"%ld",(long)textField.tag);
    SGLocationPickerView *PickerView = [[SGLocationPickerView alloc]init];
    PickerView.MyBlock = ^(NSString *prov,NSString *city,NSString *area){
        textField.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
        NSLog(@"省市区----%@%@%@",prov,city,area);
        if (_delegate && [_delegate respondsToSelector:@selector(didSelectProv:city:area:)]) {
            [_delegate didSelectProv:prov city:city area:area];
        }
        
    };
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
