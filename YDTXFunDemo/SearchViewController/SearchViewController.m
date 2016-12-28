//
//  SearchViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 23/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchHeaderReusableView.h"
#import "HistoryCollectionViewCell.h"
#import "MarketDetailViewController.h"

@interface SearchViewController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NetWorkServiceDelegate>

// 搜索栏
@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,assign) BOOL historyStatus;

@property (nonatomic,copy) NSString *keyword;
@property (nonatomic,assign) int page;

// 搜索历史
@property (nonatomic,strong) NSMutableArray *historyArray;
// 搜索结果
@property (nonatomic,strong) NSMutableArray *resultArray;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) MJRefreshNormalHeader *mj_header;
@property (nonatomic,strong) MJRefreshBackNormalFooter *mj_footer;

@end

static NSString *historyHeaderIdentifier = @"historyHeader";
static NSString *historyIdentifier = @"historyCell";
static NSString *productIdentifier = @"productCell";

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(238, 238, 238);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.hidesBackButton = YES;

    
    [self initData];
    _page = 1;
    self.historyStatus = YES;
    
    [self createSearchBar];
}

#pragma mark - init data
- (BOOL)isExistModel:(ProductBriefModel *)model inArray:(NSArray *)array;
{
    for (ProductBriefModel *pModel in array) {
        
        if (pModel.ID == model.ID) {
            return YES;
        }
    }
    
    return NO;
}

- (NSMutableArray *)historyArray {
    if (_historyArray == nil) {
        _historyArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _historyArray;
}

- (NSMutableArray *)resultArray {
    if (_resultArray == nil) {
        _resultArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _resultArray;
}

- (void)initData {
    
    [[SXSqliteTool shareInstance] inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:@"create table if not exists t_search_history(uid integer primary key autoincrement,searchText text unique)"];
        if (result) {
            NSLog(@"创建表成功");
            
            FMResultSet *rs = [db executeQuery:@"select * from t_search_history"];
            while (rs.next) {
                NSString *searchText = [rs stringForColumn:@"searchText"];
                [self.historyArray addObject:searchText];
            }
            
            
            if (self.historyArray.count > 0) {
                self.collectionView ? self.collectionView.hidden = NO : [self createColectionView];
            } else {
                self.collectionView ? self.collectionView.hidden = YES : 0;
            }
            
        } else {
            NSLog(@"创建表失败");
            self.collectionView ? self.collectionView.hidden = YES : 0;
        }
    }];
}

#pragma mark - private 
- (void)startSearchWithKeyword:(NSString *)keyword page:(int)page
{
    if (keyword == nil || keyword.length <= 0 || page <= 0) {
        return;
    }
    
    [[NetWorkService shareInstance] requestForSearchProductWithKeyword:keyword page:page responseBlock:^(NSArray *productBriefModelArray) {
        
        for (ProductBriefModel *model in productBriefModelArray) {
            if (![self isExistModel:model inArray:self.resultArray]) {
                [self.resultArray addObject:model];
            }
        }
        
        self.historyStatus = NO;
        self.collectionView.hidden = NO;
        [self.collectionView reloadData];
        
        [[SXSqliteTool shareInstance] inDatabase:^(FMDatabase *db) {
            
            [db executeUpdate:@"insert into t_search_history(searchText) values(?)",_keyword];
        }];

    } failedBlock:^{
       

        
    }];
}

#pragma makr - UISearchBarDelegate
// called when text changes (including clear)
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if (searchText.length > 0) {
//        _keyword = searchText;
//        [self startSearchWithKeyword:_keyword page:_page];
//    }
//}

// return NO to not become first responder
//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
//    
//    NSLog(@"%s",__func__);
//    
//    return YES;
//}

// called when text starts editing
//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    NSLog(@"%s",__func__);
//}

// return NO to not resign first responder
//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
//    NSLog(@"%s",__func__);
//    
//    return YES;
//}

// called when text ends editing
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSLog(@"%s",__func__);
    [searchBar resignFirstResponder];
    UIButton *cancelButton = [searchBar valueForKey:@"cancelButton"];
    cancelButton.enabled = YES;
}

// called before text changes
//- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
//    NSLog(@"%s",__func__);
//    return NO;
//}

// called when keyboard search button pressed
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__func__);
    _keyword = searchBar.text;
    if (_keyword.length > 0) {
        [self startSearchWithKeyword:_keyword page:_page];
    }
    [searchBar resignFirstResponder];
    
    UIButton *cancelButton = [searchBar valueForKey:@"cancelButton"];
    cancelButton.enabled = YES;
}

// called when cancel button pressed
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__func__);
    
    
    if (self.historyStatus) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.historyStatus = YES;
        [self.collectionView reloadData];
    }
    
    [searchBar resignFirstResponder];
    UIButton *cancelButton = [searchBar valueForKey:@"cancelButton"];
    cancelButton.enabled = YES;
}

