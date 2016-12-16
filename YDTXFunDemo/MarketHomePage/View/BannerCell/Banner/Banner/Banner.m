//
//  Banner.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "Banner.h"

#import "BannerModel.h"

#import "AutoScrollerView.h"

#define AUTOSCROLL_TIME 5.0f

@interface Banner ()<AutoScrollViewDataSource,AutoScrollViewDelegate>

@property (nonatomic,strong) AutoScrollerView *pageScrollView;
@property (nonatomic,strong) NSTimer *timer;

@end

@implementation Banner

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        _pageScrollView = [[AutoScrollerView alloc] initWithFrame:[[SXPublicTool keyWindow] bounds]];
        _pageScrollView.dataSource = self;
        _pageScrollView.delegate = self;
        _pageScrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageScrollView];
        
        
        // 创建自动滑动定制器
        _timer = [NSTimer scheduledTimerWithTimeInterval:AUTOSCROLL_TIME target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
    return self;
}

#pragma mark - public methods
-(void)createAutoScrollerView
{
    _pageScrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [_pageScrollView initSubViews];
}

#pragma mark - MZPageScrollViewDataSource

- (NSMutableArray *)pageScrollView:(AutoScrollerView *)pageScrollView
{
    NSMutableArray * array = [[NSMutableArray alloc] init];
    
    for (BannerModel * info in _bannerArray) {
        
        [array addObject:info.advertiseUrl];
    }
    return array;
}

#pragma mark - AutoScrollViewDelegate
- (void)autoScrollView:(AutoScrollerView *)pageScrollView autoScrollView:(NSInteger)aIndex
{
    if (_delegate && [_delegate respondsToSelector:@selector(banner:didSelectedAtIndex:)]) {
        [_delegate banner:self didSelectedAtIndex:aIndex];
    }
}


#pragma mark - private methods
- (void)timerFired:(NSTimer*)timer{
    
    [_pageScrollView begainAutoScroll:timer];
}
//
///*
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//}
//*/

@end
