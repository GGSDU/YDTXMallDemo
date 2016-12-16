//
//  MZPageScrollView.m
//  IkasaInteriorIphone
//
//  Created by zhaohuan on 15/8/11.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import "MZPageScrollView.h"

#import "MZPageControl.h"

#define MZPAGECONTROL_HEIGHT 20.0f
#define PAGESCROLL_SUBVIEW_TAG 20

@interface MZPageScrollView () <MZPageControlDelegate, UIScrollViewDelegate>
{
    BOOL _scrollViewAnimationEnd;
    UITapGestureRecognizer *_singletap;
    NSTimer * timer ;
    NSInteger timerCount;
    NSInteger pageCount;
}

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, strong) MZPageControl *mzPageControl;

@end

@implementation MZPageScrollView
@synthesize delegate;
@synthesize dataSource;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollViewAnimationEnd = YES;
        
        [self addSubview:self.pageScrollView];
        [self addSubview:self.mzPageControl];
        
        
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    //
    _singletap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [_singletap setNumberOfTapsRequired:1];
    [self.pageScrollView addGestureRecognizer:_singletap];
}

- (void)willRemoveSubview:(UIView *)subview
{    
    [super willRemoveSubview:subview];
}

#pragma mark - public methods

- (void)setDataSource:(id<MZPageScrollViewDataSource>)aDataSource
{
    dataSource = aDataSource;
    
    [self reloadPageData];
 
}

- (void)setPageIndicatorTintImage:(UIImage *)aPageIndicatorTintImage
{
    [self.mzPageControl setPageIndicatorTintImage:aPageIndicatorTintImage];
}

- (void)setCurrentPageIndicatorImage:(UIImage *)aCurrentPageIndicatorImage
{
    [self.mzPageControl setCurrentPageIndicatorImage:aCurrentPageIndicatorImage];
}


/** 加载数据 */
- (void)reloadPageData
{
    NSArray *array = [NSArray arrayWithArray:self.pageScrollView.subviews];
    for (UIView *tempUIView in array) {
        [tempUIView removeFromSuperview];
    }
    
    pageCount = [self getPageCount];
    self.mzPageControl.numberOfPages = pageCount;
//    self.mzPageControl.currentPage = 0;
    [self pageControl:self.mzPageControl didSelectedPageIndex:0];
    
    float scrollViewWidth = 0.0f;
    for (int i = 0; i < pageCount; i++) {
        
        UIView *view = [self getPageViewByIndex:i];
        
        if (view == nil) return;
        
        view.tag = i + PAGESCROLL_SUBVIEW_TAG;
        [self.pageScrollView addSubview:view];
        
        scrollViewWidth += view.frame.size.width;
    }

    self.pageScrollView.contentSize = CGSizeMake(scrollViewWidth, self.pageScrollView.frame.size.height);
}

#pragma mark - touches response

- (void)handleSingleTap:(id *)aSender
{
    if (!_scrollViewAnimationEnd) return;
    
    int index = (int)_mzPageControl.currentPage;
    
//    NSLog(@"index %d",index);
    
    if (delegate && [delegate respondsToSelector:@selector(pageScrollView:didSelectedIndex:)]) {
        [delegate pageScrollView:self didSelectedIndex:index];
    }
}

#pragma mark - MZPageControlDelegate

- (void)pageControl:(MZPageControl *)aPageControl didSelectedPageIndex:(NSInteger)aIndex
{
    CGSize viewSize = self.pageScrollView.frame.size;
    CGRect rect = CGRectMake(aIndex * viewSize.width, 0, viewSize.width, viewSize.height);
    [self.pageScrollView scrollRectToVisible:rect animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"开始");
    _scrollViewAnimationEnd = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"结束");
    _scrollViewAnimationEnd = YES;
    
    int pageNumber = (int)fabs(scrollView.contentOffset.x /scrollView.frame.size.width);
    
    [self.mzPageControl setCurrentPage:pageNumber];

    if (dataSource && [dataSource respondsToSelector:@selector(pageScrollView:cellForRowAtIndex:tag:)]) {
        [dataSource pageScrollView:self cellForRowAtIndex:pageNumber tag:pageNumber + PAGESCROLL_SUBVIEW_TAG];
    }
}



#pragma mark - getter setter

- (MZPageControl *)mzPageControl
{
    if (!_mzPageControl) {
        _mzPageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - MZPAGECONTROL_HEIGHT, self.bounds.size.width, MZPAGECONTROL_HEIGHT)];
        _mzPageControl.delegate = self;
        _mzPageControl.backgroundColor = [UIColor clearColor];
    }
    return _mzPageControl;
}

-(UIScrollView * )pageScrollView
{
    if(!_pageScrollView) {
        _pageScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _pageScrollView.showsHorizontalScrollIndicator = NO;
        _pageScrollView.showsVerticalScrollIndicator = NO;
        _pageScrollView.bounces = NO;
        _pageScrollView.pagingEnabled = YES;
        _pageScrollView.delegate = self;
    }
    return _pageScrollView;
}

#pragma mark - private methods



/** 获取页数 */
- (NSInteger)getPageCount
{
    NSInteger pageCounts = 0;
    if (dataSource && [dataSource respondsToSelector:@selector(pageScrollView:)]) {
        pageCounts = [dataSource pageScrollView:self];
    }
    return pageCounts;
}

/** 根据页码索引获取当前页的视图 */
- (UIView *)getPageViewByIndex:(int)aIndex
{
    UIView *view = nil;
    
    if (dataSource && [dataSource respondsToSelector:@selector(pageScrollView:cellForRowAtIndex:tag:)]) {
        view = [dataSource pageScrollView:self cellForRowAtIndex:aIndex tag:PAGESCROLL_SUBVIEW_TAG + aIndex];
    }
    return view;
}

@end