#pragma mark - UICollectionView delegate &&  datasource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"history");
    if (self.historyStatus) {
        if (indexPath.row == self.historyArray.count) {
            // 点击了清楚搜索记录
            [self.historyArray removeAllObjects];
            self.collectionView.hidden = YES;
            
        } else {
            
            NSString *searchText = self.historyArray[indexPath.row];
            _keyword = searchText;
            [self startSearchWithKeyword:_keyword page:_page];
        }
    } else {
        ProductBriefModel *model = _resultArray[indexPath.row];
        
        //跳转详情页
        MarketDetailViewController *vc = [MarketDetailViewController new];
        vc.goods_id = model.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.historyStatus) {
        if (kind == UICollectionElementKindSectionHeader) {
            
            SearchHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:historyHeaderIdentifier forIndexPath:indexPath];
            header.textLabel.text = @"搜索历史";
            return header;
        }
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (self.historyStatus) {
        HistoryCollectionViewCell *historyCell = [collectionView dequeueReusableCellWithReuseIdentifier:historyIdentifier forIndexPath:indexPath];
        
        if (indexPath.row < self.historyArray.count) {
            historyCell.textLabel.textColor = RGB(77, 77, 77);
            historyCell.textLabel.textAlignment = NSTextAlignmentLeft;
            historyCell.textLabel.text = self.historyArray[indexPath.row];
        } else {
            historyCell.textLabel.textColor = RGB(174, 174, 174);
            historyCell.textLabel.textAlignment = NSTextAlignmentCenter;
            historyCell.textLabel.text = @"清除搜索记录";
        }
        
        cell = historyCell;
    } else {
        
        ProductBriefCell *productBriefCell = [collectionView dequeueReusableCellWithReuseIdentifier:productIdentifier forIndexPath:indexPath];

        ProductBriefModel *productBriefModel = self.resultArray[indexPath.row];
        
        [productBriefCell updateViewWithProductBriefModel:productBriefModel];
        
        cell = productBriefCell;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count = self.historyStatus ? self.historyArray.count + 1: self.resultArray.count;
    return count;
}

/** 每个cell的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize size = CGSizeZero;
    if (self.historyStatus) {
        size = CGSizeMake(collectionView.frame.size.width, 40);
    } else {
        float width = (collectionView.frame.size.width - 25) / 2;
        size = CGSizeMake(width, 276);
    }
    return size;
}

/** 每个section的边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if (!self.historyStatus) {
        edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    
    return edgeInsets;
}

/** 每个cell垂直间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    if (self.historyStatus) {
        return 1;
    } else {
        return 10;
    }
    return 0;
}

/** 每个cell水平间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    if (!self.historyStatus) {
        return 5;
    }
    return 0;
}

/** 每个头标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (self.historyStatus) {
        return CGSizeMake(collectionView.bounds.size.width, 40);
    }
    return CGSizeZero;
}

#pragma mark - init UI
- (void)createSearchBar
{
    float originX = 15;
    float height = 30;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(originX, 0, CGRectGetWidth(self.view.bounds) - originX, height)];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"输入商品名称";
    self.searchBar.keyboardType = UIKeyboardTypeWebSearch;
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    UIButton *cancelBtn = [self.searchBar valueForKeyPath:@"cancelButton"];
    cancelBtn.enabled = YES;

    
}

- (void)createColectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    float originY = 64;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, self.view.bounds.size.width, self.view.bounds.size.height - originY) collectionViewLayout:layout];
    self.collectionView.backgroundColor = RGB(238, 238, 238);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[SearchHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:historyHeaderIdentifier];
    [self.collectionView registerClass:[HistoryCollectionViewCell class] forCellWithReuseIdentifier:historyIdentifier];
    
    [self.collectionView registerClass:[ProductBriefCell class] forCellWithReuseIdentifier:productIdentifier];
}

#pragma mark - pull to update &&
- (void)setHistoryStatus:(BOOL)historyStatus
{
    _historyStatus = historyStatus;
    
    
    if (_historyStatus) {
        self.collectionView.mj_header = nil;
        self.collectionView.mj_header = nil;
    } else {
        //设置代理  处理一些问题（1.没有更多数据 2.刷新成功或者失败都要停止刷新）  有问题！TnT
        //    [NetWorkService shareInstance].delegate = self;
        
        // 展示header  下拉触发loadNewData
        self.collectionView.mj_header = self.mj_header;
        
#pragma warning --- 一般设置完让他直接出发下拉刷新  但是老哥你这是替换数据源   所以一开始不是搜索列表的时候不能刷新 不然会蹦
        // 进入刷新状态 自动触发loadNewData
        //    [self.collectionView.mj_header beginRefreshing];
        
        // 设置footer
        self.collectionView.mj_footer = self.mj_footer;
    }
    
    [self.collectionView reloadData];
}


#pragma mark -- 上拉下拉加载
- (void)loadNewData{
    
    [self startSearchWithKeyword:_keyword page:1];
}

- (void)loadMoreData{
    
    _page ++;
    NSLog(@"---页数：%d",_page);
    [self startSearchWithKeyword:_keyword page:_page];

}


#pragma mark - networkServiceDelegate  刷新成功后让他停止刷新   还有一些细节待处理  明天说~
- (void)networkService:(NetWorkService *)networkService requestFailedWithTask:(NSURLSessionDataTask *)task error:(NSError *)error message:(NSString *)message
{
    
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
    self.page -=1;
    [RHNotiTool NotiShowWithTitle:@"网络跑丢了~" Time:1.0];
    
}

- (void)mj_footerNoMoreData{
    
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
    
}

- (MJRefreshNormalHeader *)mj_header
{
    if (_mj_header == nil) {
        _mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        //头部透明度 随着collectionView的滚动自动影藏或显示
        _mj_header.automaticallyChangeAlpha = YES;
    }
    return _mj_header;
}

- (MJRefreshBackNormalFooter *)mj_footer
{
    if (_mj_footer == nil) {
        _mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    }
    return _mj_footer;
}


@end
