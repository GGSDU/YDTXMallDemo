//
//  OrderPayStatus.h
//  YDTX
//
//  Created by 舒通 on 2016/12/23.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OrderPayStatusDelegate <NSObject>

- (void) operationStatus:(BOOL) status;

@end

@interface OrderPayStatus : NSObject


- (void)orderPayCancel:(NSDictionary *)dic url:(NSString *)url;

- (void) orderPay:(NSDictionary *)dic url:(NSString *)url;

- (void) orderPayDelect:(NSDictionary *)dic url:(NSString *)url;

- (void) orderPayDone:(NSDictionary *)dic url:(NSString *)url;

@property (assign, nonatomic) id<OrderPayStatusDelegate>delegate;



@end
