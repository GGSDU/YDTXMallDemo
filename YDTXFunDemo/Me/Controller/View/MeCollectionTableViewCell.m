//
//  MeCollectionTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeCollectionTableViewCell.h"

@implementation MeCollectionTableViewCell

// 我的塘口
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;//
        self.heardImageView = [[UIImageView alloc]init];
        [self.contentView addSubview:self.heardImageView];
        [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10*HeightScale);
            make.bottom.mas_equalTo(-10*WidthScale);
            make.left.mas_equalTo(10*WidthScale);
            make.width.mas_equalTo(100*WidthScale);
            
        }];
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.text = @"标题";
        [self.titleLabel sizeToFit];
        
        
        self.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15*WidthScale);
            make.left.mas_equalTo(self.heardImageView.mas_right).offset(10*WidthScale);
            make.right.mas_equalTo(self.contentView).offset(-10*WidthScale);
            
        }];
        
        
        
        self.payLabel = [UILabel new];
        self.payLabel.text = @"";
        self.payLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        self.payLabel.textColor = [UIColor colorWithRed:0.992 green:0.655 blue:0.329 alpha:1.000];
        [self.payLabel sizeToFit];
        [self.contentView addSubview:self.payLabel];
        
        [self.payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self.contentView).offset(-10*WidthScale);
            
        }];
        
        
        
        self.adressLabel = [UILabel new];
        self.adressLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [self.adressLabel sizeToFit];
        
        self.adressLabel.text = @"上海市闵行区泰宏路168号";
        self.adressLabel.textColor = [UIColor colorWithRed:0.584 green:0.588 blue:0.620 alpha:1.000];
        [self.contentView addSubview:self.adressLabel];
        [self.adressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.payLabel.mas_bottom).offset(10*HeightScale);
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self).offset(-10*WidthScale);
        }];
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adressLabel.mas_bottom).offset(5*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
        
        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;
    }
    
    return self;
}
- (void) configModel:(MeTKCollectionModel *)model {

    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:[@"http://" stringByAppendingString:model.content]] placeholderImage:[UIImage imageNamed:@"形状10"]];
    self.titleLabel.text = model.theme;
//    NSLog(@"model.charge:%@,%@,%@,%@",model.price,model.prov,model.city,model.area);
        self.payLabel.text = model.price;

    self.adressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.prov,model.city,model.area,model.address];
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
