//
//  ProductBriefCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ProductBriefCell.h"
#import "DisplayView.h"

@interface ProductBriefCell ()

@property (nonatomic,strong) DisplayView *displayView;

@end

@implementation ProductBriefCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createUI];
    }
    return self;
}

#pragma mark - create UI
- (void)createUI{
    if (_displayView == nil) {
        _displayView = [[DisplayView alloc] init];
        [self addSubview:_displayView];
    }
    
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)updateViewWithProductModel:(ProductModel *)productModel
{
    DisplayModel *displayModel = [[DisplayModel alloc] init];
    displayModel.imageURL = productModel.infoImageURL;
    displayModel.infoString = productModel.infoName;
    displayModel.price = productModel.price;
    displayModel.vipPrice = productModel.vipPrice;
    displayModel.saleNumber = productModel.saleNumber;
    
    _displayView.displayModel = displayModel;
}

@end
