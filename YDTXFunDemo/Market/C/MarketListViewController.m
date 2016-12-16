//
//  MarketListViewController.m
//  market
//
//  Created by RookieHua on 2016/12/7.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketListViewController.h"
#import "markeListCell.h"
#import "MarketDetailViewController.h"
#import "marketListModel.h"
@interface MarketListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)NSMutableArray *marketListDataArr;

@end

@implementation MarketListViewController

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
    

    
    
    //nav标题
    self.title = @"商品列表";
    
    
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
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    // 进入刷新状态 自动触发loadNewData
    [self.collectionView.mj_header beginRefreshing];
    
    
    
    // 设置footer
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark <UICollectionViewDataSource>

// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return self.marketListDataArr.count;
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    markeListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kmarketListCellId forIndexPath:indexPath];
    marketListModel *model = self.marketListDataArr[indexPath.row];
    cell.markeListModel = model;
//
    
    return cell;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中了cell");
    //选中cell  跳转到商品详情页
    MarketDetailViewController *marketDetailVC = [MarketDetailViewController new];
    
    [self.navigationController pushViewController:marketDetailVC animated:YES];
    
    
}


#pragma mark --- Set/Get
-(void)setClasslistType:(classListType)classlistType{
   
    
    
   
}

#pragma mark ---load Data Method



//下拉刷新
-(void)loadNewData{
    /*
     * page，id（分类的id）
     */
    
    NSLog(@"下拉刷新");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"1" forKey:@"page"];
    [params setObject:@"13" forKey:@"id"];
//    params[@"page"] = @1;
//    params[@"id"] = @(13);
    
    NSString *url = @"http://test.m.yundiaoke.cn/api/goods/classList";
//    NSString *url = @"http://test.m.yundiaoke.cn/api/goods/classList/id/1/page/1";
    
//    NSString *appendUrl = url stringByAppendingString:@"?page"

    NSLog(@"请求前");
    NSLog(@"%@",[NetWorkService shareInstance]);
    [[NetWorkService shareInstance] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        NSLog(@"请求中。。。");
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"列表数据=》：%@",responseObject[@"data"]);
        if ([responseObject[@"status"] integerValue] == 200) {
            
            self.marketListDataArr = [marketListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            
        }
        
        
        [self.collectionView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        NSLog(@"请求失败");
        
        [self.collectionView.mj_header endRefreshing];
    }];
    NSLog(@"请求后");
    
}

//上啦加载
-(void)loadMoreData{
    [self.collectionView.mj_footer endRefreshing];
    NSLog(@"上啦加载");
    
}



@end
