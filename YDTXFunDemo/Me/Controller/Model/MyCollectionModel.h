//
//  MyCollectionModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/29.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCollectionModel : NSObject

// 我的帖子
@property (nonatomic, strong) NSString *ID;//数据id
@property (nonatomic, strong) NSString *pid;//关联id
@property (nonatomic, strong) NSString *userid;//用户id
@property (nonatomic, strong) NSString *is_del;//1为已收藏，0为未收藏
@property (nonatomic, strong) NSString *c_id;//帖子id
@property (nonatomic, strong) NSString *uid;//用户id
@property (nonatomic, strong) NSString *username;//用户名称
@property (nonatomic, strong) NSString *title;//帖子标题
@property (nonatomic, strong) NSString *count;// 统计回复数量

@end
