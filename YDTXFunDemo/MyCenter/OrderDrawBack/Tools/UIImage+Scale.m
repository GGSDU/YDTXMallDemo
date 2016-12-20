//
//  UIImage+Scale.m
//  游钓天下
//
//  Created by 舒通 on 16/11/25.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage *)imageWithOriginImage:(UIImage *)image scale :(CGFloat)scale
{
    CGSize originSize = image.size;
    CGSize scaleSize = CGSizeMake(originSize.width * scale, originSize.height * scale);
    
    UIGraphicsBeginImageContext(scaleSize);
    [image drawInRect:CGRectMake(0,0,scaleSize.width,scaleSize.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (id)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize scaled:(CGFloat)scale
{
    
    UIGraphicsBeginImageContext(newSize);
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
   
    //    NSLog(@"压缩后图片的尺寸：%f,%f",newImage.size.width,newImage.size.height);
    
    return newImage;
}
@end
