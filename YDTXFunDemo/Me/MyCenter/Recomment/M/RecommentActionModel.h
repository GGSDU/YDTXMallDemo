//
//  RecommentActionModel.h
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommentActionModel : NSObject


/**
 * status : 200
 * message : 请求成功
 * data : [{"id":"1","uid":"69","type":"1","name":"跳崖","person":"王楠","mobile":"13507065404","content":"刺激哟","create_time":"2016-12-07 11:35:38","status":"2","is_del":"0"}]
 */
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *person;
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *create_time;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *is_del;

- (instancetype)initData:(NSDictionary *)dic;

@end
