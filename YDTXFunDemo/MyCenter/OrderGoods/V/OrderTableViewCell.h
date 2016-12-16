//
//  OrderTableViewCell.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTableViewCell;
@class OrderListModel;

@protocol OrderTableViewCellDelegate <NSObject>

- (void) orderTableViewCell:(OrderTableViewCell *)orderTableViewCell didClickDelectedBtn:(UIButton *)btn tag:(NSInteger)tag;

@end


@interface OrderTableViewCell : UITableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier model:(OrderListModel *)model ;

@property (nonatomic, assign) id<OrderTableViewCellDelegate>delegate;


@end
