//
//  MeHeadImageViewTableViewCell.h
//  YDTX
//
//  Created by 舒通 on 16/10/11.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MeHeadImageViewTableViewCell;

@protocol MeHeadImageViewTableViewCellDelegate <NSObject>

- (void) didClickHeadImageView:(MeHeadImageViewTableViewCell *)view tag:(NSInteger) tag ;

@end


@interface MeHeadImageViewTableViewCell : UITableViewCell

//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier frame:(CGRect *)frame;

//@property (nonatomic, strong) UIImageView *imageV;


@property (assign, nonatomic) BOOL isLogin;//登录状态
@property (copy, nonatomic) NSString *headerURL;//头像地址
@property (copy, nonatomic) NSString *nameString;//用户昵称
@property (copy, nonatomic) NSString *sexString;//性别字符串
@property (copy, nonatomic) NSString *userIdentify;//用户身份


@property (assign, nonatomic) id<MeHeadImageViewTableViewCellDelegate>delegate;


- (void) setHeadContentStatus:(BOOL)isLogin headerURL:(NSString *)headerURL nameString:(NSString *)nameString sexString:(NSString *)sex userIdentity:(NSString *)identify;


@end
