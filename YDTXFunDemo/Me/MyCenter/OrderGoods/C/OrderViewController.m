//
//  ViewController.m
//  OrderForGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "OrderViewController.h"
#import "Order_ActionViewController.h"
#import "Order_GoodsViewController.h"


@interface OrderViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;//类型底部视图
@property (nonatomic, strong) NSArray *typeArray;//类型名数组
@property (nonatomic, strong) UIView *bottomLine;//下划线
@property (nonatomic, strong) UIButton *button;//选中的btn
@property (nonatomic, strong) UIScrollView *scroller;//底部滚动视图


@end

@implementation OrderViewController

#pragma mark  lazy
- (UIScrollView *)scroller {
    if (!_scroller) {
        _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40*HeightScale, ScreenWidth, ScreenHeight-40*HeightScale)];
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
    self.typeArray = @[@"活动",@"商品"];
    
    [self addChildrenVC];
    
    [self addViewsOnSC];
    
    [self creatTypeBtnView];
    
}

#pragma mark 添加子控制器
- (void)addChildrenVC {
    Order_ActionViewController *actionVC = [[Order_ActionViewController alloc]init];
    [self addChildViewController:actionVC];
    
    Order_GoodsViewController *goodsVC = [[Order_GoodsViewController alloc]init];
    [self addChildViewController:goodsVC];
    
}


#pragma mark 把试图添加到控制器上
- (void)addViewsOnSC
{
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(ScreenWidth*i, 0, ScreenWidth, ScreenHeight-64-40*HeightScale);
        [self.scroller addSubview:vc.view];
    }
}

#pragma  mark 添加类型视图
- (void) creatTypeBtnView {
    self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*HeightScale)];
    self.backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backGroundView];
    
    
    
    
    
    //    创建btn
    CGFloat btnWidth = ScreenWidth/self.typeArray.count;
    
    for (int i = 0; i < self.typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10+i;
        [button setTitle:self.typeArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [button sizeToFit];
        
        button.frame = CGRectMake(i*btnWidth, 0, btnWidth, self.backGroundView.frame.size.height-0.8);
        
        [self.backGroundView addSubview:button];
    }
    
    
    UIButton *btn = self.backGroundView.subviews[0];
    [btn setTitle:self.typeArray[0] forState:UIControlStateNormal];
    
    //    下划线
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor orangeColor];
    
    
    bottomLine.height = 2;
    bottomLine.y = self.backGroundView.height - bottomLine.height-0.8;
    bottomLine.centerX = btn.centerX;
    bottomLine.width = btn.titleLabel.width;
    
    [self.backGroundView addSubview:bottomLine];
    NSLog(@"bottomLine.frame is :%0.2f--%0.2f--%0.2f--%0.2f--%@--%@--%@",bottomLine.width,bottomLine.height,bottomLine.y,bottomLine.centerX,bottomLine.backgroundColor,bottomLine.superview,btn);
    
    self.bottomLine = bottomLine;
    
    
    //    默认选中第一个
    [self buttonAction:btn];
    
    
    
    UIView *backGroundLinView = [[UIView alloc]initWithFrame:CGRectMake(0, self.backGroundView.frame.size.height-0.8, ScreenWidth, 0.8)];
    backGroundLinView.backgroundColor = [UIColor colorWithDisplayP3Red:239.0 / 255.0 green:239.0 / 255.0 blue:239.0 / 255.0 alpha:1];
    [self.backGroundView addSubview:backGroundLinView];
    
    
}


#pragma mark 类型btn的响应式件
- (void) buttonAction:(UIButton *) sender {
    
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    
    NSInteger index = sender.tag -10;
    //    下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.titleLabel.width<=0) {
            self.bottomLine.width = 37*WidthScale;
        } else {
            
            self.bottomLine.width = sender.titleLabel.width;
        }
        self.bottomLine.centerX = sender.centerX;
        
        
    }];
    
    
    
    [self.scroller setContentOffset:CGPointMake(ScreenWidth*index, 0) animated:YES];
    
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
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-40*HeightScale);
    [scrollView addSubview:vc.view];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
