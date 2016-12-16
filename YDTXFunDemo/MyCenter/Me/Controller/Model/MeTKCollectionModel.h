//
//  MeCollectionModel.h
//  YDTX
//
//  Created by 舒通 on 16/9/29.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

//我的塘口收藏
@interface MeTKCollectionModel : NSObject

@property (nonatomic, strong) NSString *ID;//数据id
@property (nonatomic, strong) NSString *pid;//关联塘口的id
@property (nonatomic, strong) NSString *userid;//用户id
@property (nonatomic, strong) NSString *is_del;//1为已收藏，0为未收藏
@property (nonatomic, strong) NSString *pon_id;//塘口id
@property (nonatomic ,strong) NSString *theme;//塘口的名称
@property (nonatomic, strong) NSString *price;//塘口的价格
@property (nonatomic, strong) NSString *content;//图片
@property (nonatomic, strong) NSString *status;//默认为0,1为1星星，以此类推最多5星
@property (nonatomic, strong) NSString *charge;//收费方式：0为按斤收费，1为按天收费
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *prov;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *area;

@end
