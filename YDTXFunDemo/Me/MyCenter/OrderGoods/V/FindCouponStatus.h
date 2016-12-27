//
//  FindCouponStatus.h
//  YDTX
//
//  Created by 舒通 on 2016/12/26.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindCouponStatus : NSObject

/*
 请求查看优惠券的状态，是否已使用
 
 */
- (void)dataParam:(NSString *)str successBlock:(void (^)(NSString *text))successBlock;

- (NSString *) data:(NSString *)str;

@end
