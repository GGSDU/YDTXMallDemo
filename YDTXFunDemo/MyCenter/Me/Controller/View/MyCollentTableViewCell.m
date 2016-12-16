//
//  MyCollentTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/12.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyCollentTableViewCell.h"

@implementation MyCollentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
         self.myimageView = [UIImageView new];
        
        [self.contentView addSubview:self.myimageView];
        
        [self.myimageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        self.contentLabel = [UILabel new];
        [self.contentView addSubview:self.contentLabel];
        
        self.contentLabel.textColor = [UIColor blackColor];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.myimageView.mas_right).offset(21);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
     
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentLabel.mas_bottom).offset(5*HeightScale);
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
        
//        self.hyb_lastViewInCell = bottomView;
//        self.hyb_bottomOffsetToCell = 0.0;
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
