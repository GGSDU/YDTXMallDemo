//
//  marketDetailModel.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "marketDetailModel.h"

@implementation marketDetailModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             
             @"ID" : @"id"
             };
}

//拦截Set方法   拼接一些东西

//-(void)setImages_url:(NSArray *)images_url{
//    
//    NSMutableArray *tempArr = [NSMutableArray array];
//    
//    for (int i = 0; i <images_url.count; i++) {
//        
//        NSString *picUrl = [NSString stringWithFormat:@"http://%@",images_url[i]];
//        
//        [tempArr addObject:picUrl];
//        
//    }
//
//    NSLog(@"--图片链接---%@",);
//    
//    _images_url = tempArr;
//}
@end
