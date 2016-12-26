//
//  SDCycleDispalyView.h
//  SDNews
//
//  Created by JW on 16/5/24.
//  Copyright © 2016年 JW. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SDCycleDispalyViewDelegate <NSObject>
@optional

- (void)clickCurrentImageViewInImageCyclePlay;

@end

@interface SDCycleDispalyView : UIView

/**多张图片的地址*/
@property (nonatomic, strong) NSArray *imageUrls;

/**显示文字的数组*/
@property (nonatomic, strong) NSArray *titles;

//圆点选中颜色
@property(strong,nonatomic)UIColor *selectColor;
//圆点默认颜色
@property(strong,nonatomic)UIColor *defaultColor;
/**当前显示的页面的下标*/
@property (nonatomic, assign) NSInteger currentMiddleImageViewIndex;

/*监听ImageView的点击*/
@property (nonatomic, weak) id<SDCycleDispalyViewDelegate> delegate;




-(instancetype)initWithFrame:(CGRect)frame;

// 更新数据 刷新
- (void)updateImageViewsAndTitleLabel;

/**管理定时器*/
- (void)addTimer;
- (void)removeTimer;


-(void)updateToDaySkinMode;
-(void)updateToNightSkinMode;


@end
