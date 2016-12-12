//
//  ProductModel.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (void)dealloc
{
    if (_infoImageURL) {
        [_infoImageURL release];
        _infoImageURL = nil;
    }
    
    if (_infoName) {
        [_infoName release];
        _infoName = nil;
    }
    
    if (_modelType) {
        [_modelType release];
        _modelType = nil;
    }
    
    [super dealloc];
}


@end
