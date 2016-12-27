//
//  RHNotiTool.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "RHNotiTool.h"

@implementation RHNotiTool

+(void)NotiShowWithTitle:(NSString *)notiString Time:(NSTimeInterval)time{

    SVProgressHUD.defaultStyle = SVProgressHUDStyleDark;
    SVProgressHUD.minimumDismissTimeInterval = time;
    [SVProgressHUD showWithStatus:notiString];
}

+(void)NotiShowErrorWithTitle:(NSString *)notiString Time:(NSTimeInterval)time{
    SVProgressHUD.defaultStyle = SVProgressHUDStyleDark;
    SVProgressHUD.minimumDismissTimeInterval = time;
    [SVProgressHUD showErrorWithStatus:notiString];


}


+(void)NotiShowSuccessWithTitle:(NSString *)notiString Time:(NSTimeInterval)time{

    SVProgressHUD.defaultStyle = SVProgressHUDStyleDark;
    SVProgressHUD.minimumDismissTimeInterval = time;
    [SVProgressHUD showSuccessWithStatus:notiString];


}


+(void)dismiss{

    [SVProgressHUD dismiss];
}

@end
