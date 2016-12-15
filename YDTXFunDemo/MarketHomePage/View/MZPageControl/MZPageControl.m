//
//  MZPageControl.m
//  IkasaInteriorIphone
//
//  Created by zhaohuan on 15/8/10.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import "MZPageControl.h"

#define MZPAGEDOT_TAG 10
#define DOT_RADIUS 10.0f
#define DOT_SP 10.0f

@interface MZPageControl()  // 声明一个私有方法, 该方法不允许对象直接使用

@end

@implementation MZPageControl

@synthesize numberOfPages;          // default is 0
@synthesize currentPage;            // default is 0. value pinned to 0..numberOfPages-1

@synthesize hidesForSinglePage;          // hide the the indicator if there is only one page. default is NO

@synthesize defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO

@synthesize pageDotAlignment;

@synthesize pageIndicatorTintImage;
@synthesize currentPageIndicatorImage;

@synthesize currentPageIndicatorTintColor;
@synthesize pageIndicatorTintColor;

@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        numberOfPages = 0;
        currentPage = 0;
        hidesForSinglePage = NO;
        defersCurrentPageDisplay = NO;
        pageDotAlignment = MZPageDotAlignmentCenter;
        pageIndicatorTintColor = RGB(159, 176, 202);
        currentPageIndicatorTintColor = [UIColor whiteColor];// 159 176 202
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        numberOfPages = 0;
        currentPage = 0;
        hidesForSinglePage = NO;
        defersCurrentPageDisplay = NO;
        pageDotAlignment = MZPageDotAlignmentCenter;
        pageIndicatorTintColor = RGB(159, 176, 202);
        currentPageIndicatorTintColor = [UIColor whiteColor];// 159 176 202
        
    }
    return self;
}

#pragma mark - public methods

/** 更新当前的页面的显示 */
- (void)updateCurrentPageDisplay
{
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    for (UIImageView *subImagView in subViews) {
        
        int i = (int)subImagView.tag - MZPAGEDOT_TAG;
        
        if (pageIndicatorTintImage && currentPageIndicatorImage) {
            [subImagView setBackgroundColor:[UIColor clearColor]];
            
            subImagView.layer.masksToBounds = NO;
            UIImage *tempImage = currentPage == i ? currentPageIndicatorImage : pageIndicatorTintImage;
            [subImagView setImage:tempImage];
        } else {
            
            [subImagView setImage:nil];
            
            UIColor *tempColor = currentPage == i ? currentPageIndicatorTintColor : pageIndicatorTintColor;
            
            subImagView.backgroundColor = tempColor;
            subImagView.layer.masksToBounds = YES;
            subImagView.layer.cornerRadius = subImagView.frame.size.width / 2.0f;
        }
    }
}

#pragma mark - touches response

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    //取得一个触摸对象（对于多点触摸可能有多个对象）
    UITouch *touch = [touches anyObject];

    //取得当前位置
    CGPoint currentPoint = [touch locationInView:self];
    
    for (UIImageView *subImageView in self.subviews) {
        
//        NSLog(@"rect %@ point %@",NSStringFromCGRect(subImageView.frame), NSStringFromCGPoint(currentPoint));
        
        if (CGRectContainsPoint(subImageView.frame, currentPoint)) {
            
            currentPage = subImageView.tag - MZPAGEDOT_TAG;
            
            [self updateCurrentPageDisplay];
            
            if (delegate && [delegate respondsToSelector:@selector(pageControl:didSelectedPageIndex:)]) {
                
                [delegate pageControl:self didSelectedPageIndex:currentPage];
            }
            break;
        }
    }
    
    
}


#pragma mark - getter setter

// 设置正常状态点按钮的图片
- (void)setPageIndicatorTintImage:(UIImage *)aPageIndicatorTintImage
{
    pageIndicatorTintImage = aPageIndicatorTintImage;
    
    [self updateDotPageImage];
}

// 设置高亮状态点按钮图片
- (void)setCurrentPageIndicatorImage:(UIImage *)aCurrentPageIndicatorImage
{
    currentPageIndicatorImage = aCurrentPageIndicatorImage;
    
    [self updateDotPageImage];
}

- (void)setPageIndicatorTintColor:(UIColor *)aPageIndicatorTintColor
{
    pageIndicatorTintColor = aPageIndicatorTintColor;
    
    [self updateDotPageColor];

}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)aCurrentPageIndicatorTintColor
{
    currentPageIndicatorTintColor = aCurrentPageIndicatorTintColor;
    
    [self updateDotPageColor];
}


