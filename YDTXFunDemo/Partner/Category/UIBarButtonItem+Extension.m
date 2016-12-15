//
//  UIBarButtonItem+Extension.m
//  SinaWB
//
//  Created by 👄 on 15/9/14.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"


@implementation UIBarButtonItem (Extension)



+(UIBarButtonItem *)barButtonItemWithNorImageName:(NSString *)norImageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action withTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc]init];

//    button.titleLabel.backgroundColor = [UIColor greenColor];
//    button.imageView.backgroundColor = [UIColor blueColor];
//
//    button.backgroundColor = [UIColor whiteColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    
    
    button.titleEdgeInsets  = UIEdgeInsetsMake(0, -5, 0, 0);
    button.imageEdgeInsets  = UIEdgeInsetsMake(0, -5, 0, 0);
    
    
    
    
    [button setImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateSelected];
    
    //设置字体大小
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    if (title) {
        
//        CGSize size = [title sizeWithFont:button.titleLabel.font];
        
//        button.height = size.height;
//        
//        button.width = size.width + button.imageView.height + 20;
        
        
        button.height = button.imageView.height +25 ;
        
        button.width = button.imageView.width + button.titleLabel.width +55 ;
        
        // 让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    else
    {
        
        button.frame = CGRectMake(0, 0, 40, 30);
    }
    

    
    
    
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
    
}




@end
