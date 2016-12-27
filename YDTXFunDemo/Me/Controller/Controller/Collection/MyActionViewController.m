//
//  MyActionViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyActionViewController.h"

#import "MeCollectionViewController.h"
#import "MeActionViewController.h"
#import "MyCollectionViewController.h"
#import "MeGoodsViewController.h"

@interface MyActionViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *TabScrollerView;

@property (nonatomic, strong) UIView *buttonView;//标题视图
@property (nonatomic, strong) UITableView *myTableView;//
@property (nonatomic, strong) UIView *lineView;//线
@property (nonatomic ,strong) NSArray *array;//标题名称数组
@property (nonatomic, strong) UIButton *button;//标题按钮
@property (strong, nonatomic) UIView *bottomLine;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titleView;
@property (strong, nonatomic) UIButton *selBtn;




@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation MyActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;

    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"我的收藏";
    self.array = @[@"塘口",@"活动",@"帖子",@"商品"];
    [self setupChildrenVC];
    [self creatTabScrollerView];
    [self creatButView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //设置导航条背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault] ;
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.backBarButtonItem.image = [UIImage imageNamed:@"back"];
}

- (void)setupChildrenVC {
    MeCollectionViewController *meCoVC = [[MeCollectionViewController alloc]init];
    [self addChildViewController:meCoVC];
    
    MeActionViewController *meAcVc = [[MeActionViewController alloc]init];
    [self addChildViewController:meAcVc];
    
    MyCollectionViewController *myCollect = [[MyCollectionViewController alloc]init];
    [self addChildViewController:myCollect];
    
   [self addChildViewController:[[MeGoodsViewController alloc]init]];

}

/**
 *  创建视图
 *
 *  @param sender
 */

- (void) creatButView {

    UIView *titleView = [[UIView alloc]init];
    
    
    
    titleView.backgroundColor = [UIColor whiteColor];
    
    titleView.y = 0;
    titleView.width = YDTXScreenW;
    titleView.height = 35;
    
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    
    // 创建btn
    
//    NSArray *titles = @[@"推荐",@"报名中",@"进行中",@"历史"];
    CGFloat btnWidth = YDTXScreenW / self.array.count;
    for (int i = 0; i < self.array.count; i++)
    {
        
        
        // 添加tags
        UIButton *tagBtn = [[UIButton alloc]init];
        
        
        // 点击btn时处理scrollView的偏移量
        tagBtn.tag = 900+i;
        
        
        [tagBtn setTitle:self.array[i] forState:UIControlStateNormal];
        
        [tagBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tagBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateDisabled];
        
        [tagBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
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
    [self buttonAction:btn];
   
    
    
}
/**
 *  创建滚动视图
 */
- (void) creatTabScrollerView {
    self.TabScrollerView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.TabScrollerView.pagingEnabled = YES;
    self.TabScrollerView.scrollEnabled = NO;
    self.TabScrollerView.contentSize = CGSizeMake(self.array.count*ScreenWidth, 0);
    [self.view addSubview:self.TabScrollerView];

    
}


- (void)buttonAction:(UIButton *)sender {
    self.button.enabled = YES;
    sender.enabled = NO;
    self.button = sender;
    
    // 下划线的位置
    [UIView animateWithDuration:0.25 animations:^{
        
        // 每次点击都要设置下划线width
        self.bottomLine.width = sender.titleLabel.width;
        
        self.bottomLine.centerX = sender.centerX;
        
    }];
    [self.TabScrollerView setContentOffset:CGPointMake(ScreenWidth*(sender.tag-900), 0) animated:YES];
//    [self scrollViewDidEndScrollingAnimation:self.TabScrollerView];
    
//    NSInteger index = self.TabScrollerView.contentOffset.x / ScreenWidth;
    NSInteger index = sender.tag - 900;
//    NSLog(@"%ld",index);
    // 取出vC
    UIViewController *vc = self.childViewControllers[index];
    
    vc.view.frame = CGRectMake(ScreenWidth*index, 45*HeightScale, ScreenWidth, ScreenHeight-119*HeightScale);
    // 加到scrollView上
    [self.TabScrollerView addSubview:vc.view];
    
}
#warning 滚动 暂时不要
// 拖拽减速结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // index
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    
    // 点击btn加载对应的VC的view
    [self buttonAction:self.buttonView.subviews[index]];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // index
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    // 取出vC
    UIViewController *vc = self.childViewControllers[index];

    vc.view.frame = CGRectMake(ScreenWidth*index, 45*HeightScale, ScreenWidth, ScreenHeight-119*HeightScale);
    // 加到scrollView上
    [scrollView addSubview:vc.view];
    
}


- (void)didReceiveMemoryWarning {
    [[SDImageCache sharedImageCache] clearMemory];
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    SDImageCache *canche = [SDImageCache sharedImageCache];
    canche.shouldDecompressImages = SDImageCacheOldShouldDecompressImages;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
