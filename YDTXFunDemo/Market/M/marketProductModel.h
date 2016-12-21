//
//  marketProductModel.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/21.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface marketProductModel : NSObject

/*
 Id：数据id
 Price：现价
 Quantity：库存
 Model:商品型号
*/


@property(copy,nonatomic)NSString *ID;

@property(assign,nonatomic)float price;

@property(strong,nonatomic)NSArray *quantity;

@property(strong,nonatomic)NSArray *model;

@end
