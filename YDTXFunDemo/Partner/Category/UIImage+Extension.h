//
//  UIImage+Extension.h
//  ZZBS
//
//  Created by 👄 on 15/12/31.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
-(instancetype)circleImage;

+(UIImage *)resizableImage:(NSString *)imageName;

// 截屏
+(instancetype)shotScreenWithView:(UIView *)view;


@end
