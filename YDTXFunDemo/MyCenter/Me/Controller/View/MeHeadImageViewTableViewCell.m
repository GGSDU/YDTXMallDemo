//
//  MeHeadImageViewTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/10/11.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeHeadImageViewTableViewCell.h"

@interface MeHeadImageViewTableViewCell()


@end
@implementation MeHeadImageViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [UIImageView new];
        self.imageV.image = [UIImage imageNamed:@"headbg"];
        self.imageV.userInteractionEnabled = YES;
        [self.contentView addSubview:self.imageV];
        [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 180*HeightScale));
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
