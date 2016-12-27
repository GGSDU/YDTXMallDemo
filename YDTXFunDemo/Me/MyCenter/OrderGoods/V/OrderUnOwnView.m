//
//  OrderUnOwnView.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "OrderUnOwnView.h"

@interface OrderUnOwnView ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation OrderUnOwnView

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(130*HeightScale);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100*WidthScale, 100*HeightScale));
            
        }];
        
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        [_label sizeToFit];
        _label.font = [UIFont systemFontOfSize:16*HeightScale];
        _label.textColor = RGB(103, 103, 103);
        [self addSubview:_label];
        
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(30*HeightScale);
            make.centerX.mas_equalTo(self.mas_centerX);
            
        }];
        
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName labelText:(NSString *)text {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        self.imageView.image = [UIImage imageNamed:imageName];
        self.label.text = text;
        
        
    }
    
    
    
    return self;
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
