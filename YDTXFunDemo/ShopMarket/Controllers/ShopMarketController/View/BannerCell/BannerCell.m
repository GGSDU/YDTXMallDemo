//
//  BannerCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "BannerCell.h"

#import "Banner.h"

#pragma mark - BannerModel
@implementation BannerModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (id)valueForUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        return self.ID;
    }
    return  nil;
}

@end

#pragma mark - BannerCell
@interface BannerCell ()<BannerDelegate>

@property (nonatomic,strong) Banner *banner;

@end

@implementation BannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (_banner == nil) {
            
            _banner = [[Banner alloc] initWithFrame:self.bounds];
            _banner.delegate = self;
            [self addSubview:_banner];
        }
        
    }
    return self;
}

#pragma mark - BannerDelegate
- (void)banner:(Banner *)banner didSelectedAtIndex:(NSInteger)index
{
    if (_delegate && [_delegate respondsToSelector:@selector(bannerCell:didSelectedAtIndex:)]) {
        [_delegate bannerCell:self didSelectedAtIndex:index];
    }
}

- (void)setBannerArray:(NSArray *)bannerArray
{
    NSMutableArray *imageBannerArray = [[NSMutableArray alloc] initWithCapacity:0];
    for (BannerModel *model in bannerArray) {
        [imageBannerArray addObject:[SXPublicTool getImageURLStringByURLString:model.images_url]];
    }
    _banner.bannerArray = imageBannerArray;
}

- (void)createAutoScrollerView
{
    [_banner createAutoScrollerView];
}

@end
