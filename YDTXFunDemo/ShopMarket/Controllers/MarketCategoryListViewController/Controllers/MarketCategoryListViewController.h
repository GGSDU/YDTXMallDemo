//
//  MarketListViewController.h
//  market
//
//  Created by RookieHua on 2016/12/7.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    yuGan = 1,         //鱼竿
    yuGou = 3,         //鱼钩
    yuXian = 10,       //鱼线
    erLiao = 13,       //饵料
    peiJian = 14,      //配件
    xieFu = 15,        //鞋服
    fuPiao = 16,       //浮漂
    zhuangBei = 18,    //装备
} classListType;

@interface MarketCategoryListViewController : UICollectionViewController

@property(assign,nonatomic)classListType classlistType;

@property(assign,nonatomic)NSString *ID; //商品分类

//@property(copy,nonatomic)NSString *navTitle; //导航的title

@end
