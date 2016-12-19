//
//  ViewController.m
//  OrderForGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_GoodsViewController.h"

#import "Order_DoneTableViewController.h"
#import "Order_ObligationTableViewController.h"
#import "Order_ReceiveryTableViewController.h"
#import "Order_DrawBackTableViewController.h"


@interface Order_GoodsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;//类型底部视图
@property (nonatomic, strong) NSArray *typeArray;//类型名数组
@property (nonatomic, strong) UIView *bottomLine;//下划线
@property (nonatomic, strong) UIButton *button;//选中的btn
@property (nonatomic, strong) UIScrollView *scroller;//底部滚动视图


@end

@implementation Order_GoodsViewController

#pragma mark  lazy
- (UIScrollView *)scroller {
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 96*HeightScale, ScreenWidth, ScreenHeight-96*HeightScale)];
        _scroller.pagingEnabled = YES;
        
        _scroller.delegate = self;
        _scroller.contentSize = CGSizeMake(self.typeArray.count*ScreenWidth, 0);
        [self.view addSubview:_scroller];
        
    }
    return _scroller;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"订单";
    
    self.tabBarController.tabBar.hidden = YES;
    self.typeArray = @[@"已完成",@"待付款",@"待收货",@"退款"];
    
    [self addChildrenVC];
    
    [self creatTypeBtnView];
    
}

#pragma mark 添加子控制器
- (void)addChildrenVC {
    Order_DoneTableViewController *doneVC = [[Order_DoneTableViewController alloc]init];
    [self addChildViewController:doneVC];
    
    Order_ObligationTableViewController *obligationVC = [[Order_ObligationTableViewController alloc]init];
    [self addChildViewController:obligationVC];
    
    Order_ReceiveryTableViewController *receiveryVC = [[Order_ReceiveryTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:receiveryVC];
    
    Order_DrawBackTableViewController *drawBackVC = [[Order_DrawBackTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:drawBackVC];
    
    
}

#pragma  mark 添加类型视图
- (void) creatTypeBtnView {
    self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 96*HeightScale)];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backGroundView];
    
    
    NSArray *notSelect = @[@"已完成未选中",@"待付款未选中",@"待收货未选中",@"退款未选中"];
    
    
    CGFloat width = ScreenWidth/self.typeArray.count;
    
    for (int i = 0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(width*i, 0, width, self.backGroundView.frame.size.height);
        button.tag = 10+i;
        button.selected = NO;
        button.titleLabel.font = [UIFont systemFontOfSize:12*HeightScale];
        
        //        标题
        //        [button setTitle:notSelect[i] forState:UIControlStateNormal];
        
        [button setTitle:self.typeArray[i] forState:UIControlStateNormal];
        
        //        字体颜色
        [button setTitleColor:[UIColor colorWithDisplayP3Red:95.0 / 255.0 green:95.0 / 255.0 blue:95.0 / 255.0 alpha:1] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithDisplayP3Red:255.0 / 255.0 green:146.0 / 255.0 blue:2.0 / 255 alpha:1] forState:UIControlStateDisabled];
        
        
        
        //        图片
        [button  setImage:[UIImage imageNamed:notSelect[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:self.typeArray[i]] forState:UIControlStateDisabled];
        
        
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //    / button标题的偏移量
        button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+5, -button.imageView.bounds.size.width, 0,0);
        //    // button图片的偏移量
        button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width/2,button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
        
        
        [self.backGroundView addSubview:button];
    }
    
    
    UIButton *btn = self.backGroundView.subviews[0];
    
    
    
    //    默认选中第一个
    [self buttonAction:btn];
    
    
    
}


#pragma mark 类型btn的响应式件
- (void) buttonAction:(UIButton *) sender {
    
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    
    NSInteger index = sender.tag -10;
    
    
    [self.scroller setContentOffset:CGPointMake(ScreenWidth*index, 0) animated:YES];
    //    取出VC
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-96*HeightScale);
    [self.scroller addSubview:vc.view];
    
}



#pragma mark 滚动
//拖拽减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    
    //    点击按钮
    [self buttonAction:self.backGroundView.subviews[index]];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-96*HeightScale);
    [scrollView addSubview:vc.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
