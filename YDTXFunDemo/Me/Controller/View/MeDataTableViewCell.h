//
//  MeDataTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/9/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeDataTableViewCell;

// 代理
@protocol  MeDataTableViewCellDelegate <NSObject>


@end


@interface MeDataTableViewCell : UITableViewCell





//@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end
