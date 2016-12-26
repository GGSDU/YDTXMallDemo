//
//  PartnerViewController.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "PartnerViewController.h"
#import "CategoryView.h"
#import "CategoryWebView.h"
@interface PartnerViewController ()<CategoryViewDelegate>

@property (strong ,nonatomic) UIScrollView *topScrollerView;

@property (strong,nonatomic)CategoryView *categoryView;
@property (strong,nonatomic)CategoryWebView *categoryWebView;

@end

@implementation PartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setUI];
    [self setBasic];
}


-(void)setUI{

//头部的Scrollerview
    _topScrollerView = [[UIScrollView alloc]init];
    _topScrollerView.backgroundColor = [UIColor whiteColor];
    _topScrollerView.layer.borderWidth = 1;
    _topScrollerView.layer.borderColor = RGB(239, 239, 239).CGColor;
    [self.view addSubview:_topScrollerView];
    [_topScrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        
    }];
    

//探长合伙人btn
   UIButton *DetectiveBtn = [[UIButton alloc]init];
    [DetectiveBtn setTitle:@"探长合伙人" forState:UIControlStateNormal];
    [DetectiveBtn setTitleColor:RGB(254, 148, 2) forState:UIControlStateNormal];
    DetectiveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_topScrollerView addSubview:DetectiveBtn];
    [DetectiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topScrollerView);
        make.centerY.equalTo(_topScrollerView);
    }];
    
  
//categoryView
    _categoryView = [[CategoryView alloc]init];
    _categoryView.backgroundColor = [UIColor redColor];
    _categoryWebView.delegate = self;
    [self.view addSubview:_categoryView];
    [_categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topScrollerView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    
    NSArray *temArr = @[@"初级",@"高级",@"荣誉"];
    [_categoryView setUIWithDataArr:temArr];
    
    
//价格titleLabel
    UILabel *priceTitle = [[UILabel alloc]init];
    priceTitle.backgroundColor = RGB(238, 238, 238);
    priceTitle.text  = @"  价格";
    priceTitle.textColor = RGB(131, 131, 131);
    priceTitle.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:priceTitle];
    [priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_categoryView.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
    
    
//价格label

    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.backgroundColor = [UIColor whiteColor];
    priceLabel.textColor = RGB(255, 148, 3);
    priceLabel.text = @"  ￥x.xx";
    priceLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceTitle.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
//详细介绍title
    
    UILabel *DetailInfoTitle = [[UILabel alloc]init];
    DetailInfoTitle.backgroundColor = RGB(238, 238, 238);
    DetailInfoTitle.text  = @"  详细介绍";
    DetailInfoTitle.textColor = RGB(131, 131, 131);
    DetailInfoTitle.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:DetailInfoTitle];
    [DetailInfoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(35);
    }];
    
//webview
    _categoryWebView = [[CategoryWebView alloc]init];
    _categoryWebView.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:_categoryWebView];
    [_categoryWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(DetailInfoTitle.mas_bottom);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];

    
    
}


-(void)setBasic{
    self.title = @"合伙人";
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.y = 64;

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark--CategoryDelegateMethod
-(void)updateWebViewInfoWithHtmlString:(NSString *)htmlString{

    NSString *correctStr = [htmlString stringByReplacingOccurrencesOfString:@"src=\"" withString:@"src=\"http://m.yundiaoke.cn"];
    [_categoryWebView loadHTMLString:correctStr baseURL:nil];

}

@end
