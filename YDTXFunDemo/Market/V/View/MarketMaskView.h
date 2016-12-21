//
//  MarketMaskView.h
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MarketMaskView : UIView

@property (copy,nonatomic)NSString *goods_id;


//带有旋转动画的初始化方法
-(void)showWithTransformAnimation;

//带有还原动画的消失方法
//-(void)dismissWithTransformAnimation;

-(void)updateUIWithGoodsId:(NSString *)goods_id;

@end
