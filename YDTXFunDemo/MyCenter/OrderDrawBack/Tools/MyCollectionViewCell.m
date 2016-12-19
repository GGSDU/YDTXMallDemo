//
//  MyCollectionViewCell.m
//  ClickImageBig
//
//  Created by 舒通 on 16/10/20.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //        self.backgroundColor = [UIColor purpleColor];
        self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        //        self.imgView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.imgView];
        
        
        
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        self.deleteBtn.frame = CGRectMake(self.contentView.frame.size.width - 36, 0, 36, 36);
        [self.deleteBtn setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        self.deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, 0, 0, -10);
        self.deleteBtn.alpha = 0.6;
        [self.contentView addSubview:self.deleteBtn];
    }
    return self;
}


@end
