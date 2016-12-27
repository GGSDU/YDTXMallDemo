//
//  ReceiveTableViewCell.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//


#import "ReceiveTableViewCell.h"
#import "AddressListModel.h"


@interface ReceiveTableViewCell ()

@property (nonatomic, strong) UILabel *statusLabel;//状态label
@property (nonatomic, strong) UIButton *statusBtn;//状态img

@property (nonatomic, strong) UILabel *nameLabel;//姓名
@property (nonatomic, strong) UILabel *mobileLabel;//电话号码
@property (nonatomic, strong) UILabel *addressLabel;//地址
@property (nonatomic, strong) UIImageView *editImgV;//编辑按钮

@property (nonatomic, copy) NSString *addID;//地址id
@property (nonatomic, copy) NSString *statu;//是否为默认状态


@end

@implementation ReceiveTableViewCell
#pragma mark lazy

#pragma mark statusBtn
- (UIButton *)statusBtn {
    if (!_statusBtn) {
        _statusBtn = [UIButton new];
//        [_statusBtn setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateNormal];//
//        [_statusBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateSelected];//选中状态
        
        _statusBtn.selected = NO;
        _statusBtn.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView addSubview:_statusBtn];
        [_statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(14*WidthScale);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.contentView.mas_height);
            make.width.mas_equalTo(0);
        }];
    }
    return _statusBtn;
}
#pragma mark statusLabel
- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        [_statusLabel sizeToFit];
        _statusLabel.font = [UIFont systemFontOfSize:18*HeightScale];
        _statusLabel.textColor = [UIColor colorWithRed:252.0 / 255.0 green:75.0 / 255.0 blue:0 alpha:1];
        [self.contentView addSubview:_statusLabel];
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.statusBtn.mas_right).offset(10*WidthScale);
            make.top.mas_equalTo(18*HeightScale);
            make.width.mas_equalTo(0);
            
        }];
    }
    return _statusLabel;
}


#pragma mark  name
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.font = [UIFont systemFontOfSize:16*HeightScale];
        [_nameLabel sizeToFit];
        _nameLabel.text = @"";
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {

            make.top.mas_equalTo(self.contentView.mas_top).offset(18*HeightScale);
            make.left.mas_equalTo(self.statusLabel.mas_right);
//            make.width.mas_lessThanOrEqualTo(50);
            
        }];
    }
    
    return _nameLabel;
}
#pragma mark mobile
- (UILabel *)mobileLabel {
    if (!_mobileLabel) {
        _mobileLabel = [UILabel new];
        _mobileLabel.font = [UIFont systemFontOfSize:16*HeightScale];
        [_mobileLabel sizeToFit];
        _mobileLabel.text = @"";
        [self.contentView addSubview:_mobileLabel];
        [_mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.nameLabel.mas_top);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-80*WidthScale);
            make.left.mas_equalTo(self.nameLabel.mas_right).offset(35*WidthScale);//距离左侧的距离
        }];
    }
    return _mobileLabel;
}

#pragma mark address
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [UILabel new];
        
        _addressLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        [_addressLabel sizeToFit];
        
        _addressLabel.text = @"";
        
        [self.contentView addSubview:_addressLabel];
        
        [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.statusLabel.mas_left);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(10*HeightScale);
            make.right.mas_equalTo(self.contentView.mas_right).offset(-80*WidthScale);
        }];
        
    }
    
    return _addressLabel;
}

#pragma mark editImgV

- (UIImageView *)editImgV {
    if (!_editImgV) {
        _editImgV = [UIImageView new];
        _editImgV.image = [UIImage imageNamed:@"edit"];
        _editImgV.contentMode = UIViewContentModeScaleAspectFit;
        _editImgV.userInteractionEnabled = YES;
        
        [self.contentView addSubview:_editImgV];
        [_editImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-10*WidthScale);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(25*WidthScale, 25*WidthScale));
        }];
    }
    return _editImgV;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier addressModel:(AddressListModel *)addressModel {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.addID = addressModel.adres_id;
        self.statu = addressModel.status;
        
        
        
        NSLog(@"--%@---%@--%@--%@__%@__%@__",addressModel.user_name,addressModel.mobile,addressModel.prov,addressModel.city,addressModel.area,addressModel.status);
        
        self.nameLabel.text = addressModel.user_name;
        
        self.mobileLabel.text = addressModel.mobile;
        self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",addressModel.prov,addressModel.city,addressModel.area,addressModel.address];
        
        if ([addressModel.status isEqualToString:@"1"]) {
            [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20*WidthScale);
//                make.height.mas_equalTo(20*WidthScale);
            }];
            
            self.statusLabel.text = @"[默认]";
            [self.statusLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(50*WidthScale);
            }];
        }
        
        
//      添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(editImgV:)];
        [self.editImgV addGestureRecognizer:tap];

        
    }
    
    
    return self;
}

- (void)editImgV:(UITapGestureRecognizer *)tap {
    
    if (_delegate && [_delegate respondsToSelector:@selector(didClickedEdit:addressID:status:)]) {
        [_delegate didClickedEdit:(UIImageView *)tap.view addressID:self.addID status:self.statu];
        NSLog(@"编辑");
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setStatus:(BOOL)enter compile:(BOOL)compile select:(BOOL)selected {
//    把cell的选中状态传出去
    _cellStatus = selected;
    
    if (enter == YES) {//个人中心入口
        if (compile == YES) {//编辑状态
            
            [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20*WidthScale);
            }];
            
            if (selected == YES) {
                [self.statusBtn setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateNormal];//选中状态
            }else {
                [self.statusBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];//未选中状态
            }
            
        } else { // 非编辑状态
            [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(0*WidthScale);
            }];
        }
        
    }
    else { // 商城入口
        if (compile == YES) { //编辑状态
            [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(20*WidthScale);
            }];
            
            if (selected == YES) { //选中状态
                 [self.statusBtn setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateNormal];//选中状态
            } else { //为选中状态
                 [self.statusBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];//未选中状态
                
            }
            
        } else { // 非编辑状态
            if (selected == YES) { //选中状态
                [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(20*WidthScale);
                }];
                
                [self.statusBtn setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];//选中状态
                
            } else { //未选中状态
                [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(0*WidthScale);
                }];
            }
        }
    }
    [self setNeedsLayout];
    
}


//- (void)setStatus:(BOOL)status btnSelected:(BOOL)selected isMyCenter:(BOOL) isMe{
//    _cellStatus = status;
//    
//    if (_cellStatus == YES) {
//        [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(20*WidthScale);
//        }];
//
//    }else {
//        [self.statusBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(0);
//        }];
//
//    }
//    
//   
////    如果是从个人中心进入
//    if (isMe) {
//        
//    } else {//不是从个人中心进入
//        if (status) {
//            
//        }
////        选中状态
//        if (selected == YES) {
//            
//            [self.statusBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateSelected];//选中状态
//            
//        }else {//  未选中状态
//            [self.statusBtn setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateNormal];//
//        }
//    }
//    
//    
//    [self layoutIfNeeded];
//}




-(void)setFrame:(CGRect)frame{
    frame.origin.y += 10;
    frame.size.height -=10;
    
    [super setFrame:frame];

}

@end
