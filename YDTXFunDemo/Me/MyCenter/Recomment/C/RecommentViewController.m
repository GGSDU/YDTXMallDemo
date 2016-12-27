//
//  RecommentViewController.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentViewController.h"

#import "RecommentSpotTableViewController.h"
#import "RecommentActionTableViewController.h"

@interface RecommentViewController ()<UIScrollViewDelegate>
{
    NSArray *typeArray;
}
@property (nonatomic, strong) UIView *bottomLine;//下划线
@property (nonatomic, strong) UIButton *button;//选中的btn


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *buttonBackGroundView;

@end



@implementation RecommentViewController

- (UIView *)buttonBackGroundView {
    if (!_buttonBackGroundView) {
        _buttonBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*HeightScale)];
        _buttonBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_buttonBackGroundView];
    }
    return _buttonBackGroundView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.buttonBackGroundView.bounds), ScreenWidth, ScreenHeight-40*HeightScale)];
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(typeArray.count*ScreenWidth, 0);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的推荐";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    typeArray = @[@"活动",@"塘口"];

    
    [self addChildrenVC];
    [self creatButtn];
    
    
    // Do any additional setup after loading the view.
}


- (void) addChildrenVC {
    RecommentActionTableViewController *actionVC = [[RecommentActionTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:actionVC];
    
    RecommentSpotTableViewController *spotVC = [[RecommentSpotTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    [self addChildViewController:spotVC];
    
}

- (void) creatButtn {
    CGFloat buttonWidth = ScreenWidth/typeArray.count;
    
    for (int i = 0; i < typeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 10+i;
        
        [button setTitle:typeArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        
        [button sizeToFit];
        button.frame = CGRectMake(buttonWidth*i, 0, buttonWidth, self.buttonBackGroundView.size.height-2);
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.buttonBackGroundView addSubview:button];
 
    }
    
    
    UIButton *btn = self.buttonBackGroundView.subviews[0];
    
    
//    下划线
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(btn.titleLabel.frame), self.buttonBackGroundView.height - 2, btn.titleLabel.size.width, 2)];
    bottomLine.backgroundColor = [UIColor orangeColor];
    [self.buttonBackGroundView addSubview:bottomLine];
    
    self.bottomLine = bottomLine;
    
    
    //    默认选中第一个
    [self buttonAction:btn];
 
}

- (void) buttonAction:(UIButton *)sender {
    
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    
    NSInteger index = sender.tag -10;
    //    下划线的位置
    [UIView animateWithDuration:0.2 animations:^{
        if (sender.titleLabel.width<=0) {
            sender.titleLabel.width = 37;
        }
        self.bottomLine.width = sender.titleLabel.width;
        self.bottomLine.centerX = sender.centerX;
        
    }];

    
    
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth*index, 0) animated:YES];
    
    //    取出VC
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(ScreenWidth*index, 0, ScreenWidth, ScreenHeight-64-40*HeightScale);
    [self.scrollView addSubview:vc.view];

}


#pragma mark 滚动
//拖拽减速结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    
    //    点击按钮
    [self buttonAction:self.buttonBackGroundView.subviews[index]];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
