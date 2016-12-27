//
//  HistoryCollectionViewCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 27/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "HistoryCollectionViewCell.h"

@interface HistoryCollectionViewCell ()


@end

@implementation HistoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        self.backgroundColor = [UIColor whiteColor];
        
        [self creatUI];
    }
    return self;
}

#pragma mark - createUI
- (void)creatUI{
    
    if (_textLabel == nil) {
        _textLabel =  [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = RGB(77, 77, 77);
        [self addSubview:_textLabel];
    }
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left).offset(20);
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
}

@end
