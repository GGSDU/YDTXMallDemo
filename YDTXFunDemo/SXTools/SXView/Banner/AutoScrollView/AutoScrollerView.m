//
//  AutoScrollerView.m
//  IkasaInteriorIphone
//
//  Created by Song on 16/2/26.
//  Copyright © 2016年 Webcity. All rights reserved.
//

#import "AutoScrollerView.h"

#import "MZPageControl.h"

#define MZPAGECONTROL_HEIGHT 12.5


@interface AutoScrollerView()<UIScrollViewDelegate,MZPageControlDelegate>
{

   UIScrollView *_scrollView;

   MZPageControl *_pageControl;

   NSInteger _imageCount;//图片总数
   NSMutableArray * _advertiseArray;

   NSInteger timerCount;
   BOOL isScrolling;

}

@end


@implementation AutoScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
   if (self) {
      timerCount = 0;
   }
   return self;
}

- (void)initSubViews{

   _imageCount = [self getPageCount];


   if (_imageCount==0 && _advertiseArray == nil) {
      return;
   }
   //添加滚动控件
   [self addScrollView];

   //添加分页控件
   [self addPageControl];
   //加载默认图片
   [self setDefaultImage];

}


- (NSInteger)getPageCount{

   NSInteger pageCounts = 0;
   if (self.dataSource && [self.dataSource respondsToSelector:@selector(pageScrollView:)]) {

      _advertiseArray  = [self.dataSource pageScrollView:self] ;
      pageCounts = [_advertiseArray count];
   }
   NSLog(@"PageCounts = %ld",(long)pageCounts);
   return pageCounts;
}

#pragma mark - 添加控件

- (void)addScrollView{

   _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //设置分页
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake((_imageCount + 2) * self.frame.size.width, self.frame.size.height) ;
    //设置当前显示的位置为中间图片
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    _scrollView.delegate = self;
   [self addSubview:_scrollView];
   
   

   UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTap)];
   [_scrollView addGestureRecognizer:tapGesture];

}

#pragma mark - 设置默认显示图片
-(void)setDefaultImage{
   CGSize scrollViewSize = self.frame.size;

   if (_advertiseArray.count == 0) {
      return;
   }

   for (int i = 0; i < _advertiseArray.count ; i++) {

      NSString *urlString = _advertiseArray[i];
      UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i + 1)*scrollViewSize.width, 0, scrollViewSize.width, scrollViewSize.height)];

       [imageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:nil options:0 completed:nil];
       [_scrollView addSubview:imageView];
   }

   UIImageView * firstImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
   NSString *firstAdvertiseInfoUrl = _advertiseArray[_advertiseArray.count - 1];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:firstAdvertiseInfoUrl] placeholderImage:nil options:0 completed:nil];
   [_scrollView addSubview:firstImageView];
   

   UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(scrollViewSize.width * (_advertiseArray.count + 1), 0, scrollViewSize.width, scrollViewSize.height)];
   NSString *lastAdvertiseInfoUrl = _advertiseArray[0];
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:lastAdvertiseInfoUrl] placeholderImage:nil options:0 completed:nil];
   [_scrollView addSubview:lastImageView];


   [_scrollView setContentOffset:CGPointMake(scrollViewSize.width, 0)];

}

#pragma mark - 添加分页控件
-(void)addPageControl{

   _pageControl = [[MZPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - MZPAGECONTROL_HEIGHT , self.bounds.size.width, MZPAGECONTROL_HEIGHT)];
   _pageControl.delegate = self;
   _pageControl.backgroundColor = [UIColor clearColor];
   _pageControl.numberOfPages = _advertiseArray.count;
   //    [self pageControl:_pageControl didSelectedPageIndex:1];
   [_pageControl setCurrentPage:0];
   [self setCurrentPageIndicatorImage:[UIImage imageNamed:@"pageControlStateHighlighted.png"]];
   [self setPageIndicatorTintImage:[UIImage imageNamed:@"pageControlStateNormal.png"]];
   [self addSubview:_pageControl];

}
#pragma mark 开始滚动

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

   isScrolling = true;

}


#pragma mark 滚动停止事件
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

   isScrolling = false;
   NSInteger page = scrollView.contentOffset.x / scrollView.frame.size.width;

   if (page == 0) {
      timerCount = _advertiseArray.count - 2;
      [_pageControl setCurrentPage:_advertiseArray.count - 1];

      [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width * ([_advertiseArray count]), 0)];
   }else if (page == [_advertiseArray count] + 1){
      timerCount = 0;
      [_pageControl setCurrentPage:0];
      // 如果是第最后一页就跳转到数组第一个元素的地点
      [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0)];
   }else {
      [_pageControl setCurrentPage:page - 1];
      timerCount = page - 2;
   }
}



#pragma mark - MZPageControlDelegate

- (void)pageControl:(MZPageControl *)aPageControl didSelectedPageIndex:(NSInteger)aIndex{

   timerCount = aIndex - 1;

   [self scrollPageToIndex:aIndex];

}


#pragma mark - private method
- (void)scrollPageToIndex:(NSInteger)index{

   CGSize viewSize = self.frame.size;
   CGRect rect = CGRectMake((index + 1 ) * viewSize.width, 0, viewSize.width, viewSize.height);
   [_scrollView scrollRectToVisible:rect animated:YES];

}

- (void)scrollViewTap{

   NSInteger page = _scrollView.contentOffset.x / _scrollView.frame.size.width;
   if (page == _advertiseArray.count + 1) {
      page = 1;
   }
   
   if (_delegate && [_delegate respondsToSelector:@selector(autoScrollView:autoScrollView:)]) {
      [_delegate autoScrollView:self autoScrollView:page-1];
   }

}

#pragma mark - pubilc method
// 设置正常状态点按钮的图片
- (void)setPageIndicatorTintImage:(UIImage *)aPageIndicatorTintImage{

   [_pageControl setPageIndicatorTintImage:aPageIndicatorTintImage];
}

// 设置高亮状态点按钮图片
- (void)setCurrentPageIndicatorImage:(UIImage *)aCurrentPageIndicatorImage{

   [_pageControl setCurrentPageIndicatorImage:aCurrentPageIndicatorImage];
}


- (void)begainAutoScroll:(NSTimer*)aTimer{

   if (isScrolling) {
      return;
   }

   timerCount ++;
   if (timerCount == _advertiseArray.count + 1) {

      timerCount = 0;
      [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
      [self scrollPageToIndex:timerCount];
      [_pageControl setCurrentPage:0];

   } else {

      [self scrollPageToIndex:timerCount];
      if (timerCount == _advertiseArray.count) {
         [_pageControl setCurrentPage:0];
      }else{
         [_pageControl setCurrentPage:timerCount];
      }
   }
}

@end
