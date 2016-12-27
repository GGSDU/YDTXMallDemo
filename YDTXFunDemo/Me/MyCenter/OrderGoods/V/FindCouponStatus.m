//
//  FindCouponStatus.m
//  YDTX
//
//  Created by 舒通 on 2016/12/26.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "FindCouponStatus.h"

@interface FindCouponStatus  ()

@property (strong, nonatomic) AFHTTPSessionManager *AFManager;
@property (copy, nonatomic) NSString *text;

@end

@implementation FindCouponStatus

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}



- (void)dataParam:(NSString *)str successBlock:(void (^)(NSString *))successBlock{
    
    self.text = nil;
    
    NSMutableDictionary *param  = [NSMutableDictionary dictionary];
    param[@"order_id"] = str;
    
    //        /order_id/142
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goods/checkCoupon"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"couponstatus  data is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@201] || [responseObject[@"status"] isEqual:@202] ) {
            
            
            self.text = responseObject[@"data"];
            NSLog(@"self.text is :%@",self.text);
            
        } else {
            
            self.text = @"0";
            
        }
        
        successBlock(self.text);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        successBlock(nil);
        
    }];
    NSLog(@"self.text after is :%@",self.text);
    
}

- (NSString *) data:(NSString *)str {
    
    self.text = nil;
    
    NSMutableDictionary *param  = [NSMutableDictionary dictionary];
    param[@"order_id"] = str;
    
    //        /order_id/142
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goods/checkCoupon"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"couponstatus  data is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@201] || [responseObject[@"status"] isEqual:@202] ) {
            
            
            self.text = responseObject[@"data"];
            NSLog(@"self.text is :%@",self.text);
            
        } else {
            
            self.text = @"0";
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    NSLog(@"self.text after is :%@",self.text);
    
    return self.text;
}
//- (instancetype)initData :(NSString *) str {
//    
//    if (self = [super init]) {
//       
//        NSMutableDictionary *param  = [NSMutableDictionary dictionary];
//        param[@"order_id"] = str;
//        
////        /order_id/142
//        [self.AFManager GET:[postHttp stringByAppendingString:@"api/goods/checkCoupon"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//        }];
//        
//    }
//    
//    return self;
//}
//

@end
