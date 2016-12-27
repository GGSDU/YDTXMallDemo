//
//  RecommentSpotTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommentSpotModel.h"

@interface RecommentSpotTableViewCell : UITableViewCell

- (void)getDataReloadView:(RecommentSpotModel *)model;

@end
