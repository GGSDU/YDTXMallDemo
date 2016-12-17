//
//  BannerCell.h
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BannerCell;

@protocol BannerCellDelegate <NSObject>

- (void)bannerCell:(BannerCell *)bannerCell didSelectedAtIndex:(NSInteger)index;


@end

@interface BannerCell : UICollectionViewCell

@property (nonatomic,assign) id<BannerCellDelegate>delegate;

@property (nonatomic,strong) NSArray *bannerArray;

- (void)createAutoScrollerView;

@end
