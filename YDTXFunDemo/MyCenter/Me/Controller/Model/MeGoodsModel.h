//
//  MeGoodsModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/29.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeGoodsModel : NSObject

@property (nonatomic, strong) NSString *ID;//数据id
@property (nonatomic, strong) NSString *pid;//关联活动id
@property (nonatomic, strong) NSString *userid;//用户id
@property (nonatomic, strong) NSString *is_del;//1为已收藏，0为未收藏

@property (nonatomic, strong) NSString *name;//商品名称
@property (nonatomic, strong) NSString *price;//价格
@property (nonatomic, strong) NSString *is_top;//默认为0, 1为新品，2为一周特价推荐，3，好物推荐
@property (nonatomic, strong) NSString *images_url;//图片

@end
