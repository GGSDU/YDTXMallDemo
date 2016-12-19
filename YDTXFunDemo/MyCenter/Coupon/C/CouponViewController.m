//
//  CouponViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/15.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "CouponViewController.h"

#import "Coupon_UnUsedTableViewController.h"
#import "Coupon_UsedTableViewController.h"
#import "Coupon_ExpiredTableViewController.h"

@interface CouponViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;//类型底部视图
@property (nonatomic, strong) NSArray *typeArray;//类型名数组
@property (nonatomic, strong) UIView *bottomLine;//下划线
@property (nonatomic, strong) UIButton *button;//选中的btn
@property (nonatomic, strong) UIScrollView *scroller;//底部滚动视图


@end

@implementation CouponViewController

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

- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*HeightScale)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_backGroundView];
    }
    return _backGroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.typeArray = @[@"未使用",@"已使用",@"已过期"];
    
    [self addChildrenVC];
    [self addTypeBtnView];
    
}

#pragma mark  添加子控制器
- (void) addChildrenVC {
    Coupon_UnUsedTableViewController *unused = [[Coupon_UnUsedTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:unused];
    
    Coupon_UsedTableViewController *used = [[Coupon_UsedTableViewController alloc]initWithStyle:UITableViewStyleGrouped ];
    [self addChildViewController:used];
    
    Coupon_ExpiredTableViewController *expired = [[Coupon_ExpiredTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:expired];
  
}

#pragma mark 添加类型视图
- (void) addTypeBtnView {

    
//    创建btn
    CGFloat btnWidth = ScreenWidth/self.typeArray.count;
    
    for (int i = 0; i < self.typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10+i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        [button setTitle:self.typeArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [button sizeToFit];
        

        button.frame = CGRectMake(i*btnWidth, 0, btnWidth, self.backGroundView.frame.size.height-0.8);
        
        [self.backGroundView addSubview:button];
    }

    
    // 下划线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor orangeColor];
    
    // frame
    
    bottomLine.height = 2;
    bottomLine.y = self.backGroundView.height - bottomLine.height;
    
    
    // 第一个btn
    UIButton *btn = self.backGroundView.subviews[0];
    
    
    bottomLine.width = btn.titleLabel.width;
    // 设置centerX 必须有尺寸 如果没有尺寸 centerX不准确
    bottomLine.centerX = btn.centerX;
    
    [self.backGroundView addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    
    
    
    // 默认选中第一个
    [self buttonAction:btn];

    

    
}

#pragma mark 类型btn的响应式件
- (void) buttonAction:(UIButton *) sender {
    
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    NSLog(@"sender title is %@",sender.titleLabel.text);
    NSInteger index = sender.tag -10;
    //    下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        
        self.bottomLine.width = sender.titleLabel.width;
        self.bottomLine.centerX = sender.centerX;
        NSLog(@"sender title label width is :%f=====%@",sender.titleLabel.width,sender.titleLabel.text);
        
    }];
    
    
    
    [self.scroller setContentOffset:CGPointMake(ScreenWidth*index, 0) animated:YES];
    
    //    取出VC
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-40*HeightScale);
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
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-40*HeightScale);
    [scrollView addSubview:vc.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
