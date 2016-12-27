//
//  CallMobile.h
//  YDTX
//
//  Created by 舒通 on 2016/12/23.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CallMobileDelegate <NSObject>

#pragma mark 拨打电话
- (void) didCallBtnTag;

#pragma mark 取消拨打电话
- (void) didCancelCall;


@end


@interface CallMobile : UIView

@property (strong, nonatomic) UILabel *mobileLabel;

@property (assign, nonatomic) id<CallMobileDelegate>delegate;


- (instancetype)initWithFrame:(CGRect)frame mobileNum:(NSString *)num;

@end
