//
//  MarketMaskView.h
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol reMoveAnimationDelegate <NSObject>

-(void)removeMarketVCAnimation;

@end

@interface MarketMaskView : UIView


@property(weak,nonatomic)id<reMoveAnimationDelegate> delegate;

-(void)creatWithImgUrl:(NSString *)ImgUrl Title:(NSString *)title Price:(NSString *)price DataArray:(NSArray *)dataArr BtnTitle:(NSString *)btnTitle;

@end
