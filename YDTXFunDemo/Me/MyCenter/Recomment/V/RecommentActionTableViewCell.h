//
//  RecommentActionTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentActionModel.h"

@interface RecommentActionTableViewCell : UITableViewCell

- (void)getDataReloadView:(RecommentActionModel *)model;

@end
