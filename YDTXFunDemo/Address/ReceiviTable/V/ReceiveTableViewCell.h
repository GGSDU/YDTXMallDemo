//
//  ReceiveTableViewCell.h
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressListModel;

@class ReceiveTableViewCell;


@protocol  ReceiveTableViewCellDelegate<NSObject>


/* params:
 *  editImg :编辑按钮
 *  addressID:地址id
 *  status: 是否为默认地址  0为false 1为ture
 */
- (void)didClickedEdit:(UIImageView *) editImg addressID:(NSString *)addID status:(NSString *)status;

@end


@interface ReceiveTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier addressModel:(AddressListModel *)addressModel;




// judge the cell selected status
@property (nonatomic, assign) BOOL cellStatus;


@property (nonatomic, assign) id<ReceiveTableViewCellDelegate>delegate;

/*params:
 *  enter: 入口 false is market，ture is myCenter
 *  compile: 是否为编辑状态 false：非编辑状态，ture：编辑状态
 *  selected: 是否为选中状态 false：未选中状态， ture：选中状态
 **/
- (void)setStatus:(BOOL)enter compile:(BOOL)compile select:(BOOL) selected;



@end
