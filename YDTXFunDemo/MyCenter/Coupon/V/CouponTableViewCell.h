//
//  CouponTableViewCell.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CouponModel;


@interface CouponTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier couponModel:(CouponModel *)model;


@end
