//
//  PartnerViewController.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "PartnerViewController.h"

@interface PartnerViewController ()

@property (strong ,nonatomic) UIScrollView *topScrollerView;

@end

@implementation PartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self setBasic];
}


-(void)setUI{

//头部的Scrollerview
    _topScrollerView = [[UIScrollView alloc]init];
    _topScrollerView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_topScrollerView];
    [_topScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];


    
    


}


-(void)setBasic{
    self.title = @"合伙人";
    self.view.backgroundColor = [UIColor yellowColor];
    self.view.y = 64;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
