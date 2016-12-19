//
//  MyCollectionViewCell.h
//  ClickImageBig
//
//  Created by 舒通 on 16/10/20.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property(nonatomic ,strong)UIImageView *imgView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, assign) NSInteger row;
@end