- (void)setNumberOfPages:(NSInteger)aNumberOfPages
{
    numberOfPages = aNumberOfPages;
    
    // 如果这里不重置currentPage的话，会出现currentPage>=numberOfPage的情况出现，已经超出了最初设定currentPage的范围
    currentPage = 0;
    
    // 开始加载SubView
    [self loadPageSubView];
}

- (void)setCurrentPage:(NSInteger)aCurrentPage
{
    currentPage = aCurrentPage;
    
    [self checkUpdateCurrPageDisplay];
}

- (void)setHidesForSinglePage:(BOOL)aHidesForSinglePage
{
    hidesForSinglePage = aHidesForSinglePage;
    
    if (numberOfPages != 1) return;
    
    UIImageView *imageView = (UIImageView *)[self viewWithTag:0];
    imageView.hidden = aHidesForSinglePage;
}




#pragma mark - private methods

- (void)loadPageSubView
{
    if (numberOfPages <= 0) return;
    
    
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    for (UIImageView *subImagView in subViews) {
        [subImagView removeFromSuperview];
    }
    
    float dotAndSpWidth = numberOfPages * DOT_RADIUS + DOT_SP * (numberOfPages - 1);
    
    float firstDotX = [self getFirstDotXByPageAlignment:pageDotAlignment width:dotAndSpWidth];
    float dotY = (self.bounds.size.height - DOT_RADIUS) / 2;
    
    for (int i = 0; i < numberOfPages; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(firstDotX + (DOT_RADIUS + DOT_SP) * i, dotY, DOT_RADIUS, DOT_RADIUS)];
        imageView.tag = i + MZPAGEDOT_TAG;
        [self addSubview:imageView];
        
    
        if (pageIndicatorTintImage && currentPageIndicatorImage) {
    
            UIImage *tempImage = currentPage == i ? currentPageIndicatorImage : pageIndicatorTintImage;
            [imageView setImage:tempImage];
        } else {
            
            UIColor *tempColor = currentPage == i ? currentPageIndicatorTintColor : pageIndicatorTintColor;
            
            imageView.backgroundColor = tempColor;
            imageView.layer.masksToBounds = YES;
            imageView.layer.cornerRadius = imageView.frame.size.width / 2.0f;
        }
        
        //  如果hidesForSinglePage为true,则隐藏imageview
        if (numberOfPages == 1 && hidesForSinglePage) {
            imageView.hidden = YES;
        }
        
    }
}

- (void)checkUpdateCurrPageDisplay
{
    if (defersCurrentPageDisplay) return;
    
    [self updateCurrentPageDisplay];
}

/** 根据圆点显示的位置和整体的宽度来获取第一个圆点的横坐标 */
- (float)getFirstDotXByPageAlignment:(MZPageDotAlignment)aDotAlignment width:(float)aDotAndSpWidth
{
    float firstDotX = 0;
    
    switch (aDotAlignment) {
        case MZPageDotAlignmentCenter:
            firstDotX = (self.bounds.size.width - aDotAndSpWidth) / 2;
            break;
        case MZPageDotAlignmentLeft:
            firstDotX = _offset;
            break;
        case MZPageDotAlignmentRight:
            firstDotX = self.bounds.size.width - _offset - aDotAndSpWidth;
            break;
        default:
            firstDotX = (self.bounds.size.width - aDotAndSpWidth) / 2;
            break;
    }
    
    
    return firstDotX;
}

/** 根据默认的图片更新圆点图片视图 */
- (void)updateDotPageImage
{
    if (!pageIndicatorTintImage || !currentPageIndicatorImage) return;
    
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    for (UIImageView *subImageView in subViews) {
        
        BOOL isCurrPageView =  currentPage == (subImageView.tag - MZPAGEDOT_TAG);
        
        UIImage *pageImage = isCurrPageView ? currentPageIndicatorImage : pageIndicatorTintImage;
        subImageView.backgroundColor = [UIColor clearColor];
        subImageView.layer.masksToBounds = NO;
        [subImageView setImage:pageImage];
    }
}

/** 根据默认的颜色更新圆点图片视图 */
- (void)updateDotPageColor
{
    if (!pageIndicatorTintColor || !currentPageIndicatorTintColor) return;

    
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    for (UIImageView *subImageView in subViews) {
        
        BOOL isCurrPageView = currentPage == (subImageView.tag - MZPAGEDOT_TAG);
        
        UIColor *pageColor = isCurrPageView ? currentPageIndicatorTintColor : pageIndicatorTintColor;
        
        [subImageView setImage:nil];
        
        subImageView.layer.masksToBounds = YES;
        subImageView.layer.cornerRadius = subImageView.frame.size.width / 2.0f;
        subImageView.backgroundColor = pageColor;
    }
}

@end
