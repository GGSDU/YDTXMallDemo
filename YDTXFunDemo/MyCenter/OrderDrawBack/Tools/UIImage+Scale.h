//
//  UIImage+Scale.h
//  游钓天下
//
//  Created by 舒通 on 16/11/25.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

/* add by Story5,to scale image
 * prama : 0 < scale < 1
 */
+ (UIImage *)imageWithOriginImage:(UIImage *)image scale:(CGFloat )scale;

+ (id)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize scaled:(CGFloat)scale;
@end
