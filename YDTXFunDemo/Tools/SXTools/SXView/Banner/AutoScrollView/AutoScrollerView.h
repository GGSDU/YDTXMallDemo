//
//  AutoScrollerView.h
//  IkasaInteriorIphone
//
//  Created by Song on 16/2/26.
//  Copyright © 2016年 Webcity. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AutoScrollerView;

@protocol AutoScrollViewDataSource <NSObject>

- (NSMutableArray *)pageScrollView:(AutoScrollerView *)pageScrollView;

@end

@protocol AutoScrollViewDelegate <NSObject>

- (void)autoScrollView:(AutoScrollerView *)pageScrollView autoScrollView:(NSInteger)aIndex;

@end

@interface AutoScrollerView : UIView

@property (nonatomic, assign) id<AutoScrollViewDataSource> dataSource;
@property (nonatomic, assign) id<AutoScrollViewDelegate> delegate;
// 设置正常状态点按钮的图片
- (void)setPageIndicatorTintImage:(UIImage *)aPageIndicatorTintImage;
// 设置高亮状态点按钮图片
- (void)setCurrentPageIndicatorImage:(UIImage *)aCurrentPageIndicatorImage;
- (void)initSubViews;
- (void)begainAutoScroll:(NSTimer *)timer;

@end
