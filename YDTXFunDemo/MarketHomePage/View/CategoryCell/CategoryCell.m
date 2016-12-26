//
//  CategoryCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CategoryCell.h"

#pragma mark - CategoryModel
@implementation CategoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        return self.ID;
    }
    return nil;
}

@end

#pragma mark - CategoryCell
@implementation CategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

#pragma mark - create UI 
- (void)createUI{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(15);
        make.bottom.equalTo(_label.mas_top).offset(-10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(45, 45));
    }];
    
    [_label mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(_imageView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.centerX.equalTo(self);
        
    }];
}

@end
