//
//  marketDetailModel.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface marketDetailModel : NSObject

@property(assign,nonatomic) NSInteger ID;   //商品id
@property(strong,nonatomic)NSArray *images_url;      //商品图片数组(轮播)
@property(copy,nonatomic)NSString *name;            //商品名
@property(assign,nonatomic)float price;             //原价
@property(assign,nonatomic)float pay;               //会员价
@property(assign,nonatomic)int total_num;           //销量
@property(assign,nonatomic)int quantity;            //库存
@property(assign,nonatomic)Boolean collection;      //是否收藏过
@property(copy,nonatomic)NSString *content;         //图文介绍的内容


@end
