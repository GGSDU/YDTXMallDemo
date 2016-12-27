//
//  MyCollectionTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyCollectionTableViewCell.h"



@implementation MyCollectionTableViewCell

// 帖子

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [UILabel new];
        self.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.text = @"";
        self.titleLabel.numberOfLines = 0;
        [self.titleLabel sizeToFit];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self).offset(10*HeightScale);
            make.left.mas_equalTo(self).offset(20*WidthScale);
            make.right.mas_equalTo(self).offset(-10*WidthScale);
        }];
        
        
        self.identityLabel = [UILabel new];
        self.identityLabel.textColor = [UIColor colorWithWhite:0.643 alpha:1.000];
        self.identityLabel.text = @"钓客";
        [self.identityLabel sizeToFit];
        self.identityLabel.font = [UIFont systemFontOfSize:13.0*HeightScale];
        [self.contentView addSubview:self.identityLabel];
        [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.titleLabel);
            
        }];
        
        
        self.newsNumberLabel = [UILabel new];
        self.newsNumberLabel.textColor = [UIColor colorWithWhite:0.682 alpha:1.000];
        self.newsNumberLabel.text = @"999";
        self.newsNumberLabel.font = [UIFont systemFontOfSize:14.0*HeightScale];
//        self.newsNumberLabel.adjustsFontSizeToFitWidth = YES;
        [self.newsNumberLabel sizeToFit];
        [self.contentView addSubview:self.newsNumberLabel];
        [self.newsNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.identityLabel);
            make.right.mas_equalTo(self).offset(-15*WidthScale);
            make.width.mas_equalTo(20*WidthScale);
            
        }];
        
        
        self.newsImage = [UIImageView new];
        self.newsImage.image = [UIImage imageNamed:@"回复(2)"];
        [self.contentView addSubview:self.newsImage];
        [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.identityLabel);
            make.right.mas_equalTo(self.newsNumberLabel.mas_left).offset(-5*WidthScale);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            
        }];
        
        
        UIView *bottomView = [UIView new];
        bottomView.backgroundColor = [UIColor colorWithWhite:0.878 alpha:1.000];
        [self.contentView addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.newsImage.mas_bottom).offset(5*HeightScale);
            make.left.mas_equalTo(self.contentView.mas_left).offset(10*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 0.5));
        }];
        
        
        
        self.hyb_lastViewInCell = bottomView;
        self.hyb_bottomOffsetToCell = 0.0;
        
    }
    
    
    
    return self;
}
- (void) configModel:(MyCollectionModel *)model {
//    self.titleLabel.text = model.title;
    
    self.identityLabel.text = model.username;
    
    self.newsNumberLabel.text = model.count;
    
    
    
    if (model.title.length != 0) {
        NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc]init];
        muStyle.lineSpacing = 3;//设置行间距离
        muStyle.alignment = NSTextAlignmentLeft;//对齐方式
        NSMutableAttributedString *titleString = [[NSMutableAttributedString alloc] initWithString:model.title];
        [titleString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0*HeightScale] range:NSMakeRange(0, titleString.length)];
        
        [titleString addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, titleString.length)];
        self.titleLabel.attributedText = titleString;
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.enabled = YES;//设置文字内容是否可变
        self.titleLabel.lineBreakMode =NSLineBreakByTruncatingTail;//省略结尾，以省略号代替;
        self.titleLabel.userInteractionEnabled = YES;//设置标签是否忽略或移除用户交互。默认为NO
        
        NSDictionary *titleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18.0*HeightScale],NSParagraphStyleAttributeName:muStyle};
        
        CGFloat th = [self.titleLabel.text  boundingRectWithSize:CGSizeMake(ScreenWidth-30*WidthScale, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:titleAttributes context:nil].size.height+0.5;
        
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                
                make.height.mas_equalTo(th);
                
            }];
        
    }
    else {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            
        }];
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
