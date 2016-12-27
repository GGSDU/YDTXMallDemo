//
//  LogisticsHeaderView.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogisticsModel.h"

@interface LogisticsHeaderView : UIView

- (void)getDataReloadView:(LogisticsModel *)model;

@property (nonatomic, copy) NSString *imageURL;

@end
