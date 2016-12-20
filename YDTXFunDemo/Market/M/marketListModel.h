//
//  marketListModel.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/15.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface marketListModel : NSObject

@property(copy,nonatomic)NSString *ID;            //商品id
@property(assign,nonatomic)NSInteger pid;           //商品分类id
@property(copy,nonatomic)NSString *images_url;      //商品图片
@property(copy,nonatomic)NSString *name;            //商品名
@property(assign,nonatomic)float price;             //原价
@property(assign,nonatomic)float pay;               //会员价
@property(assign,nonatomic)int total_num;           //销量


@end
