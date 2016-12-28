//
//  WatchMoreCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "WatchMoreFooterReusableView.h"

@interface WatchMoreFooterReusableView ()

@property (nonatomic,strong) UIButton *watchMoreButton;

@end

@implementation WatchMoreFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        [self createUI];
    }
    return self;
}

- (void)clickWatchMoreButton:(UIButton *)aSender{
    
    self.watchMoreHandler(aSender);
}

#pragma mark - create UI
- (void)createUI{
    if (_watchMoreButton == nil) {
        _watchMoreButton = [[UIButton alloc] init];
        _watchMoreButton.layer.cornerRadius = 5;
        _watchMoreButton.backgroundColor = [UIColor whiteColor];
        [_watchMoreButton setTitle:@"查看更多" forState:UIControlStateNormal];
        [_watchMoreButton setTitleColor:RGB(65, 65, 65) forState:UIControlStateNormal];
        [_watchMoreButton addTarget:self action:@selector(clickWatchMoreButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_watchMoreButton];
    }
    
    NSLog(@"*******%@",NSStringFromCGRect(self.frame));
    [_watchMoreButton mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];
}

@end
