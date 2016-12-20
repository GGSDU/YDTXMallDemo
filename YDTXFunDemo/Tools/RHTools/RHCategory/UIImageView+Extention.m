//
//  UIImageView+Extention.m
//  ZZBS
//
//  Created by 👄 on 15/12/31.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "UIImageView+Extention.h"
#import "SDReachability.h"
#import "UIImage+Extension.h"


#import "UIImageView+WebCache.h"

@implementation UIImageView (Extention)

-(void)setHeader:(NSString *)urlStr
{
    
    // 原型的站位图
    UIImage *placeHolderImage = [[UIImage imageNamed:@"zwt"] circleImage];
    
    
    [self jw_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:placeHolderImage completed:^(UIImage *image, NSError *error) {
        // 如果image有值 就变圆  没有值 显示站位
        self.image = image ? [image circleImage] : placeHolderImage;
    }];
    
    
}


-(void)jw_setImageWithURL:(NSURL *)url
{
    if ([self currentImageDownLoadMode] == NO || url == nil) {
        
        // 设置自己的图片为 站位图片
        self.image = [UIImage imageNamed:@"allplaceholderImage"];
        
        return;
    }
    
    // 正常下载
    [self sd_setImageWithURL:url];
    
}

-(void)jw_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void (^)(UIImage *image, NSError *error))complete
{
    if ([self currentImageDownLoadMode] == NO || url == nil) {
        
        // 设置自己的图片为 站位图片
        self.image = [UIImage imageNamed:@"allplaceholderImage"];
        
        // 500 服务器错误
        NSError *error = [NSError errorWithDomain:@"example.com" code:500 userInfo:nil];
        // 回调 并 返回
        complete(placeholder,error);
        return;
    }
    
    [self sd_setImageWithURL:url placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        complete(image,error);
    }];
}

// 有进度的下载图片  比如下载大的GIF图 需要展示进度条
- (void)jw_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(NSInteger)options progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock completed:(void (^)(UIImage *image, NSError *error))complete
{
    if ([self currentImageDownLoadMode] == NO || url == nil) {
        
        // 每一个block都要调用
        
        
        // 设置自己的图片为 站位图片
        self.image = [UIImage imageNamed:@"allplaceholderImage"];
        
        
        NSError *error = [NSError errorWithDomain:@"example.com" code:500 userInfo:nil];
        
        progressBlock(100, 100);
        
        complete(self.image,error);
        
        return;
    }
    
    
    // 正常下载
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        progressBlock(receivedSize, expectedSize);
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        complete(image,error);
    }];
}


// 展示没用 以后可能用的上 干脆一起封装了
-(void)jw_setImageAfterClickWithURL:(NSURL *)url
{
    
    [self sd_setImageWithURL:url];
    
}


// 根据是否是智能无图 得到当前下载模式是下载还是不下载
- (BOOL)currentImageDownLoadMode {
    
    BOOL isDownLoadNoImageIn3G = YES;
    
    if (isDownLoadNoImageIn3G == YES && [SDReachability currentNetworkingType] == NetworkingTypeWiFi) {
        //在设置中选择了智能无图，并且当前网络非Wifi
        return NO;
    }
    
    return YES;
}
@end
