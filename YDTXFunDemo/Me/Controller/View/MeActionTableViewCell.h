//
//  MeActionTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeActionModel.h"


@interface MeActionTableViewCell : UITableViewCell



@property (nonatomic, strong) UIImageView *heardImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

- (void)configModel:(MeActionModel *)model;

@end
