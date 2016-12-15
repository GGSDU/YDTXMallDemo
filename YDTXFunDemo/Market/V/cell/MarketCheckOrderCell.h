//
//  MarketCheckOrderCell.h
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "marketCheckModel.h"
@interface MarketCheckOrderCell : UITableViewCell

@property(strong,nonatomic)marketCheckModel *marketCheckModel;

@property(assign,nonatomic)float totalPrice;
@end
