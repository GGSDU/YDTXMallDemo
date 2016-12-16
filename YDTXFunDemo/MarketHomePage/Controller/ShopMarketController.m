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
#import "ProductHeaderReusableView.h"
#import "ProductBriefCell.h"
#import "WatchMoreCell.h"

#define SectionAddCount 3

static NSString *bannerIdentifier = @"banner";
static NSString *categoryIdentifier = @"category";
static NSString *briefIdentifier = @"brief";
static NSString *productHeaderIdentifier = @"head";
static NSString *watchMoreIdentifier = @"watchMore";

@interface ShopMarketController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>;

@property (nonatomic,strong) UICollectionView *collectionView;


@property (nonatomic,strong) NSMutableArray *bannerArray;

@property (nonatomic,strong) NSMutableArray *categoryArray;

@property (nonatomic,strong) NSMutableDictionary *productBriefDic;
@property (nonatomic,strong) NSMutableArray *productBriefDicSortedKeyArray;

@end

@implementation ShopMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = StandardBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initData];
    
    [self creatUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init data
- (void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Category" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    self.categoryArray = [[NSMutableArray alloc] initWithArray:dic[@"Category"]];
    
    self.productBriefDic = [[NSMutableDictionary alloc] initWithDictionary:dic[@"ProductBrief"]];
    
    self.productBriefDicSortedKeyArray = [[NSMutableArray alloc] initWithArray:self.productBriefDic.allKeys];
    [self.productBriefDicSortedKeyArray sortUsingSelector:@selector(compare:)];
    
    NSLog(@"%@",self.productBriefDicSortedKeyArray);
}


#pragma mark - creatUI
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
    [_collectionView registerClass:[WatchMoreCell class] forCellWithReuseIdentifier:watchMoreIdentifier];
    [_collectionView registerClass:[ProductHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:productHeaderIdentifier];
}

#pragma mark - UICollectionViewDataSource
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        
        BannerCell *bannerCell = [collectionView dequeueReusableCellWithReuseIdentifier:bannerIdentifier forIndexPath:indexPath];
        cell = bannerCell;
        
    } else if (indexPath.section == 1) {
        
        CategoryCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:categoryIdentifier forIndexPath:indexPath];
        categoryCell.label.text = self.categoryArray[indexPath.row];
        
        cell = categoryCell;
        
    } else if (indexPath.section == self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        
        WatchMoreCell *watchMoreCell = [collectionView dequeueReusableCellWithReuseIdentifier:watchMoreIdentifier forIndexPath:indexPath];
        watchMoreCell.watchMoreHandler = ^(UIButton *aSender) {
            
        };
        
        cell = watchMoreCell;
        
    } else {
        
        ProductBriefCell *productBriefCell = [collectionView dequeueReusableCellWithReuseIdentifier:briefIdentifier forIndexPath:indexPath];
        
        NSString *key = self.productBriefDicSortedKeyArray[indexPath.section - SectionAddCount + 1];
        NSArray *productModelArray = [self.productBriefDic objectForKey:key];
        NSDictionary *productDic = [productModelArray objectAtIndex:indexPath.row];
        ProductModel *productModel = [[ProductModel alloc] init];
        productModel.infoImageURL = [productDic objectForKey:@"imageUrl"];
        productModel.infoName = [productDic objectForKey:@"info"];
        productModel.price = [[productDic objectForKey:@"price"] floatValue];
        productModel.vipPrice = [[productDic objectForKey:@"vipPrice"] floatValue];
        productModel.saleNumber = [[productDic objectForKey:@"saleNumber"] intValue];
        
        [productBriefCell updateViewWithProductModel:productModel];
        
        cell = productBriefCell;
    }
    return cell;
}

// cell count
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number = 1;
    if (section == 0 || section == self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        
        number = 1;
        
    } else if (section == 1) {
        
        number = self.categoryArray.count;
        
    } else {
        
        NSString *key = self.productBriefDicSortedKeyArray[section - SectionAddCount + 1];
        NSArray *productModelArray = [self.productBriefDic objectForKey:key];
        number = productModelArray.count;
    }
    return number;
}

// section count
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.productBriefDicSortedKeyArray.count + SectionAddCount;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
     
        if (indexPath.section > 2 && indexPath.section < self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
            ProductHeaderReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:productHeaderIdentifier forIndexPath:indexPath];
            NSString *key = self.productBriefDicSortedKeyArray[indexPath.section - SectionAddCount + 1];
            NSLog(@"%@",key);
            header.label.text = key;
            NSLog(@"%@",NSStringFromCGRect(header.label.frame));
            return header;
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
        float width = collectionView.frame.size.width / count - 0.2 * (count - 1);
        cellSize = CGSizeMake(width, width);
    } else if (indexPath.section == self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        cellSize = CGSizeMake(collectionView.frame.size.width - 20, 36);
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
    } else if (section == self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        return UIEdgeInsetsMake(10, 10, 23, 10);
    } else {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}

/** 每个cell垂直间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    if (section == 1) {
//        return 1;
//    } else
        if (section > 1 && section < self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        return 10;
    }
    return 0;
}

/** 每个cell水平间距 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    if (section == 1) {
//        return 1;
//    } else
        if (section > 1 && section < self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        return 5;
    }
    return 0;
}

/** 每个头标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section > 2 && section < self.productBriefDicSortedKeyArray.count + SectionAddCount - 1) {
        return CGSizeMake(collectionView.frame.size.width, 45);
    }
    return CGSizeZero;
}

///** 每个脚标题大小 */
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    return CGSizeZero;
//}

@end
