//
//  SGLocationPickerView.h
//  LocationPicker(地区选择)
//
//  Created by Hanymore on 16/6/28.
//  Copyright © 2016年 Sorgle. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^MyBlock)(NSString *);

@interface SGLocationPickerView : UIView

@property (nonatomic, copy)void(^MyBlock)(NSString *prov,NSString *city,NSString *area);
/** 用于传值 */
//@property (copy, nonatomic) MyBlock locationMessage;

@end
