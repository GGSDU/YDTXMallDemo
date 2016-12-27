//
//  MeActionTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeActionTableViewCell.h"

@implementation MeActionTableViewCell

// 我的活动

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.heardImageView = [[UIImageView alloc]init];
        self.heardImageView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.heardImageView];
        [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(10*HeightScale);
            make.left.mas_equalTo(self.contentView).offset(10*HeightScale);
            make.size.mas_equalTo(CGSizeMake(100*HeightScale, 100*HeightScale));

        }];
        
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"帖子";
        self.titleLabel.font = [UIFont systemFontOfSize:15.0*HeightScale];
        self.titleLabel.textColor = [UIColor blackColor];
        [self.titleLabel sizeToFit];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView).offset(20*HeightScale);
            make.left.mas_equalTo(self.heardImageView.mas_right).offset(10*WidthScale);
            make.right.mas_equalTo(self.contentView).offset(-10*WidthScale);
            
        }];
        
        
        
        self.stateLabel = [UILabel new];
        self.stateLabel.text = @"进行时";
        self.stateLabel.font = [UIFont systemFontOfSize:10.0*HeightScale];
        [self.stateLabel sizeToFit];
        self.stateLabel.textColor = [UIColor colorWithRed:1.000 green:0.545 blue:0.125 alpha:1.000];
        self.stateLabel.layer.borderColor = [UIColor colorWithRed:1.000 green:0.545 blue:0.125 alpha:1.000].CGColor;
        self.stateLabel.layer.borderWidth = 1;
        self.stateLabel.layer.cornerRadius = 5;
        [self.contentView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.titleLabel);
            
        }];
        
        self.timeLabel = [UILabel new];
        self.timeLabel.text = @"时间是：2016.9.6";
        self.timeLabel.textColor = [UIColor colorWithRed:0.529 green:0.522 blue:0.565 alpha:1.000];
        [self.timeLabel sizeToFit];
        self.timeLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        
        [self.contentView addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.stateLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.stateLabel);
        }];
        
        
        self.addressLabel = [UILabel new];
        self.addressLabel.textColor = [UIColor colorWithRed:0.529 green:0.522 blue:0.565 alpha:1.000];
        [self.addressLabel sizeToFit];
        self.addressLabel.text = @"上海市闵行区";
        self.addressLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.contentView addSubview:self.addressLabel];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.timeLabel);
        }];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-1*HeightScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];

        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;

    }
    
    
    return self;
}

- (void)configModel:(MeActionModel *)model {
    self.titleLabel.text = model.theme;
//    self.timeLabel.text = model.begin_time;
    
    int begin = [model.begin_time intValue];
    NSDate *begindate = [NSDate dateWithTimeIntervalSince1970:begin];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日HH时"];
    NSString *beginStr = [formatter stringFromDate:begindate];
  
    int end = [model.end_time intValue];
    NSDate *enddate = [NSDate dateWithTimeIntervalSince1970:end];
    NSString *endStr = [formatter stringFromDate:enddate];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@-%@",beginStr,endStr];
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",model.act_prov,model.act_city,model.act_area];
    
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:[@"http://" stringByAppendingString:model.content]] placeholderImage:[UIImage imageNamed:@"zwt"]];

    if ([model.biaoqian isEqualToString:@"0"]) {
        self.stateLabel.text = @"  结束  ";
    }else if ( [model.biaoqian isEqualToString:@"1"]){
        self.stateLabel.text = @"  满员  ";
    }else if ([model.biaoqian isEqualToString:@"2"]){
        self.stateLabel.text = @"  进行中  ";
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
