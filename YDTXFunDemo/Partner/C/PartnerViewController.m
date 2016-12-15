//
//  PartnerViewController.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "PartnerViewController.h"
#import "PartnerContentViewController.h"
@interface PartnerViewController ()<UIScrollViewDelegate>
// scrollView
@property(weak, nonatomic) UIScrollView *contentView;

@property (strong, nonatomic) UIButton *selBtn;

@property (strong, nonatomic) UIView *bottomLine;

/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titleView;

@end

@implementation PartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合伙人";
    self.view.backgroundColor = [UIColor grayColor];
    
    
    [self setupChildVces];
    
    // scrollView
    [self setupScrollView];
    
    // 设置topicsView
    [self setupTitleView];
}

// topicsView
-(void)setupTitleView
{
    UIView *titleView = [[UIView alloc]init];
    
    
    
    titleView.backgroundColor = [UIColor yellowColor];
    
    titleView.y = 64;
    titleView.width = YDTXScreenW;
    titleView.height = 35;
    
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    // 创建btn
    
    NSArray *titles = @[@"塘口合伙人",@"活动合伙人",@"探长"];
    CGFloat btnWidth = YDTXScreenW / titles.count;
    for (int i = 0; i < titles.count; i++)
    {
        
        
        // 添加tags
        UIButton *tagBtn = [[UIButton alloc]init];
        
        
        // 点击btn时处理scrollView的偏移量
        tagBtn.tag = i;
        
        
        [tagBtn setTitle:titles[i] forState:UIControlStateNormal];
        
        [tagBtn setTitleColor:RGB(101, 101, 101) forState:UIControlStateNormal];
        [tagBtn setTitleColor:RGB(254, 148, 2) forState:UIControlStateDisabled];
        
        [tagBtn addTarget:self action:@selector(topicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        // 重新计算当前View的尺寸  默认是空
        [tagBtn.titleLabel sizeToFit];
        
        // frame
        tagBtn.width = btnWidth;
        tagBtn.height = titleView.height;
        tagBtn.x = i * tagBtn.width;
        
        [titleView addSubview:tagBtn];
        
    }
    
    
    // 下划线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = [UIColor orangeColor];
    
    // frame
    
    bottomLine.height = 2;
    bottomLine.y = titleView.height - bottomLine.height;
    
    
    // 第一个btn
    UIButton *btn = titleView.subviews[0];
    
    
    bottomLine.width = btn.titleLabel.width;
    // 设置centerX 必须有尺寸 如果咩有尺寸 centerX不准确
    bottomLine.centerX = btn.centerX;
    
    [titleView addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    
    
    
    // 默认选中第一个
    [self topicBtnClick:btn];
}

-(void)setupScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    scrollView.delegate = self;
    
    scrollView.frame = self.view.bounds;
    scrollView.pagingEnabled = YES;
    
    scrollView.backgroundColor = [UIColor whiteColor];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    scrollView.contentSize = CGSizeMake(3 * YDTXScreenW, 0);
    
    [self.view addSubview:scrollView];
    self.contentView = scrollView;
    
    //    [self scrollViewDidEndScrollingAnimation:scrollView];
}

// 创建多个topicVC
-(void)setupChildVces
{
    
    
    
    for (int i = 0;i < 3; i++) {
        
        
        PartnerContentViewController *partnerVC = [PartnerContentViewController new];
        [self addChildViewController:partnerVC];
        
    }
}






// 点击topicsBtn
-(void)topicBtnClick:(UIButton *)btn
{
    // 三部曲
    self.selBtn.enabled = YES;
    btn.enabled = NO;
    self.selBtn = btn;
    
    // 下划线的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        // 每次点击都要设置下划线width
        self.bottomLine.width = btn.titleLabel.width;
        
        self.bottomLine.centerX = btn.centerX;
        
    }];
    
    // 切换控制器 => 滚动scrollView =>动画结束方法
    [self.contentView setContentOffset:CGPointMake(YDTXScreenW * btn.tag, 0) animated:YES];
    
    //setContentOffset可能受到self.automaticallyAdjustsScrollViewInsets的而影响导致不自动调用animation方法，手动调用
    [self scrollViewDidEndScrollingAnimation:self.contentView];
    
}



// 拖拽减速结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // index
    NSInteger index = scrollView.contentOffset.x / YDTXScreenW;
    
    // 点击btn加载对应的VC的view
    [self topicBtnClick:self.titleView.subviews[index]];
}


// 动画执行完成 setContentOffSet才有动画 拖拽是不掉用的
// 专门加载View
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // index
    NSInteger index = scrollView.contentOffset.x / YDTXScreenW;
    
    // 取出vC
    UIViewController *vc = self.childViewControllers[index];
    //    vc.view.backgroundColor = [UIColor greenColor];
    
    // 设置frame size
    vc.view.x = YDTXScreenW * index;
    vc.view.y = 0;
    
    // 加到scrollView上
    [scrollView addSubview:vc.view];
}






@end
