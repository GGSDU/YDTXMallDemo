//
//  PartnerModel.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PartnerModel : NSObject

@property (copy,nonatomic) NSString *create_time;
@property (copy,nonatomic) NSString *ID;
@property (assign,nonatomic)Boolean is_del;
@property (assign,nonatomic)float price;
@property (copy,nonatomic) NSString *right;

@end
