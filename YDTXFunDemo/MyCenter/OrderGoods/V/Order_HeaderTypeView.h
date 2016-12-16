//
//  Order_HeaderTypeView.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order_HeaderTypeView;


@protocol Order_headerTypeViewDelegate <NSObject>

- (void)didClickBtn:(UIButton *)btn tag:(NSInteger)tag;

@end

@interface Order_HeaderTypeView : UIView

- (void)firstClickButton;

@property (nonatomic, assign) id<Order_headerTypeViewDelegate>delegate;

@end
