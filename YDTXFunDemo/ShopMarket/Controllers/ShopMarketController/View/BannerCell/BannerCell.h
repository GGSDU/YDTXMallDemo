//
//  BannerCell.h
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - BannerModel
@interface BannerModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSString *images_url;

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
- (id)valueForUndefinedKey:(NSString *)key;

@end

#pragma mark - BannerCellDelegate
@class BannerCell;

@protocol BannerCellDelegate <NSObject>

- (void)bannerCell:(BannerCell *)bannerCell didSelectedAtIndex:(NSInteger)index;


@end

#pragma mark - BannerCell
@interface BannerCell : UICollectionViewCell

@property (nonatomic,assign) id<BannerCellDelegate>delegate;

@property (nonatomic,strong) NSArray *bannerArray;

- (void)createAutoScrollerView;

@end
