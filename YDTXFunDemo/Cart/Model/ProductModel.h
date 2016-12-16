//
//  ProductModel.h
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductModel : NSObject

@property (nonatomic,copy) NSString *infoImageURL;
@property (nonatomic,copy) NSString *infoName;
@property (nonatomic,copy) NSString *modelType;
@property (nonatomic,assign) float price;
@property (nonatomic,assign) float vipPrice;
@property (nonatomic,assign) int saleNumber;
@property (nonatomic,assign) int number;


@end
