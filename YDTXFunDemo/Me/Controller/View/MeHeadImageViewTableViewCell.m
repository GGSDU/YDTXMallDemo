//
//  MeHeadImageViewTableViewCell.m
//  YDTX
//
//  Created by 舒通 on 16/10/11.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeHeadImageViewTableViewCell.h"

@interface MeHeadImageViewTableViewCell()

@property (strong, nonatomic) UIImageView *headBackGroundImageView;//背景图
@property (strong, nonatomic) UIImageView *headerImage;//头像视图
@property (strong, nonatomic) UIButton *nameButton;//昵称视图
//@property (strong, nonatomic) UIImageView *sexImage;//性别视图

//          用户标签不能写死

@property (strong, nonatomic) UIButton *identifyButton;




@end
@implementation MeHeadImageViewTableViewCell

- (UIImageView *)headBackGroundImageView {
    if (!_headBackGroundImageView) {
        _headBackGroundImageView = [[UIImageView alloc]init];
        _headBackGroundImageView.image = [UIImage imageNamed:@"headbg"];
        _headBackGroundImageView.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_headBackGroundImageView];
        
        [_headBackGroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top);
            make.left.mas_equalTo(self.contentView.mas_left);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth, 180*HeightScale));
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_headBackGroundImageView addGestureRecognizer:tap];
        
    }
    return _headBackGroundImageView;
}

- (UIImageView *)headerImage {
    if (!_headerImage) {
        _headerImage = [UIImageView new];
        _headerImage.userInteractionEnabled = YES;
        
#pragma mark ------根据登录状态来改变头像--------

            _headerImage.image = [UIImage imageNamed:@"头像"];

        [self.headBackGroundImageView addSubview:_headerImage];
        [_headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headBackGroundImageView.mas_top).offset(20*HeightScale);
            make.centerX.mas_equalTo(self.headBackGroundImageView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(90*HeightScale, 90*HeightScale));
        }];
        
    }
    return _headerImage;
}

- (UIButton *)nameButton {
    if (!_nameButton) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nameButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_nameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
//        if (self.isLogin) {
//            [_nameButton setTitle:self.nameString forState:UIControlStateNormal];
//        } else {
            [_nameButton setTitle:@"登录/注册" forState:UIControlStateNormal];
//        }
        _nameButton.tag = 10;
        [_nameButton sizeToFit];
        [self.headBackGroundImageView addSubview:_nameButton];
        [_nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.headerImage.mas_bottom).offset(5*HeightScale);
//            make.height.mas_equalTo(40*HeightScale);
//            make.width.mas_equalTo(100*WidthScale);
            make.centerX.mas_equalTo(self.headBackGroundImageView.mas_centerX);
        }];
        
        [_nameButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nameButton;
}
//- (UIImageView *)sexImage {
//    if (!_sexImage) {
//        _sexImage = [UIImageView new];
//        _sexImage.contentMode = UIViewContentModeScaleAspectFit;
//        
//        [self.headBackGroundImageView addSubview:_sexImage];
//        [_sexImage mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.top.mas_equalTo(self.nameButton.mas_top);
//            make.centerY.mas_equalTo(self.nameButton.mas_centerY);
//            make.left.mas_equalTo(self.nameButton.mas_right).offset(5*WidthScale);
////            make.size.mas_equalTo(CGSizeMake(20*WidthScale, 20*HeightScale));
//            make.width.mas_equalTo(20*WidthScale);
//        }];
//    }
//    return _sexImage;
//}

- (UIButton *)identifyButton {
    if (!_identifyButton) {
        _identifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _identifyButton.layer.cornerRadius = 5;

        [_identifyButton sizeToFit];
        [self.headBackGroundImageView addSubview:_identifyButton];

    }
    
    [_identifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameButton.mas_bottom);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        
//        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    return _identifyButton;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.isLogin = NO;
        
        self.headerImage.layer.cornerRadius = 90*HeightScale/2;
        self.headerImage.clipsToBounds = YES;
//         if ([self.sexString isEqualToString:@"1"]) {
//             self.sexImage.image = [UIImage imageNamed:@"女性"];
//         } else {
//             self.sexImage.image = [UIImage imageNamed:@"男性"];
//         }
        
         [self.identifyButton setImage:[UIImage imageNamed:@"normalUser"] forState:UIControlStateNormal];
        
    }
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickHeadImageView:tag:)]) {
        [_delegate didClickHeadImageView:self tag:self.nameButton.tag];
    }
}
- (void) tap:(UIGestureRecognizer *)gesture {
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickHeadImageView:tag:)]) {
        [_delegate didClickHeadImageView:self tag:self.nameButton.tag];
    }
}


- (void) setHeadContentStatus:(BOOL)isLogin headerURL:(NSString *)headerURL nameString:(NSString *)nameString sexString:(NSString *)sex userIdentity:(NSString *)identify {
    self.isLogin = isLogin;
    self.headerURL = headerURL;
    self.nameString = nameString;
    self.sexString = sex;
    self.userIdentify = identify;
    NSLog(@"self.sex is :%@",self.sexString);
    NSLog(@"out self.islogin is:%d",self.isLogin);
    
    if (self.isLogin) {
//        头像
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:[postHttp stringByAppendingString:self.headerURL]] placeholderImage:[UIImage imageNamed:@"zwt"]];
//        昵称
        
        [self.nameButton setTitle:self.nameString forState:UIControlStateNormal];
//        用户性别
        NSLog(@"sexString is %@",self.userIdentify);
//        if ([self.sexString isEqualToString:@"1"]) {
//            self.sexImage.image = [UIImage imageNamed:@"女性"];
//        } else {
//            self.sexImage.image = [UIImage imageNamed:@"男性"];
//        }
//        用户标签
        if ([self.userIdentify isEqualToString:@"合伙人"]) {
            [self.identifyButton setImage:[UIImage imageNamed:@"normalUser"] forState:UIControlStateNormal];
        } else {
            UIImage *image = [UIImage imageNamed:@"初级探长"];
            [self.identifyButton setImage:image forState:UIControlStateNormal];
        }
        
    } else if (self.isLogin == NO) {
        self.headerImage.image = [UIImage imageNamed:@"头像"];
        [self.nameButton setTitle:@"登录/注册" forState:UIControlStateNormal];
//        self.sexImage.image = [UIImage imageNamed:@"男性"];

        [self.identifyButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        [self.identifyButton mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
        
    }
    
    
    
    [self setNeedsLayout];
    
}

- (void)creatUI {
    
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
