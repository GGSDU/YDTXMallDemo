//
//  AdvertiseCell.h
//  IkasaInteriorIphone
//
//  Created by webcity on 16/2/24.
//  Copyright © 2016年 Webcity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdvertiseCell;

@protocol AdvertiseCellDelegate <NSObject>

- (void)advertiseCell:(AdvertiseCell *)advertiseCell didSelectedAtIndex:(NSInteger)index;

@end

@interface AdvertiseCell : UITableViewCell

@property (nonatomic, assign) id<AdvertiseCellDelegate>delegate;
@property (nonatomic, strong) NSArray *advertiseArray;

- (void)createAutoScrollerView;

@end
