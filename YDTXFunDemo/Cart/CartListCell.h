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

- (void)cartListCell:(CartListCell *)cartListCell didSelectedCell:(ProductModel *)productModel;

@end

@interface CartListCell : UITableViewCell

@property (nonatomic,assign) id<CartListCellDelegate>delegate;

@property (nonatomic,retain) ProductModel *productModel;

@property (nonatomic,assign) int productNumber;

@property (nonatomic,retain) UIButton *cellSelectButton;

- (void)updateCellStatusButtonSelected:(BOOL)selected;

@end