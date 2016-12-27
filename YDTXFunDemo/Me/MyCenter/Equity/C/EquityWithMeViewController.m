//
//  EquityWithMeViewController.m
//  YDTX
//
//  Created by 舒通 on 2016/12/21.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "EquityWithMeViewController.h"

#import "AddActionMessageTableViewController.h"
#import "AddSpotMessageViewController.h"

@interface EquityWithMeViewController ()
@property (strong, nonatomic) AFHTTPSessionManager *AFManager;

@property (strong, nonatomic) UIView *floatBottomView;

@end

@implementation EquityWithMeViewController

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}

- (UIView *)floatBottomView {
    if (!_floatBottomView) {
        _floatBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        _floatBottomView.tag = 100;
        _floatBottomView.backgroundColor = [UIColor whiteColor];
        
        
    }
    
    return _floatBottomView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.floatBottomView];
//
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    [self.floatBottomView removeFromSuperview];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:100] removeFromSuperview];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[[UIApplication sharedApplication].keyWindow viewWithTag:100] removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"权益介绍";
    
    [self creatWebView];
    [self creatFloatButton];
    
}

- (void)creatWebView {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-49)];
//    webView.scalesPageToFit = YES;//对页面进行缩放 适应屏幕
//    webView.detectsPhoneNumbers = YES;//检测电话拨打
    
    [self.view addSubview:webView];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = @1;
    
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/partner/partner_right"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        
        
        if ([responseObject[@"status"] isEqual:@200]) {
            [webView loadHTMLString:responseObject[@"data"][@"right"] baseURL:nil];
        } else {
             [SVProgressHUD showErrorWithStatus:@"哎呀，出错了"];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"哎呀，出错了"];
    }];
  
    
//
    
}


- (void)creatFloatButton {
    
    NSArray *array = @[@"推荐活动",@"推荐塘口"];
    NSArray *colorArr = @[RGB(245, 148, 2),RGB(255, 97, 0)];
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenWidth/2*i, 0, ScreenWidth/2, 49);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        
        [button setBackgroundColor:colorArr[i]];
        button.tag = 10+i;
        
        [self.floatBottomView addSubview:button];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


- (void)buttonAction:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text );
    if (sender.tag == 10) {
        AddActionMessageTableViewController *addActionVC = [[AddActionMessageTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:addActionVC animated:YES];
    } else if (sender.tag == 11) {
        AddSpotMessageViewController *spotVC = [[AddSpotMessageViewController alloc]initWithStyle:UITableViewStyleGrouped];
        [self.navigationController pushViewController:spotVC animated:YES];
    }
    
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
