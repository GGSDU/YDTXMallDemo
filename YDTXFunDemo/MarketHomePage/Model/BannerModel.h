//
//  AdvertiseInfo.h
//  IkasaInteriorIphone
//
//  Created by Story5 on 15/7/30.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BannerModel : NSObject

@property (nonatomic,assign) int adType;
@property (nonatomic,assign) int advertiseId;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *advertiseName;
@property (nonatomic,copy) NSString *advertiseUrl;

@end
