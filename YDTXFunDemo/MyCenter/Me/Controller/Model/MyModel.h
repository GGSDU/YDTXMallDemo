//
//  MyModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/23.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

@property (nonatomic, assign) NSString *headpic;//头像
@property (nonatomic, assign) int sex;//0 女 1 男
@property (nonatomic, strong) NSString *nickname;//昵称
@property (nonatomic, strong) NSString *birthday;//生日
@property (nonatomic, strong) NSString *signature;//简介

@property (nonatomic, strong) NSString *prov;//省
@property (nonatomic, strong) NSString *city;//市
@property (nonatomic, strong) NSString *area;//区

@end
