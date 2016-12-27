//
//  MeNameViewController.h
//  YDTX
//
//  Created by 舒通 on 16/9/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeNameViewController : UIViewController

@property (copy, nonatomic) void (^finishInputMsgBlock)(NSString *msg);
- (void)creatTextFile;
- (void)creatTextView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UILabel *placeLabel;

@end
