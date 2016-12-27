//
//  SXPublicTool.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SXPublicTool.h"

#define BASE_URL @"http://3d.webcity3d.com:9090/Yuefang/data/Yuefang/YueFangDataSource/"


@implementation SXPublicTool

#pragma mark -
+ (NSString *)documentPath
{
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //因为documentDirectory数组只有一个元素,所以取第一个或者最后一个都是一样的
    NSString *myDocPath1 = [documentDirectory firstObject];
    NSLog(@"documentPath : %@",myDocPath1);
//    NSString *myDocPath2 = [documentDirectory lastObject];
    return myDocPath1;
//    return myDocPath2;
}

+ (UIWindow *)keyWindow
{
    return [UIApplication sharedApplication].keyWindow;
}

/** 根据基地址和拼接的url获取资源的URL */
+ (NSURL *)getResURLBySplitjointResURLString:(NSString *)splitjointResURLString
{
    NSString *resURLString = [BASE_URL stringByAppendingString:splitjointResURLString];
    
    NSURL *resURL = [NSURL URLWithString:resURLString];
    
    return resURL;
}

+ (NSString *)getImageURLStringByURLString:(NSString *)urlString
{
    NSString *website = @"test.m.yundiaoke.cn";
    NSString *imageUrlString = urlString;
    
    if ([imageUrlString hasPrefix:website]) {
        
        imageUrlString = [NSString stringWithFormat:@"http://%@",imageUrlString];
    } else {
        imageUrlString = [NSString stringWithFormat:@"http://%@%@",website,imageUrlString];
    }
    return imageUrlString;
}

+ (NSURL *)getImageURLByURLString:(NSString *)urlString
{
    NSString *imageUrlString = [SXPublicTool getImageURLStringByURLString:urlString];
    
    NSURL *url = [NSURL URLWithString:imageUrlString];
    
//    NSLog(@"fixed ImageUrl %@",imageUrlString);
    
    return url;
}

#pragma mark - image
+ (UIImage *)placeholderImageWithFrame:(CGRect)aFrame iconSide:(float)aIconSide
{
    UIView *view = [[UIView alloc] initWithFrame:aFrame];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderColor = [UIColor grayColor].CGColor;
    view.layer.borderWidth = 0.2;
    
    UIImage *loadingImage = [[UIImage imageNamed:@"loading_icon.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((aFrame.size.width - aIconSide) / 2, (aFrame.size.height - aIconSide) / 2, aIconSide, aIconSide)];
    imageView.image = loadingImage;
    [view addSubview:imageView];
    
    return [SXPublicTool imageFromView:view];
}

//获得屏幕图像
+ (UIImage *)imageFromView: (UIView *) theView
{
    
    //   UIGraphicsBeginImageContext(theView.frame.size);
    UIGraphicsBeginImageContextWithOptions(theView.frame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

#pragma mark - tip
+ (void)showAlertControllerWithTitle:(NSString *)title
                            meassage:(NSString *)message
                         cancelTitle:(NSString *)cancelTitle
                       cancelHandler:(void (^)(UIAlertAction * _Nullable))cancelHandler
                        confirmTitle:(NSString *)confirmTitle
                      confirmHandler:(void (^)(UIAlertAction * _Nullable))confirmHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle || cancelHandler) {
        //cancel
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:cancelHandler];
        [alert addAction:cancelAction];
    }
    
    if (confirmHandler || confirmHandler) {
        //confirm
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
        [alert addAction:confirmAction];
    }
    
    
    //present
    UIWindow *window = [SXPublicTool keyWindow];
    [window.rootViewController presentViewController:alert animated:YES completion:nil];
}

#pragma mark - NSNotificationCenter
/**
 *  NSNotificationCenter
 */
+ (void)addKeyboardWillShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardWillShowNotification object:anObject];
}

+ (void)addKeyboardDidShowNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject
{
    
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardDidShowNotification object:anObject];
    
}

+ (void)addKeyboardWillHideNotificationObserver:(id)observer selector:(SEL)aSelector object:(nullable id)anObject{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:aSelector name:UIKeyboardWillHideNotification object:anObject];
    
}

+ (void)removeKeyboardWillShowNotificationObserver:(id)observer object:(id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

}

+ (void)removeKeyboardDidShowNotificationObserver:(id)observer object:(nullable id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];

}

+ (void)removeKeyboardWillHideNotificationObserver:(id)observer object:(nullable id)anObject
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
