//
//  CartCellOperationView.h
//  YDTXFunDemo
//
//  Created by Story5 on 08/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartCellOperationView;

@protocol CartCellOperationViewDelegate <NSObject>

- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedAllChooseButton:(UIButton *)allChooseButton;
- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedSettleAccountButton:(UIButton *)settleAccountButton;
- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedDeleteListButton:(UIButton *)deleteListButton;

@end

@interface CartCellOperationView : UIView

@property (nonatomic,assign) id<CartCellOperationViewDelegate>delegate;

- (BOOL)allChooseButtonSelectedStatus;
- (void)updateOperationButtonTitle:(NSString *)title;
- (void)updateTotalPrice:(float)price;

@end
