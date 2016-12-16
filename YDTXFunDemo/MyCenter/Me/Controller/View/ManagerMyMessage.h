//
//  ManagerMyMessage.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/15.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ManagerMyMessage;

@protocol ManagerMyMessageDelegate <NSObject>

- (void) didClickBtn:(UIButton *)button tag:(NSInteger)tag managerview:(UIView *)view;

@end

@interface ManagerMyMessage : UIView

@property (nonatomic, assign) id<ManagerMyMessageDelegate>delegate;

@end
