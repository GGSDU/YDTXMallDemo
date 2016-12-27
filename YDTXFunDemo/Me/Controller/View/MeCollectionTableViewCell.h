//
//  MeCollectionTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeTKCollectionModel.h"

@interface MeCollectionTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *heardImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *payLabel;
@property (nonatomic, strong) UILabel *adressLabel;

- (void) configModel:(MeTKCollectionModel *)model ;

@end
