//
//  ManagerMyMessageTableViewCell.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ManagerMyMessageTableViewCell;

@protocol ManagerMyMessageTabelViewCellDelegate <NSObject>

- (void) didClickBtn:(UIButton *)button tag:(NSInteger)tag manageCellView:(ManagerMyMessageTableViewCell *)view;

@end

@interface ManagerMyMessageTableViewCell : UITableViewCell

@property (assign, nonatomic) id<ManagerMyMessageTabelViewCellDelegate>delegate;

@end
