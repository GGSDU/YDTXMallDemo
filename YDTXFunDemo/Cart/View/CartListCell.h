//
//  CartListCell.h
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartListCell;

@protocol CartListCellDelegate <NSObject>

- (void)cartListCell:(CartListCell *)cartListCell didSelectedCell:(CartProductModel *)cartProductModel;


@end

@interface CartListCell : UITableViewCell

@property (nonatomic,assign) id<CartListCellDelegate>delegate;

@property (nonatomic,strong) CartProductModel *cartProductModel;

@property (nonatomic,assign) int productNumber;

@property (nonatomic,strong) UIButton *cellSelectButton;
@property (nonatomic,strong) SXAdjustNumberView *adjustNumberView;
@property (nonatomic,copy) UpdateNumberBlock updateNumberBlock;


- (void)updateCellStatusButtonSelected:(BOOL)selected;

@end
