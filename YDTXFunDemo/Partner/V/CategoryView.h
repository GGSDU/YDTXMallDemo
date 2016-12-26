//
//  CategoryView.h
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CategoryViewDelegate <NSObject>

-(void)updateWebViewInfoWithHtmlString:(NSString *)htmlString;

@end

@interface CategoryView : UIView

@property(weak,nonatomic) id<CategoryViewDelegate> delegate;

-(void)setUIWithDataArr:(NSArray *)DataArr;

@end
