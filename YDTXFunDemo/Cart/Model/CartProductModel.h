//
//  CartProductModel.h
//  YDTXFunDemo
//
//  Created by Story5 on 21/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartProductModel : NSObject

@property (nonatomic,assign) int goods_order_id;
@property (nonatomic,assign) int user_id;
@property (nonatomic,assign) int goods_id;
@property (nonatomic,assign) int goods_model_id;
@property (nonatomic,strong) NSString *goods_name;
@property (nonatomic,assign) float price;
@property (nonatomic,assign) int nums;
@property (nonatomic,assign) int status;
@property (nonatomic,strong) NSString *models;
@property (nonatomic,strong) NSString *images_url;

@end
