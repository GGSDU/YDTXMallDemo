//
//  OrderDrawBackViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "OrderDrawBackViewController.h"
#import "OrderDrawBackView.h"

#import "UIViewController+DownMenu.h"

@interface OrderDrawBackViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *button;


@property (nonatomic, assign) NSInteger curIndex;
@end

@implementation OrderDrawBackViewController

- (UIView *)drawBackStatusBackGroundView {
    if (!_drawBackStatusBackGroundView) {
        _drawBackStatusBackGroundView = [[UIView alloc]init];
        _drawBackStatusBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_drawBackStatusBackGroundView];
        
        [_drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(18*HeightScale);
            make.left.mas_equalTo(self.view.mas_left).offset(10*WidthScale);
            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    return _drawBackStatusBackGroundView;
}


- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:15*HeightScale];
        [self.view addSubview:_textView];
        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_bottom).offset(20*HeightScale);
            make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left);
            make.width.mas_equalTo(self.drawBackStatusBackGroundView.mas_width);
            make.height.mas_equalTo(40*HeightScale);
        }];
    }
    
    return _textView;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"] forState:UIControlStateNormal];
        [self.view addSubview:_button];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.textView.mas_left);
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.top.mas_equalTo(self.textView.mas_bottom).offset(20*HeightScale);
        }];
        
    }
    return _button;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor lightGrayColor];

    
//    [self creatView];
//    
//    
//    _curIndex = 0;
//    [self customDownMenuWithTitles:@[[DownMenuTitle title:@"冒泡广场" image:@"nav_tweet_all" badge:nil],
//                                     [DownMenuTitle title:@"好友圈" image:@"nav_tweet_friend" badge:nil],
//                                     [DownMenuTitle title:@"热门冒泡" image:@"nav_tweet_hot" badge:nil],
//                                     [DownMenuTitle title:@"我的冒泡" image:@"nav_tweet_mine" badge:nil]]
//                   andDefaultIndex:_curIndex
//                          andBlock:^(id titleObj, NSInteger index) {
//                              [(DownMenuTitle *)titleObj setBadgeValue:nil];
//                              _curIndex = index;
//                              [self refreshFirst];
//                          }];

    
}

-(void)refreshFirst
{
    NSLog(@"%ld",_curIndex);
}
- (void) creatView {

    
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.textView.mas_left);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20*HeightScale);
    }];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200*HeightScale);
    }];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        
    } else {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40*HeightScale);
        }];

    }
    
    
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
