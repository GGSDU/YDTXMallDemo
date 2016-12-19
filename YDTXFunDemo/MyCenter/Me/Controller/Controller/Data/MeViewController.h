//
//  MeViewController.h
//  YDTX
//
//  Created by 舒通 on 16/8/30.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeViewController : UIViewController

@property (nonatomic, copy)void(^userNameBlock)(NSString *username);//注册时的用户名
@property (nonatomic, strong) NSData *headImgData;

@end
