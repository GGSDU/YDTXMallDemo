//
//  MarketListViewController.m
//  market
//
//  Created by RookieHua on 2016/12/7.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketCategoryListViewController.h"
#import "markeListCell.h"
#import "MarketDetailViewController.h"
#import "marketListModel.h"
@interface MarketCategoryListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NetWorkServiceDelegate>

@property(strong,nonatomic)NSMutableArray *marketListDataArr;

@property(assign,nonatomic)NSInteger page;      //做上拉刷新用
@end

@implementation MarketCategoryListViewController

static NSString * const kmarketListCellId = @"marketListCell";
//lazy
-(NSMutableArray *)marketListDataArr{
    if (!_marketListDataArr) {
        _marketListDataArr = [NSMutableArray array];
    }
    return _marketListDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    [self setupRefresh];
    
}

//配置一些基本设置
-(void)setBasic{
    
    [[NetWorkService shareInstance] setDelegate:self];

    
    
    //nav标题
//    self.title = @"商品列表";
    
    
    // 创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 10;
    // 最小列间距
    flowLayout.minimumInteritemSpacing = 5;
    //cell的尺寸
    CGFloat cellW = ([UIScreen mainScreen].bounds.size.width-25)/2;
    flowLayout.itemSize = CGSizeMake(cellW, 275);
    
    
    /**
     *  设置自动滚动的方向 垂直或者横向
     */
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
//    self.collectionView.frame = CGRectMake(0, 0, YDTXScreenW, YDTXScreenH-64);
    self.collectionView.collectionViewLayout = flowLayout;
    //设置属性
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
//    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    // 是否显示垂直方向指示标, 继承于UIScrollView, 他的方法可以调用
//    self.collectionView.showsVerticalScrollIndicator = NO;
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([markeListCell class]) bundle:nil] forCellWithReuseIdentifier:kmarketListCellId];
   
    
    
    // 添加到视图上
    [self.view addSubview:self.collectionView];

}



// 设置刷新控件  上啦下拉
-(void)setupRefresh
{
    // 展示header  下拉触发loadNewData
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadCategoryNewData)];
    
    
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    // 进入刷新状态 自动触发loadNewData
    [self.collectionView.mj_header beginRefreshing];
    
    
    
    // 设置footer
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadCategoryMoreData)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark <UICollectionViewDataSource>

// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{


    return self.marketListDataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    markeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kmarketListCellId forIndexPath:indexPath];
    marketListModel *model = self.marketListDataArr[indexPath.row];
    cell.markeListModel = model;

    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中了cell");
    //选中cell  跳转到商品详情页
    marketListModel *model = self.marketListDataArr[indexPath.row];
    
    MarketDetailViewController *marketDetailVC = [MarketDetailViewController new];
    marketDetailVC.goods_id = model.ID;
    [self.navigationController pushViewController:marketDetailVC animated:YES];
    
    
}


#pragma mark --- Set/Get
-(void)setClasslistType:(classListType)classlistType{
   
    
    
   
}

#pragma mark ---load Data Method



//下拉刷新
-(void)loadCategoryNewData{
    /*
     * page，id（分类的id）
     */
    
    [self.collectionView.mj_footer resetNoMoreData];
    self.page = 1;
    [[NetWorkService shareInstance]requestForMarketCategoryListDataWithPid:self.ID Page:self.page responseBlock:^(NSArray *marketListModelArray) {
        [_marketListDataArr removeAllObjects];
        [self.marketListDataArr addObjectsFromArray:marketListModelArray];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        
    }];
    
}

//上啦加载
-(void)loadCategoryMoreData{
    [self.collectionView.mj_footer endRefreshing];
    
    self.page += 1;
    
    [[NetWorkService shareInstance]requestForMarketCategoryListDataWithPid:self.ID Page:self.page responseBlock:^(NSArray *marketListModelArray) {
       
        [self.marketListDataArr addObjectsFromArray:marketListModelArray];
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView reloadData];
        
        
    }];
    

}


#pragma mark - networkServiceDelegate
- (void)networkService:(NetWorkService *)networkService requestFailedWithTask:(NSURLSessionDataTask *)task error:(NSError *)error message:(NSString *)message
{
    
     [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    self.page -=1;
    [RHNotiTool NotiShowWithTitle:@"网络跑丢了~" Time:1.0];
    
}

-(void)mj_footerNoMoreData{
    
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];

}

@end
