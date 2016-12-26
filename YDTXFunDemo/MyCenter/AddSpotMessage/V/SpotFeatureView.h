//
//  SpotFeatureView.h
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/19.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SpotFeatureViewDelegate <NSObject>

- (void)didClickSpotStypeBtn:(UIButton *)button tag:(NSInteger) tag;

@end


@interface SpotFeatureView : UIView

@property (nonatomic, assign) id<SpotFeatureViewDelegate>delegate;

@end
