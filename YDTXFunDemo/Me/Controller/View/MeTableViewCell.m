//
//  MeTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/8/30.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeTableViewCell.h"


@interface MeTableViewCell ()


@end

@implementation MeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.cellLabel = [UILabel new];
        [self.contentView addSubview:self.cellLabel];
        
        self.cellLabel.textColor = [UIColor lightGrayColor];
        
        self.cellLabel.font = [UIFont systemFontOfSize:18];
        [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(80*HeightScale, 50*HeightScale));
            
        }];
        self.contentLabel = [[UILabel alloc]init];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cellLabel.mas_right).offset(52*WidthScale);
            make.right.mas_equalTo(self).offset(-50*WidthScale);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        _contentLabel.textColor = [UIColor blackColor];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.mas_bottom).offset(-0.5);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
        
        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;
       
    }
    
    
    return self;
}







- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
