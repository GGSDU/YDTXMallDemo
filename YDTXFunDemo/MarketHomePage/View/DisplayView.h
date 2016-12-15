//
//  ProductDisplayView.h
//  YDTXFunDemo
//
//  Created by Story5 on 15/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - model
@interface DisplayModel : NSObject

@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic,strong) NSString *infoString;
@property (nonatomic,assign) float price;
@property (nonatomic,assign) float vipPrice;
@property (nonatomic,assign) int saleNumber;

@end

#pragma mark - view
@interface DisplayView : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *infoLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *vipPriceLabel;
@property (nonatomic,strong) UILabel *saleLabel;

@property (nonatomic,strong) DisplayModel *displayModel;

@end
