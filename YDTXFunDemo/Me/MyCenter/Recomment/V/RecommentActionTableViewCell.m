//
//  RecommentActionTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentActionTableViewCell.h"

@interface RecommentActionTableViewCell ()

@property (strong, nonatomic) UILabel *actionTypeLabel;
@property (strong, nonatomic) UILabel *actionStatusLabel;
@property (strong, nonatomic) UILabel *actionTitleLabel;
@property (strong, nonatomic) UILabel *actionTimeLabel;

@property (strong, nonatomic) UIView *bottomLine;

@end





@implementation RecommentActionTableViewCell

- (UILabel *)actionTypeLabel {
    if (!_actionTypeLabel) {
        _actionTypeLabel = [UILabel new];
        [_actionTypeLabel sizeToFit];
        _actionTypeLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _actionTypeLabel.textColor = RGB(51, 51, 51);
        _actionTypeLabel.text = @"种类";
        [self.contentView addSubview:_actionTypeLabel];
        [_actionTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            
        }];
    }
    return _actionTypeLabel;
}

- (UILabel *)actionStatusLabel {
    if (!_actionStatusLabel) {
        _actionStatusLabel = [UILabel new];
        [_actionStatusLabel sizeToFit];
        _actionStatusLabel.textColor = RGB(255, 110, 33);
        _actionStatusLabel.text = @"状态";
        _actionStatusLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.contentView addSubview:_actionStatusLabel];
        [_actionStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.actionTypeLabel.mas_centerY);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10*WidthScale);
        }];
    }
    
    return _actionStatusLabel;
}

- (UILabel *)actionTitleLabel {
    if (!_actionTitleLabel) {
        _actionTitleLabel = [UILabel new];
        [_actionTitleLabel sizeToFit];
        _actionTitleLabel.textColor = RGB(124, 127, 134);
        _actionTitleLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _actionTitleLabel.text = @"活动名称";
        [self.contentView addSubview:_actionTitleLabel];
        [_actionTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.actionTypeLabel.mas_bottom).offset(15*HeightScale);
            make.left.mas_equalTo(self.actionTypeLabel.mas_left);
        }];
    }
    
    return _actionTitleLabel;
}

- (UILabel *)actionTimeLabel {
    if (!_actionTimeLabel) {
        _actionTimeLabel = [UILabel new];
        [_actionTimeLabel sizeToFit];
        _actionTimeLabel.textColor = RGB(124, 127, 134);
        _actionTimeLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.contentView addSubview:_actionTimeLabel];
        [_actionTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.actionTitleLabel.mas_bottom).offset(15*HeightScale);
            make.left.mas_equalTo(self.actionTitleLabel.mas_left);
        }];
    }
    return _actionTimeLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        [self.contentView addSubview:_bottomLine];
        [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 1));
        }];
    }
    return _bottomLine;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.actionStatusLabel.text = @"状态";
        
        self.actionTimeLabel.text = [NSString stringWithFormat:@"上传时间：2016.12.22"];
        self.bottomLine.backgroundColor = RGB(241, 241, 241);
        
    }
    return self;
}

- (void)getDataReloadView:(RecommentActionModel *)model {
//    actionTypeLabel;
//    @property (strong, nonatomic) UILabel *actionStatusLabel;
//    @property (strong, nonatomic) UILabel *actionTitleLabel;
//    @property (strong, nonatomic) UILabel *actionTimeLabel;
    
    self.actionTypeLabel.text = model.type;
    
    self.actionTitleLabel.text = model.name;
    
    if ([model.status isEqualToString:@"0"]) {//待审核
        self.actionStatusLabel.text = @"待审核";
    } else if( [model.status isEqualToString:@"1"]){//审核未通过
        self.actionStatusLabel.text = @"审核未通过";
    } else if ([model.status isEqualToString:@"2"]) {//审核通过
        self.actionStatusLabel.text = @"审核通过";
    }
    
    NSString *string = [model.create_time substringWithRange:NSMakeRange(0, 10)];
    NSString *str = [string stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    self.actionTimeLabel.text =[@"上传时间是:"  stringByAppendingString:str];
    
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
