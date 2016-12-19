//
//  LogisticsTableViewCell.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "LogisticsTableViewCell.h"



@interface LogisticsTableViewCell ()
@property (nonatomic, strong) UIImageView *circleImgV;//圆圈

@property (nonatomic, strong) UIView *lineView1;//竖线
@property (nonatomic, strong) UIView *lineView2;//竖线

@property (nonatomic, strong) UILabel *addressLabel;//位置信息
@property (nonatomic, strong) UILabel *creat_timeLabel;//时间

@end


@implementation LogisticsTableViewCell

#pragma mark lazy
- (UIImageView *)circleImgV {
    if (!_circleImgV) {
        _circleImgV = [UIImageView new];
        _circleImgV.backgroundColor = [UIColor yellowColor];
        [self.contentView addSubview:_circleImgV];
        [_circleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(30*WidthScale);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
    }
    return _circleImgV;
}
- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = RGB(141, 141, 141);
        [self.contentView addSubview:_lineView1];
        [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.centerX.mas_equalTo(self.circleImgV.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(1, 15*HeightScale));
        }];
    }
    return _lineView1;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = RGB(141, 141, 141);
        [self.contentView addSubview:_lineView2];
        [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.circleImgV.mas_bottom);
            make.centerX.mas_equalTo(self.circleImgV.mas_centerX);
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
    }
    return _lineView2;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        _addressLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _addressLabel.textColor = RGB(141, 141, 141);
        [_addressLabel sizeToFit];
        [self.contentView addSubview:_addressLabel];
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.circleImgV.mas_top);
            make.left.mas_equalTo(self.circleImgV.mas_left).offset(30);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
        
    }
    return _addressLabel;
}

- (UILabel *)creat_timeLabel {
    if (!_creat_timeLabel) {
        _creat_timeLabel = [UILabel new];
        [_creat_timeLabel sizeToFit];
        _creat_timeLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        _creat_timeLabel.textColor  = RGB(141, 141, 141);
        [self.contentView addSubview:_creat_timeLabel];
        [_creat_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.addressLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.addressLabel.mas_left);
            make.right.mas_equalTo(self.addressLabel.mas_right);
        }];
    }
    return _creat_timeLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.circleImgV.image = [UIImage imageNamed:@"物流消息"];
        self.lineView1.backgroundColor = RGB(141, 141, 141);
        self.lineView2.backgroundColor = RGB(141, 141, 141);
        self.addressLabel.text = @"位置";
        self.creat_timeLabel.text = @"时间";
        
        
    }
    
    
    return self;
}



- (void)setModel:(LogisticsModel *)model {
    if ([model.status isEqualToString:@"1"]) {//1 表示当前位置 ，0 表示之前的位置
        
    }
    
    
    
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
