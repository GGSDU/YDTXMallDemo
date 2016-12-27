//
//  LogisticsHeaderView.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "LogisticsHeaderView.h"
#import "CallMobile.h"

@interface LogisticsHeaderView ()<CallMobileDelegate>

@property (nonatomic, strong) UIImageView *goodsImgV;//商品图片
@property (nonatomic, strong) UILabel *logisticsStatusLabel;//物流状态
@property (nonatomic, strong) UILabel *logisticsSourceLabel;//承运来源
@property (nonatomic, strong) UILabel *logisticsNumLabel;//订单编号
@property (nonatomic, strong) UILabel *logisticsMobileLabe;//电话

@property (nonatomic, strong) CallMobile *callMobile;
@property (nonatomic, copy) NSString *mobileNum;//电话号码

@end

@implementation LogisticsHeaderView

- (UIImageView *)goodsImgV {
    if (!_goodsImgV) {
        _goodsImgV = [UIImageView new];
        _goodsImgV.backgroundColor = [UIColor purpleColor];
        [self addSubview:_goodsImgV];
        [_goodsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(15*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(12*WidthScale);
            make.size.mas_equalTo(CGSizeMake(60*HeightScale, 60*HeightScale));
            NSLog(@"heightScale is :%f",HeightScale);
            
        }];
    }
    return _goodsImgV;
}

- (UILabel *)logisticsStatusLabel {
    if (!_logisticsStatusLabel) {
        _logisticsStatusLabel = [UILabel new];
        [_logisticsStatusLabel sizeToFit];
        _logisticsStatusLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsStatusLabel.textColor = RGB(40, 40, 40);
        [self addSubview:_logisticsStatusLabel];
        [_logisticsStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.goodsImgV.mas_top);
            make.left.mas_equalTo(self.goodsImgV.mas_right).offset(14*HeightScale);
            make.right.mas_equalTo(self.mas_right).offset(-10);
        }];
        
    }
    return _logisticsStatusLabel;
}

- (UILabel *)logisticsSourceLabel {
    if (!_logisticsSourceLabel) {
        _logisticsSourceLabel = [UILabel new];
        [_logisticsSourceLabel sizeToFit];
        _logisticsSourceLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsSourceLabel.textColor = RGB(141, 141, 141);
        [self addSubview:_logisticsSourceLabel];
        [_logisticsSourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logisticsStatusLabel.mas_bottom);
            make.left.mas_equalTo(self.logisticsStatusLabel.mas_left);
            make.right.mas_equalTo(self.logisticsStatusLabel.mas_right);
            
        }];
        
    }
    return _logisticsSourceLabel;
}

- (UILabel *)logisticsNumLabel {
    if (!_logisticsNumLabel) {
        _logisticsNumLabel = [UILabel new];
        [_logisticsNumLabel sizeToFit];
        _logisticsNumLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsNumLabel.textColor = RGB(141, 141, 141);
        [self addSubview:_logisticsNumLabel];
        [_logisticsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logisticsSourceLabel.mas_bottom);
            make.left.right.mas_equalTo(self.logisticsSourceLabel);
            
        }];
    }
    return _logisticsNumLabel;
}

- (UILabel *)logisticsMobileLabe {
    if (!_logisticsMobileLabe) {
        _logisticsMobileLabe = [UILabel new];
        [_logisticsMobileLabe sizeToFit];
        _logisticsMobileLabe.font = [UIFont systemFontOfSize:15*HeightScale];
        _logisticsMobileLabe.textColor = RGB(141, 141, 141);
        
        [self addSubview:_logisticsMobileLabe];
        
        [_logisticsMobileLabe mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logisticsNumLabel.mas_bottom);
            make.left.mas_equalTo(self.logisticsNumLabel.mas_left);
        }];
    }
    return _logisticsMobileLabe;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.userInteractionEnabled = YES;
        
        self.goodsImgV.image = [UIImage imageWithContentsOfFile:imagePath];
        self.logisticsStatusLabel.text = @"物流状态：";
        self.logisticsSourceLabel.text = @"承运来源：";
        self.logisticsNumLabel.text = @"运单编号：";
        self.logisticsMobileLabe.text = @"官方电话：";
        self.logisticsMobileLabe.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self.logisticsMobileLabe addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)getDataReloadView:(LogisticsModel *)model {
    
    [self.goodsImgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",self.imageURL]] placeholderImage:[UIImage imageWithContentsOfFile:imagePath]];
    
    NSString *str = nil;
    switch (model.state) {
        case -1:
            str = @"待查询";
            break;
        case 0:
            str = @"查询异常";
            break;
        case 1:
            str = @"暂无记录";
            break;
        case 2:
            str = @"在途中";
            break;
        case 3:
            str = @"派送中";
            break;
        case 4:
            str = @"已签收";
            break;
        case 5:
            str = @"用户拒签";
            break;
        case 6:
            str = @"疑难件";
            break;
        case 7:
            str = @"无效单";
            break;
        case 8:
            str = @"超时单";
            break;
        case 9:
            str = @"签收失败";
            break;
        case 10:
            str = @"退回";
            break;
        default:
            str = @"未知";
            break;
    }
    
    
    NSString *textString = [@"物流状态：" stringByAppendingString:str];
    self.logisticsStatusLabel.attributedText = [self changTextColor:textString];

    
    
    if (model.mailNo) {
        
        self.logisticsNumLabel.text = [NSString stringWithFormat:@"运单编号：%@",model.mailNo];
    }
    if (model.courier) {
        self.logisticsSourceLabel.text = [@"承运来源：" stringByAppendingString:model.courier];
        
    }
    
   
    if (model.tel) {
        
        NSString *mobileString = [NSString stringWithFormat:@"官方电话：%@",model.tel];
        self.logisticsMobileLabe.attributedText = [self changTextColor:mobileString];
        
        self.mobileNum = model.tel;
    }
    
   
    
}

#pragma mark chang text color
- (NSMutableAttributedString *)changTextColor:(NSString *)string {
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:string];
    NSLog(@"--%@---%@",text,string);
    if (string.length > 5) {
        
        [text addAttribute:NSForegroundColorAttributeName value:RGB(65, 201, 239) range:NSMakeRange(5, string.length-5)];
    }
    

    return text;
}

#pragma mark 拨打电话

- (void) tapAction:(UITapGestureRecognizer *)tap {
    
    self.callMobile = [[CallMobile alloc]initWithFrame:[UIScreen mainScreen].bounds mobileNum:self.mobileNum];
    self.callMobile.delegate = self;
    
    [self.window addSubview:self.callMobile];
}

#pragma mark ---拨打电话的delegate

- (void)didCancelCall {
    [self.callMobile removeFromSuperview];
}

- (void)didCallBtnTag {
    // 提示拨打方法1：
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@", self.callMobile.mobileLabel.text];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self addSubview:callWebview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
