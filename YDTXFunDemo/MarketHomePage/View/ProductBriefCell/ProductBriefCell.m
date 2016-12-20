//
//  ProductBriefCell.m
//  YDTXFunDemo
//
//  Created by Story5 on 16/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ProductBriefCell.h"
#import "DisplayView.h"

@implementation ProductBriefModel

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
    return nil;
}

@end

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
//        _displayView.priceLabel.backgroundColor = [UIColor redColor];
//        _displayView.vipPriceLabel.backgroundColor = [UIColor greenColor];
//        _displayView.saleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_displayView];
    }
    
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)updateViewWithProductBriefModel:(ProductBriefModel *)productBriefModel
{
    DisplayModel *displayModel = [[DisplayModel alloc] init];
    displayModel.imageURL = [SXPublicTool getImageURLStringByURLString:productBriefModel.images_url];
    displayModel.infoString = productBriefModel.name;
    displayModel.price = productBriefModel.pay;
    displayModel.vipPrice = productBriefModel.price;
    displayModel.saleNumber = productBriefModel.total_num;
    
    _displayView.displayModel = displayModel;
}

@end
