//
//  MarketDetailCell.h
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketDetailModel.h"



@protocol marketDetailCellDelegate <NSObject>

-(void)updateCellHeightWithHeight:(CGFloat)height;

@end

@interface MarketDetailCell : UITableViewCell

@property (nonatomic,strong) MarketDetailModel *marketDetailModel;

@property(weak,nonatomic)id <marketDetailCellDelegate> delegate;




@end
