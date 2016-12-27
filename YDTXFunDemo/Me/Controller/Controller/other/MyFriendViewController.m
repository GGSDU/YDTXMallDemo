//
//  MyFriendViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyFriendViewController.h"

@interface MyFriendViewController ()

@end

@implementation MyFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"邀请好友";
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatBackGroundView];
}

- (void)creatBackGroundView {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20*WidthScale, 0, ScreenWidth-40*WidthScale, ScreenHeight/2)];
    imageView.image = [UIImage imageNamed:@"friend"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/2, ScreenWidth, 40)];
    label1.text = @"我们的程序员正在挑灯夜战努力建设中......";
    label1.font = [UIFont systemFontOfSize:13*HeightScale];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, ScreenHeight/2+CGRectGetMaxY(label1.bounds)+30, ScreenWidth, 50)];
    label2.text = @"敬请期待！";
    label2.textColor = [UIColor colorWithRed:0.992 green:0.569 blue:0.184 alpha:1.000];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.font = [UIFont systemFontOfSize:18*HeightScale];
    [self.view addSubview:label2];
    
    
    
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
