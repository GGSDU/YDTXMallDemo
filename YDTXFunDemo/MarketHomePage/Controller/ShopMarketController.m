//
//  ShopMarketController.m
//  YDTXFunDemo
//
//  Created by Story5 on 13/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ShopMarketController.h"

#import "BannerCell.h"
#import "CategoryCell.h"
#import "ProductBriefCell.h"
#import "ProductHeaderReusableView.h"
#import "WatchMoreFooterReusableView.h"

#import "CartViewController.h"

#import "MarketCategoryListViewController.h"
#import "MarketDetailViewController.h"

#define SectionAddCount 2

static NSString *bannerIdentifier = @"banner";
static NSString *categoryIdentifier = @"category";
static NSString *briefIdentifier = @"brief";
static NSString *productHeaderIdentifier = @"head";
static NSString *watchMoreIdentifier = @"watchMore";

@interface ShopMarketController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,BannerCellDelegate>;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *bannerArray;

@property (nonatomic,strong) NSMutableArray *categoryArray;

/**
 *                       *   defaultProcutArray         -   dic1
 productBriefArray   -*                                  dic2
 *   recommendedProductArray    -   array - dic
 */
@property (nonatomic,strong) NSMutableArray *productBriefArray;

@end

@implementation ShopMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = StandardBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    
    [self customNavigationItem];
    
    [self creatUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - BannerCellDelegate
- (void)bannerCell:(BannerCell *)bannerCell didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"%@",self.bannerArray[index]);
}



#pragma mark - init data
- (void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    self.bannerArray = [[NSMutableArray alloc] initWithArray:dic[@"Banner"]];
    
    // 分类
    [[NetWorkService shareInstance] requestForShopCategoryWithPid:0 responseBlock:^(NSArray *responseModelArray) {
        
        self.categoryArray = [[NSMutableArray alloc] initWithArray:responseModelArray];
        [self.collectionView reloadData];
        
    }];
    
    
    
    [[NetWorkService shareInstance] requestForHomeListAggregatedDataWithResponseBlock:^(NSArray *productBriefModelArray) {
        
        self.productBriefArray = [[NSMutableArray alloc] initWithArray:productBriefModelArray];
        [self.collectionView reloadData];
    }];
}

#pragma mark - navigationItem event
- (void)searchBarItemClicked:(UIBarButtonItem *)aSender
{
    NSLog(@"点击了搜索");
}

- (void)cartBarItemClicked:(UIBarButtonItem *)aSender{
    NSLog(@"点击了购物车");
    CartViewController *cartVC = [[CartViewController alloc] init];
    [self.navigationController pushViewController:cartVC animated:YES];
}

#pragma mark - creatUI
- (void)customNavigationItem
{
    self.title = @"商城";
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchBarItemClicked:)];
    self.navigationItem.leftBarButtonItem = searchBarItem;
    
    UIImage *cartImage = [[UIImage imageNamed:@"Cart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIBarButtonItem *cartBarItem = [[UIBarButtonItem alloc] initWithImage:cartImage style:UIBarButtonItemStylePlain target:self action:@selector(cartBarItemClicked:)];
    self.navigationItem.rightBarButtonItem = cartBarItem;
}

- (void)creatUI{
    
    float originY = 64;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY) collectionViewLayout:layout];
    _collectionView.backgroundColor = StandardBackgroundColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    // 注册cell
    [_collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:bannerIdentifier];
    [_collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:categoryIdentifier];
    [_collectionView registerClass:[ProductBriefCell class] forCellWithReuseIdentifier:briefIdentifier];
    [_collectionView registerClass:[ProductHeaderReusableView class]
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:productHeaderIdentifier];
    [_collectionView registerClass:[WatchMoreFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:watchMoreIdentifier];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        //点击了分类的cell
        CategoryModel *categoryModel = self.categoryArray[indexPath.row];
        NSLog(@"%@",categoryModel.objectDictionary);
        
        MarketCategoryListViewController *marketCategoryListVC = [[MarketCategoryListViewController alloc]initWithCollectionViewLayout:[UICollectionViewLayout new]];
        marketCategoryListVC.ID = categoryModel.ID;
        marketCategoryListVC.title = categoryModel.title;
        

        [self.navigationController pushViewController:marketCategoryListVC animated:YES];
        
        
    } else if (indexPath.section >= SectionAddCount) {
        
        NSArray *productBriefArray = self.productBriefArray[indexPath.section - SectionAddCount];
        ProductBriefModel *productBriefModel = productBriefArray[indexPath.row];
        //点击了商品
        NSLog(@"点击了商品 %@",productBriefModel.objectDictionary);
        
        MarketDetailViewController *marketDetailVC = [MarketDetailViewController new];
        marketDetailVC.goods_id = productBriefModel.ID;
        [self.navigationController pushViewController:marketDetailVC animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        BannerCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerIdentifier forIndexPath:indexPath];
        bannerCell.delegate = self;
        bannerCell.bannerArray = self.bannerArray;
        [bannerCell createAutoScrollerView];
        
        cell = bannerCell;
        
    } else if (indexPath.section == 1) {
        
        CategoryCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryIdentifier forIndexPath:indexPath];
        CategoryModel *categoryModel = self.categoryArray[indexPath.row];
        [categoryCell.imageView sd_setImageWithURL:[SXPublicTool getImageURLByURLString:categoryModel.uploads]];
        categoryCell.label.text = categoryModel.title;
        
        cell = categoryCell;
        
    } else {
        
        ProductBriefCell *productBriefCell = [collectionView dequeueReusableCellWithReuseIdentifier:briefIdentifier forIndexPath:indexPath];
        
        NSArray *productBriefArray = self.productBriefArray[indexPath.section - SectionAddCount];
        ProductBriefModel *productBriefModel = productBriefArray[indexPath.row];
        
        [productBriefCell updateViewWithProductBriefModel:productBriefModel];
        
        cell = productBriefCell;
    }
    return cell;
}

