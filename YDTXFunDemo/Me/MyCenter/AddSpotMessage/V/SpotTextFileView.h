//
//  SpotTextFileView.h
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SpotTextFileViewDelegate <NSObject>

- (void) didEditEndString:(NSString *)textString tag:(NSInteger) tag;

@optional

- (void) didSelectProv:(NSString *)prov city:(NSString *)city area:(NSString *)area;

@end

@interface SpotTextFileView : UIView

- (instancetype)initWithFrame:(CGRect)frame Array:(NSArray *)placeholdList;

@property (assign, nonatomic) id<SpotTextFileViewDelegate>delegate;

@end
