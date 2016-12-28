//
//  MarketGoodsModelCell.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/22.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MarketProductModel.h"

@interface MarketGoodsModelCell : UICollectionViewCell


@property (nonatomic,strong) MarketProductModel *marketProductModel;

@property (weak, nonatomic) IBOutlet UIButton *modelBtn;


@end