// cell count
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number = 1;
    if (section == 0) {
        
        number = 1;
        
    } else if (section == 1) {
        
        number = self.categoryArray.count;
        
    } else {
        
        NSArray *productBriefArray = self.productBriefArray[section - SectionAddCount];
        number = productBriefArray.count;
    }
    return number;
}

// section count
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.productBriefArray.count + SectionAddCount;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section > SectionAddCount) {
        
        NSArray *productBriefArray = self.productBriefArray[indexPath.section - SectionAddCount];
        ProductBriefModel *productBriefModel = productBriefArray[indexPath.row];
        
        if (kind == UICollectionElementKindSectionHeader) {
            
            ProductHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:productHeaderIdentifier forIndexPath:indexPath];
            header.label.text = productBriefModel.up_title;
            return header;
            
        } else if (kind == UICollectionElementKindSectionFooter) {
            
            
            WatchMoreFooterReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:watchMoreIdentifier forIndexPath:indexPath];
            footer.watchMoreHandler = ^(UIButton *aSender){
                NSLog(@"点击了更多");
                NSLog(@"%@",productBriefModel.objectDictionary);
                
                
                
                MarketCategoryListViewController *marketCategoryListVC = [[MarketCategoryListViewController alloc]initWithCollectionViewLayout:[UICollectionViewLayout new]];
                marketCategoryListVC.ID = productBriefModel.pid;
                
                
                marketCategoryListVC.title = productBriefModel.up_title;
                [self.navigationController pushViewController:marketCategoryListVC animated:YES];
                
            };
            
            return footer;
        }
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每个cell的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize cellSize = CGSizeZero;
    if (indexPath.section == 0) {
        cellSize = CGSizeMake(collectionView.frame.size.width, 150);
    } else if (indexPath.section == 1) {
        float count = 4;//一行展示的cell数
        float width = (collectionView.frame.size.width - 0.2 * (count - 1)) / count;
        cellSize = CGSizeMake(width, width);
    } else {
        float width = (collectionView.frame.size.width - 25) / 2;
        cellSize = CGSizeMake(width, 276);
    }
    return cellSize;
}

/** 每个section的边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsZero;
    } else if (section == 1) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    } else {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}

/** 每个cell垂直间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 0.2;
    } else if (section >= SectionAddCount) {
        return 10;
    }
    return 0;
}

/** 每个cell水平间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 0.2;
    } else if (section >= SectionAddCount) {
        return 5;
    }
    return 0;
}

/** 每个头标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section > SectionAddCount) {
        return CGSizeMake(collectionView.frame.size.width, 45);
    }
    return CGSizeZero;
}

/** 每个脚标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (section > SectionAddCount) {
        return CGSizeMake(collectionView.frame.size.width, 36);
    }
    return CGSizeZero;
}

@end
