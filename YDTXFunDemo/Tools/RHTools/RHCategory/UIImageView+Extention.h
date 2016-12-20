//
//  UIImageView+Extention.h
//  ZZBS
//
//  Created by 👄 on 15/12/31.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extention)

-(void)setHeader:(NSString *)urlStr;

// 处理智能无图
-(void)jw_setImageWithURL:(NSURL *)url;


-(void)jw_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(void (^)(UIImage *image, NSError *error))complete;



- (void)jw_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(NSInteger)options progress:(void (^)(NSInteger receivedSize, NSInteger expectedSize))progressBlock completed:(void (^)(UIImage *image, NSError *error))complete;


- (void)jw_setImageAfterClickWithURL:(NSURL *)url;



@end
