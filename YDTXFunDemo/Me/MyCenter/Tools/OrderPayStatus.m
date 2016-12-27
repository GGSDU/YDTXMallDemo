//
//  OrderPayStatus.m
//  YDTX
//
//  Created by 舒通 on 2016/12/23.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "OrderPayStatus.h"

@interface OrderPayStatus ()

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;

@end

@implementation OrderPayStatus

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}


#pragma mark 取消订单
- (void)orderPayCancel:(NSDictionary *)dic url:(NSString *)url {
    
    [self.AFManager GET:[NSString stringWithFormat:@"%@%@",postHttp,url] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            
            [self orderDelegate];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"取消失败"];
    }];
}

#pragma mark 继续支付
- (void) orderPay:(NSDictionary *)dic url:(NSString *)url {
    
}


#pragma mark 删除订单
- (void) orderPayDelect:(NSDictionary *)dic url:(NSString *)url {
    
    [self.AFManager GET:[NSString stringWithFormat:@"%@%@",postHttp,url] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            
            [self orderDelegate];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"删除失败"];
    }];

    
}

#pragma mark 确认收货
- (void) orderPayDone:(NSDictionary *)dic url:(NSString *)url {
    [self.AFManager GET:[NSString stringWithFormat:@"%@%@",postHttp,url] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            
            [self orderDelegate];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"确认失败"];
    }];

}


#pragma mark  触发代理
- (void)orderDelegate {
    if (_delegate && [_delegate respondsToSelector:@selector(operationStatus:)]) {
        [_delegate operationStatus:YES];
    }
}


@end
