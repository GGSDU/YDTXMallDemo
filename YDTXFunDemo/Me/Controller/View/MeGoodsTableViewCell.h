//
//  MeGoodsTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeGoodsModel.h"

@interface MeGoodsTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *heardImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pricesLabel;
@property (nonatomic, strong) UIButton *newsButton;
@property (nonatomic, strong) UITableView *tableView;

- (void) configModel:(MeGoodsModel *)model;



@end
