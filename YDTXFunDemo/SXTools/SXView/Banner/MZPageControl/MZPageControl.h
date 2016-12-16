//
//  MZPageControl.h
//  IkasaInteriorIphone
//
//  Created by zhaohuan on 15/8/10.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    MZPageDotAlignmentLeft = 0,
    MZPageDotAlignmentCenter,
    MZPageDotAlignmentRight
} MZPageDotAlignment;

@class MZPageControl;

@protocol MZPageControlDelegate <NSObject>

- (void)pageControl:(MZPageControl *)aPageControl didSelectedPageIndex:(NSInteger)aIndex;

@end

@interface MZPageControl : UIView
{
    
@private
    
    float _offset;
    
//    NSInteger       _currentPage;
//    NSInteger       _displayedPage;
    
    BOOL hidesForSinglePage;
    BOOL defersCurrentPageDisplay;
    
//    MZPageDotAlignment _pageDotAlignment;
    
    UIImage* pageIndicatorTintImage;
    UIImage* currentPageIndicatorImage;
    
    UIColor *pageIndicatorTintColor;
    UIColor *currentPageIndicatorTintColor;
    
}

@property(nonatomic) NSInteger numberOfPages;          // default is 0
@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1

@property(nonatomic) BOOL hidesForSinglePage;          // hide the the indicator if there is only one page. default is NO

@property(nonatomic) BOOL defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO

@property(nonatomic) MZPageDotAlignment pageDotAlignment;
// 设置圆点显示的位置 居中 左边 右边  (如果有需要请设置offset，如果不设置，offset默认为20) 默认为 MZPageDotAlignmentCenter

@property (nonatomic, strong) UIImage *pageIndicatorTintImage;
@property (nonatomic, strong) UIImage *currentPageIndicatorImage; // 优先级比颜色高

@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

@property (nonatomic, assign) id<MZPageControlDelegate> delegate;

- (void)updateCurrentPageDisplay;                      // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately

@end
