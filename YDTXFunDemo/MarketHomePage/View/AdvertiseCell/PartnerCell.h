//
//  AdvertiseCell.h
//  IkasaInteriorIphone
//
//  Created by webcity on 16/2/24.
//  Copyright © 2016年 Webcity. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PartnerCell;

@protocol PartnerCellDelegate <NSObject>

- (void)advertiseCell:(PartnerCell *)advertiseCell didSelectedAtIndex:(NSInteger)index;

@end

@interface PartnerCell : UITableViewCell

@property (nonatomic, assign) id<PartnerCellDelegate>delegate;
@property (nonatomic, strong) NSArray *advertiseArray;

- (void)createAutoScrollerView;

@end
