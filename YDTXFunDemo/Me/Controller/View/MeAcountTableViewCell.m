//
//  MeAcountTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeAcountTableViewCell.h"

@implementation MeAcountTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10.5*HeightScale)];
//        view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];
//        [self.contentView addSubview:view];
        
        
        
        self.rightLabel = [UILabel new];
        [self.contentView addSubview:self.rightLabel];
        self.rightLabel.text = @"未绑定";
        self.rightLabel.textColor = [UIColor colorWithWhite:0.529 alpha:1.000];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self);
            
        }];
        
        
    }

    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
