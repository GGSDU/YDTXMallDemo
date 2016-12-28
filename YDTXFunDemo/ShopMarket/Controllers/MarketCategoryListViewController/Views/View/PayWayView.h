//
//  PayWayView.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/13.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    isAliPay = 1,
    isWePay = 2,
    userNoChoose = 9
    
}MarketPayType;


@interface PayWayView : UIView


//提供给外部使用  枚举
@property (assign, nonatomic) MarketPayType payType;


@end
