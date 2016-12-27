//
//  CouponTableViewCell.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "CouponTableViewCell.h"
#import "CouponModel.h"

@interface CouponTableViewCell ()

@property (strong, nonatomic) UIImageView *backImageView;
@property (strong, nonatomic) UILabel *priceImgLabel;
@property (strong, nonatomic) UILabel *priceLael;
@property (strong, nonatomic) UILabel *conditionLabel;//条件
@property (strong, nonatomic) UILabel *timeLabel;//时间
@property (strong, nonatomic) UILabel *platformLabel;//平台


@end

@implementation CouponTableViewCell

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc]init];
        _backImageView.image = [UIImage imageNamed:@"couponBackImg"];
//        _backImageView.contentMode = UIViewContentModeScaleAspectFit;
        _backImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_backImageView];
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.width.mas_equalTo(ScreenWidth - 20*WidthScale);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
        }];
        
    }
    return _backImageView;
}

- (UILabel *)priceImgLabel {
    if (!_priceImgLabel) {
        _priceImgLabel = [UILabel new];
        _priceImgLabel.text = @"￥";
        [_priceImgLabel sizeToFit];
        _priceImgLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _priceImgLabel.textColor = [UIColor whiteColor];
        [self.backImageView addSubview:_priceImgLabel];
        [_priceImgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.contentView.mas_left).offset(30*WidthScale);
            
        }];
    }
    return _priceImgLabel;
}

- (UILabel *)priceLael {
    if (!_priceLael) {
        _priceLael = [UILabel new];
        [_priceLael sizeToFit];
        _priceLael.textColor = [UIColor whiteColor];
        _priceLael.font = [UIFont systemFontOfSize:44*HeightScale];
        [self.backImageView addSubview:_priceLael];
        [_priceLael mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.left.mas_equalTo(self.priceImgLabel.mas_right);
            
        }];
        
    }
    return _priceLael;
    
}

-(UILabel *)conditionLabel {
    if (!_conditionLabel) {
        _conditionLabel = [UILabel new];
        _conditionLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [_conditionLabel sizeToFit];
        _conditionLabel.textColor = RGB(102, 102, 102);
        [self.backImageView addSubview:_conditionLabel];
        [_conditionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(20*HeightScale);
//            make.centerX.mas_equalTo(self.contentView.mas_centerX).offset(50);
            make.left.mas_equalTo(self.contentView.mas_centerX).offset(-20);
        }];
    }
    return _conditionLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        [_timeLabel sizeToFit];
        _timeLabel.font = [UIFont systemFontOfSize:10*HeightScale];
        _timeLabel.textColor = RGB(113, 113, 113);
        [self.backImageView addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.conditionLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(172*WidthScale);
        }];
        
    }
    return _timeLabel;
    
}

- (UILabel *)platformLabel {
    if (!_platformLabel) {
        _platformLabel = [UILabel new];
        [_platformLabel sizeToFit];
        _platformLabel.textColor = RGB(123, 123, 123);
        _platformLabel.font = [UIFont systemFontOfSize:10*HeightScale];
        
        [self.backImageView addSubview:_platformLabel];
        [_platformLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.timeLabel.mas_left);
            
        }];
    }
    
    return _platformLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = RGB(235, 235, 241);
        
        NSString *string = [NSString stringWithFormat:@"满 使用"];
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:string];
        
        [text addAttribute:NSForegroundColorAttributeName value:RGB(255, 145, 88) range:NSMakeRange(1, string.length-3)];
        self.conditionLabel.attributedText = text;
        

        self.platformLabel.text = [@"使用平台：" stringByAppendingString:@"全场通用"];

        self.timeLabel.text = [NSString stringWithFormat:@"使用时间: -"];
        
        self.priceLael.text = @"";
        
        
        
    }
    return self;
}


- (void)upData:(CouponTableViewCell *)cell couponModel:(CouponModel *)model {
    
    NSString *string = [NSString stringWithFormat:@"满%@使用",model.full];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:string];
    
    [text addAttribute:NSForegroundColorAttributeName value:RGB(255, 145, 88) range:NSMakeRange(1, string.length-3)];
    self.conditionLabel.attributedText = text;
    
    
    self.platformLabel.text = [@"使用平台：" stringByAppendingString:@"全场通用"];
    
    self.timeLabel.text = [NSString stringWithFormat:@"使用时间:%@-%@",[model.start_time substringWithRange:NSMakeRange(0, 11)],[model.end_time substringWithRange:NSMakeRange(0, 11)]];
    
    self.priceLael.text = model.cut;
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
