//
//  UIImage+Extension.m
//  ZZBS
//
//  Created by 👄 on 15/12/31.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


// 变圆
-(instancetype)circleImage
{

    
    // 开启bitmap上下文
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个矩形
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);

    // 方形变圆形
    CGContextAddEllipseInRect(ctx, rect);


    // 裁剪
    CGContextClip(ctx);

    // 将图片画上去
    [self drawInRect:rect];
    

    
    // 从上下文中得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    // 关闭上下文
    UIGraphicsEndImageContext();
    
    
    return image;
}



// 拉伸
+(UIImage *)resizableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    
    // 3个方法都可以指定拉伸某个位置
    //    [image stretchableImageWithLeftCapWidth:<#(NSInteger)#> topCapHeight:<#(NSInteger)#>];
    //
    //    [image resizableImageWithCapInsets:<#(UIEdgeInsets)#>];
    
    
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5, imageW * 0.5) resizingMode:UIImageResizingModeStretch];
}


// 根据某个view截屏  主layer上自动包含子视图的layer，默认截屏所有子控件
+(instancetype)shotScreenWithView:(UIView *)view
{
    // 开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 拿到上下文
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    // 把这个view的layer绘制到上下文  只能渲染
    [view
     .layer renderInContext:ref];
    
    
    
    //    [view.layer drawInContext:<#(nonnull CGContextRef)#>];
    
    // 从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}



@end
