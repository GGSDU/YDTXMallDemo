//
//  MyCollectionTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCollectionModel.h"

@interface MyCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *identityLabel;
@property (nonatomic, strong) UIImageView *newsImage;
@property (nonatomic, strong) UILabel *newsNumberLabel;
@property (nonatomic, strong) UITableView *tableView;

- (void) configModel:(MyCollectionModel *)model;

@end
