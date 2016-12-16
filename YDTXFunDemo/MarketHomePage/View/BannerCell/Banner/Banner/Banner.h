//
//  Banner.h
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Banner;

@protocol BannerDelegate <NSObject>

- (void)banner:(Banner *)banner didSelectedAtIndex:(NSInteger)index;

@end

@interface Banner : UIView

@property (nonatomic, assign) id<BannerDelegate>delegate;
@property (nonatomic, strong) NSArray *bannerArray;

- (void)createAutoScrollerView;

@end
