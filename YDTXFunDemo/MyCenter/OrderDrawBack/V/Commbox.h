//
//  Commbox.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Commbox : UIView<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITableView *tv;//x下拉列表
    NSMutableArray *tableArray;//下拉列表数据
    UITextField *textField;//文本输入框
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table 下拉列表的高度
    CGFloat frameHeight;//frame 的高度

}

@property (retain, nonatomic) UITableView *tv;
@property (retain, nonatomic) NSArray *tableArray;
@property (retain, nonatomic) UITextField *textField;



@end
