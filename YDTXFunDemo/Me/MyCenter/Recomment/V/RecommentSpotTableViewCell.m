//
//  RecommentSpotTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentSpotTableViewCell.h"


@interface RecommentSpotTableViewCell  ()

@property (strong, nonatomic) UIImageView *spotImageView;
@property (strong, nonatomic) UILabel *spotTitleLabel;
@property (strong, nonatomic) UILabel *spotStatusLabel;
@property (strong, nonatomic) UILabel *spotAddressLabel;
@property (strong, nonatomic) UILabel *spotTimeLabel;

@property (strong, nonatomic) UIView *bottomLine;

@end

@implementation RecommentSpotTableViewCell

- (UIImageView *)spotImageView {
    if (!_spotImageView) {
        _spotImageView = [UIImageView new];
        _spotImageView.layer.cornerRadius = 5;
        _spotImageView.image = [UIImage imageNamed:@"zwt"];
        [self.contentView addSubview:_spotImageView];
        [_spotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(5*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(100*WidthScale, 80*HeightScale));
        }];
    }
    return _spotImageView;
}

- (UILabel *)spotTitleLabel {
    if (!_spotTitleLabel) {
        _spotTitleLabel = [UILabel new];
        [_spotTitleLabel sizeToFit];
        _spotTitleLabel.textColor = RGB(51, 51, 51);
        _spotTitleLabel.text = @"塘口名称";
        
        _spotTitleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.contentView addSubview:_spotTitleLabel];
        [_spotTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.spotImageView.mas_right).offset(10*WidthScale);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-60*HeightScale);
            
        }];
    }
    
    return _spotTitleLabel;
}

- (UILabel *)spotStatusLabel {
    if (!_spotStatusLabel) {
        _spotStatusLabel = [UILabel new];
        [_spotStatusLabel sizeToFit];
        _spotStatusLabel.textColor = RGB(255, 97, 8);
        _spotStatusLabel.text = @"状态";
        _spotStatusLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.contentView addSubview:_spotStatusLabel];
        [_spotStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.spotTitleLabel.mas_top);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10*WidthScale);
        }];
    }
    return _spotStatusLabel;
}

- (UILabel *)spotAddressLabel {
    if (!_spotAddressLabel) {
        _spotAddressLabel = [UILabel new];
        [_spotAddressLabel sizeToFit];
        _spotAddressLabel.textColor = RGB(142, 143, 148);
        _spotAddressLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.contentView addSubview:_spotAddressLabel];
        [_spotAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.spotTitleLabel.mas_bottom).offset(15*HeightScale);
            make.left.mas_equalTo(self.spotTitleLabel.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    
    return _spotAddressLabel;
}

- (UILabel *)spotTimeLabel {
    if (!_spotTimeLabel) {
        _spotTimeLabel = [UILabel new];
        [_spotTimeLabel sizeToFit];
        _spotTimeLabel.textColor = RGB(142, 143, 148);
        _spotTimeLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        _spotTimeLabel.text = @"上传时间";
        [self.contentView addSubview:_spotTimeLabel];
        [_spotTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.spotAddressLabel.mas_left);
            make.top.mas_equalTo(self.spotAddressLabel.mas_bottom).offset(15*HeightScale);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        }];
    }
    return _spotTimeLabel;
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
        
        self.spotTimeLabel.text = [NSString stringWithFormat:@"上传时间："];
        self.spotStatusLabel.text = @"审核状态";
        
        self.spotAddressLabel.text = @"云钓客";
        
        self.bottomLine.backgroundColor = RGB(241, 241, 241);
    }
    
    return self;
    
}


- (void)getDataReloadView:(RecommentSpotModel *)model {


    [self.spotImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",postHttp,model.img]] placeholderImage:[UIImage imageWithContentsOfFile:imagePath]];
    

    
    
    self.spotTitleLabel.text = model.name;

    if ([model.status isEqualToString:@"0"]) {//待审核
        self.spotStatusLabel.text = @"待审核";
    } else if( [model.status isEqualToString:@"1"]){//审核未通过
        self.spotStatusLabel.text = @"审核未通过";
    } else if ([model.status isEqualToString:@"2"]) {//审核通过
        self.spotStatusLabel.text = @"审核通过";
    }
    
    self.spotAddressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.prov,model.city,model.area,model.address];
//    NSLog(@"shijian shi :%@",model.create_time);
    NSString *string = [model.create_time substringWithRange:NSMakeRange(0, 10)];
    NSString *str = [string stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    self.spotTimeLabel.text = [@"上传时间:" stringByAppendingString:str];
    
    
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
