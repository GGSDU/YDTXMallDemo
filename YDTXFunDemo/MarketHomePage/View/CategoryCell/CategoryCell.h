//
//  CategoryCell.h
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - CategoryModel
@interface CategoryModel : NSObject

@property (nonatomic,strong) NSString *ID;      // 数据id
@property (nonatomic,strong) NSString *title;   // 分类名称
@property (nonatomic,strong) NSString *pid;     // 分类id
@property (nonatomic,strong) NSString *uploads; // 图标

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;

@end

#pragma mark - CategoryCell
@interface CategoryCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label;

@end
