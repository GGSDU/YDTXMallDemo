//
//  RHNotiTool.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface RHNotiTool : NSObject

+(void)NotiShowWithTitle:(NSString *)notiString Time:(NSTimeInterval)time;

+(void)NotiShowErrorWithTitle:(NSString *)notiString Time:(NSTimeInterval)time;


+(void)NotiShowSuccessWithTitle:(NSString *)notiString Time:(NSTimeInterval)time;

@end
