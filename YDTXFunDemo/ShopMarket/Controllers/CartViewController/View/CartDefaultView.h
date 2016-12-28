//
//  CartDefaultView.h
//  YDTXFunDemo
//
//  Created by Story5 on 20/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartDefaultView;

@protocol CartDefaultViewDelegate <NSObject>

- (void)cartDefaultView:(CartDefaultView *)cartDefaultView didClickedGoToShopMarket:(UIButton *)aSender;

@end

@interface CartDefaultView : UIView

@property (nonatomic,assign) id<CartDefaultViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
