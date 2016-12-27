//
//  SpotAddDescribView.h
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpotAddDescribViewDelegate <NSObject>

- (void) didEditEndString:(NSString *) text;

@end

@interface SpotAddDescribView : UIView

- (instancetype)initWithFrame:(CGRect)frame collectionViewBackGroundColorArr:(NSArray *)colorArr palceHoldString:(NSString *)string;

@property (assign, nonatomic) id<SpotAddDescribViewDelegate>delegate;

@end
