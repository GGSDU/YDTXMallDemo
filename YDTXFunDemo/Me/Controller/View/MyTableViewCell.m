//
//  MyTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/8/30.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyTableViewCell.h"
#import "Masonry.h"

@interface MyTableViewCell ()

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
         self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView = [UIImageView new];
        
        [self.contentView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"个人设置"];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        imageView.image = [UIImage imageNamed:@"个人设置"];

        self.contentButton = [UILabel new];
        [self.contentView addSubview:self.contentButton];
        
        self.contentButton.textColor = [UIColor blackColor];
        [self.contentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).offset(21);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
  
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
        
        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;
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
