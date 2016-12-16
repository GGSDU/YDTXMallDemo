//
//  CategoryCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CategoryCell.h"
@implementation CategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

#pragma mark - create UI 
- (void)createUI{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_label];
    }
    
    [_label mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
}

@end
