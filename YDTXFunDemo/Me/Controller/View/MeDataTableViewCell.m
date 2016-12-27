//
//  MeDataTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeDataTableViewCell.h"


@interface MeDataTableViewCell ()


@end
@implementation MeDataTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.label = [UILabel new];
        self.label.text = @"未填写";
        self.label.textColor = [UIColor colorWithRed:0.859 green:0.863 blue:0.863 alpha:1.000];
        self.label.lineBreakMode =NSLineBreakByTruncatingTail;
//        self.label.adjustsFontSizeToFitWidth = YES;
        self.label.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-36*WidthScale);
            make.height.mas_equalTo(self.mas_height);
            make.width.mas_equalTo(ScreenWidth/2);
//            make.centerY.mas_equalTo(self.mas_centerY);
        }];

        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-0.5);
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
