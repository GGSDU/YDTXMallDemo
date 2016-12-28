//
//  ProductBriefCell.h
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - ProductBriefModel
@interface ProductBriefModel :NSObject

@property (nonatomic,strong) NSString *ID;          // 数据id
@property (nonatomic,strong) NSString *pid;         // 分类id
@property (nonatomic,strong) NSString *name;        // 商品名称
@property (nonatomic,assign) float pay;             // 原价
@property (nonatomic,assign) float price;           // 现价
@property (nonatomic,strong) NSString *images_url;  // 图片
@property (nonatomic,assign) int total_num;         // 销量
@property (nonatomic,strong) NSString *up_title;    // 分类

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

- (id)valueForUndefinedKey:(NSString *)key;

@end

#pragma mark - ProductBriefCell
@interface ProductBriefCell : UICollectionViewCell

- (void)updateViewWithProductBriefModel:(ProductBriefModel *)productBriefModel;

@end
