//
//  OrderSubmitViewController.m
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "OrderSubmitViewController.h"

@interface OrderSubmitViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIButton *button;


@end

@implementation OrderSubmitViewController

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.image = [UIImage imageNamed:@"成功"];
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).offset(122*HeightScale);
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(60*WidthScale, 60*WidthScale));
        }];
    }
    return _imageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [UILabel new];
        _statusLabel.text = @"提交审核成功！";
        _statusLabel.font = [UIFont systemFontOfSize:20*HeightScale];
        [_statusLabel sizeToFit];
        [self.view addSubview:_statusLabel];
        
        [_statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(28*HeightScale);
            make.centerX.mas_equalTo(self.imageView.mas_centerX);
            
        }];
    }
    return _statusLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        [_messageLabel sizeToFit];
        _messageLabel.textColor = RGB(132, 132, 132);
        _messageLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        _messageLabel.text = @"恭喜您，您的资料审核已提交成功。我们会尽快审核，届时将以短信方式通知您，谢谢您的参与。";
        _messageLabel.numberOfLines = 0;
        [self.view addSubview:_messageLabel];
     [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(self.statusLabel.mas_bottom).offset(20*HeightScale);
         make.left.mas_equalTo(self.view.mas_left).offset(30*WidthScale);
         make.width.mas_equalTo(ScreenWidth-60*WidthScale);
     }];
    }
    return _messageLabel;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"返回首页" forState:UIControlStateNormal];
        _button.layer.borderColor = RGB(119, 187, 250).CGColor;
        _button.layer.borderWidth = 1;
        [_button setTitleColor:RGB(77, 175, 248) forState:UIControlStateNormal];
        _button.layer.cornerRadius = 5;
        _button.layer.masksToBounds = YES;
        [self.view addSubview:_button];
        
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(40*HeightScale);
            make.left.mas_equalTo(self.view.mas_left).offset(30*WidthScale);
            make.size.mas_equalTo(CGSizeMake(ScreenWidth-60*WidthScale, 50));
        }];
    }
    return _button;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提交成功";
    
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.hidesBackButton = YES;
    
    // Do any additional setup after loading the view.
}

- (void)buttonAction:(UIButton *)sender {
    
    NSLog(@"+++++++%@",self.navigationController.viewControllers);
    UIViewController *controller = self.navigationController.viewControllers[0];
    [self.navigationController popToViewController:controller animated:YES];
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
