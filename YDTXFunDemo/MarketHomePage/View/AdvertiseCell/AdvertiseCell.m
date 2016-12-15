//
//  AdvertiseCell.m
//  IkasaInteriorIphone
//
//  Created by webcity on 16/2/24.
//  Copyright © 2016年 Webcity. All rights reserved.
//

#import "AdvertiseCell.h"

#import "AutoScrollerView.h"
#import "AdvertiseInfo.h"

#define AUTOSCROLL_TIME 5.0f

@interface AdvertiseCell ()<AutoScrollViewDataSource,AutoScrollViewDelegate>
{
    AutoScrollerView *_pageScrollView;
    NSTimer *_timer;
}
@end

@implementation AdvertiseCell   
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        _pageScrollView = [[AutoScrollerView alloc] initWithFrame:[[SXPublicTool keyWindow] bounds]];
        _pageScrollView.dataSource = self;
       _pageScrollView.delegate = self;
        _pageScrollView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_pageScrollView];

        
        // 创建自动滑动定制器
        _timer = [NSTimer scheduledTimerWithTimeInterval:AUTOSCROLL_TIME target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    }
    return  self;
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
    
    for (AdvertiseInfo * info in _advertiseArray) {
        
        [array addObject:info.advertiseUrl];
    }
    return array;
}

#pragma mark - AutoScrollViewDelegate
- (void)autoScrollView:(AutoScrollerView *)pageScrollView autoScrollView:(NSInteger)aIndex
{
   if (_delegate && [_delegate respondsToSelector:@selector(advertiseCell:didSelectedAtIndex:)]) {
      [_delegate advertiseCell:self didSelectedAtIndex:aIndex];
   }
}


#pragma mark - private methods
- (void)timerFired:(NSTimer*)timer{
    
    [_pageScrollView begainAutoScroll:timer];
}


@end
