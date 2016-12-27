//
//  MeGoodsTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeGoodsTableViewCell.h"

@implementation MeGoodsTableViewCell

// 我的商品收藏

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.heardImageView = [[UIImageView alloc]init];
//        self.heardImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.heardImageView];
        [self.heardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10*HeightScale);
            make.left.mas_equalTo(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(100*WidthScale, 80*HeightScale));
            
        }];
        
        
        
        self.titleLabel = [UILabel new];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.text = @"商品名";
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont systemFontOfSize:18*HeightScale];
        [self.titleLabel sizeToFit];
        
        [self.contentView addSubview:self.titleLabel];

        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20*HeightScale);
            make.left.mas_equalTo(self.heardImageView.mas_right).offset(10*WidthScale);
            make.right.mas_equalTo(-15*WidthScale);
        }];
        
        
        
        
        
        
        self.pricesLabel = [UILabel new];
        self.pricesLabel.textColor = [UIColor colorWithRed:0.922 green:0.157 blue:0.196 alpha:1.000];
        self.pricesLabel.text = @"￥888";
        self.pricesLabel.font = [UIFont systemFontOfSize:15.0*HeightScale];
        [self.pricesLabel sizeToFit];
        [self.contentView addSubview:self.pricesLabel];
        [self.pricesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-20*HeightScale);
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10*WidthScale);
            
        }];
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.heardImageView.mas_bottom).offset(5*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;
        
    }
    
    
    
    return self;
}
- (void) configModel:(MeGoodsModel *)model {
    [self.heardImageView sd_setImageWithURL:[NSURL URLWithString:[@"http://" stringByAppendingString:model.images_url]] placeholderImage:[UIImage imageNamed:@"形状10"]];
//    self.titleLabel.text = model.name;
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
    muStyle.lineSpacing = 3;//设置行间距离
    muStyle.alignment = NSTextAlignmentLeft;//对齐方式
    if (model.name.length>0) {
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:model.name];
        [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0*HeightScale] range:NSMakeRange(0, titleString.length)];
        
        [titleString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, titleString.length)];
        self.titleLabel.attributedText = titleString;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.enabled = YES;//设置文字内容是否可变
        self.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;//省略结尾，以省略号代替;
        self.titleLabel.userInteractionEnabled = YES;//设置标签是否忽略或移除用户交互。默认为NO
        
        NSDictionary *titleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0*HeightScale],NSParagraphStyleAttributeName:muStyle};
        
        CGFloat th = [self.titleLabel.text  boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - kGAP-kAvatar_Size - 2*kGAP, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleAttributes context:nil].size.height+0.5;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20*HeightScale);
            make.left.mas_equalTo(self.heardImageView.mas_right).offset(10*WidthScale);
            make.height.mas_equalTo(th);
            make.right.mas_equalTo(-15*WidthScale);
        }];
        
    }else {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20*HeightScale);
            make.left.mas_equalTo(self.heardImageView.mas_right).offset(10*WidthScale);
            make.height.mas_equalTo(0);
            make.right.mas_equalTo(-15*WidthScale);
        }];

    }
    
    
    self.pricesLabel.text = [@"￥" stringByAppendingString:model.price];
    
//    self.newsButton setTitle:model. forState:<#(UIControlState)#>
    
    
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
