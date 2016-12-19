//
//  MZPageScrollView.h
//  IkasaInteriorIphone
//
//  Created by zhaohuan on 15/8/11.
//  Copyright (c) 2015年 Webcity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZPageScrollView;

@protocol MZPageScrollViewDelegate <NSObject>

- (void)pageScrollView:(MZPageScrollView *)aMZPageScrollView didSelectedIndex:(int)index;

@end

@protocol MZPageScrollViewDataSource <NSObject>

- (NSInteger)pageScrollView:(MZPageScrollView *)pageScrollView;

- (UIView *)pageScrollView:(MZPageScrollView *)pageScrollView cellForRowAtIndex:(int)index tag:(NSInteger)tag;

@end

@interface MZPageScrollView : UIView

@property (nonatomic, assign) id<MZPageScrollViewDelegate> delegate;
@property (nonatomic, assign) id<MZPageScrollViewDataSource> dataSource;

- (void)reloadPageData;

// 设置正常状态点按钮的图片
- (void)setPageIndicatorTintImage:(UIImage *)aPageIndicatorTintImage;

// 设置高亮状态点按钮图片
- (void)setCurrentPageIndicatorImage:(UIImage *)aCurrentPageIndicatorImage;

//- (void)autoScroller;

@end
