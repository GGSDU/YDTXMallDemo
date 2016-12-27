//
//  YDTXPayTool.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/27.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDTXPayTool : NSObject


-(void)startAliPayWithParamsDic:(NSMutableDictionary *)paramsDic ResultBlock:(void (^)(NSInteger resultStatus))resultBlock;


-(void)startWePayWithParamsDic:(NSMutableDictionary *)paramsDic ResultBlock:(void (^)(NSInteger resultStatus))resultBlock;



@end
