//
//  MarketCheakOrderInfoViewController.h
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarketCheakOrderInfoViewController : UIViewController

@property(assign,nonatomic)float totalPrice;

-(void)updateCheckVCWithDataArr :(NSArray *)DataArr;
@end
