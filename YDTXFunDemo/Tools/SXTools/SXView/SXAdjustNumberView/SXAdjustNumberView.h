//
//  SXAdjustNumberView.h
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpdateNumberBlock)(int number);
typedef void (^QuantityLowBlock)();

@interface SXAdjustNumberView : UIView

@property (nonatomic,assign) NSInteger minValue;
@property (nonatomic,assign) NSInteger maxValue;

@property (nonatomic,assign) int number;
@property (nonatomic,copy) UpdateNumberBlock updateNumberBlock;
@property (nonatomic,copy) QuantityLowBlock quantityLowBlock;

@end
