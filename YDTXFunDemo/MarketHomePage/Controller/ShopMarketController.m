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

#import "DisplayView.h"

#define SectionCount 2

static NSString *bannerIdentifier = @"banner";
static NSString *categoryIdentifier = @"category";

@interface ShopMarketController ()<UICollectionViewDelegate,UICollectionViewDataSource>;

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableArray *categoryArray;

@end

@implementation ShopMarketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(238, 238, 238);
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
    self.categoryArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    
}


#pragma mark - creatUI
- (void)creatUI{
    
    float originY = 64;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    // 注册cell
    [_collectionView registerClass:[BannerCell class] forCellWithReuseIdentifier:bannerIdentifier];
    [_collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:categoryIdentifier];
    
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
        categoryCell.layer.borderColor = [UIColor redColor].CGColor;
        categoryCell.layer.borderWidth = 1;
        categoryCell.label.text = self.categoryArray[indexPath.row];
        
        cell = categoryCell;
        
    } else if (indexPath.section == 2) {
        
    }
    return cell;
}

// cell count
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger number = 1;
    if (section == 1) {
        
        number = self.categoryArray.count;
        
    } else if (section == 2) {
        
    }
    return number;
}

// section count
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return SectionCount;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
/** 每个头标题大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

/** 每个cell的大小 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    CGSize cellSize = CGSizeZero;
    if (indexPath.section == 0) {
        cellSize = CGSizeMake(collectionView.frame.size.width, 150);
    } else if (indexPath.section == 1) {
        cellSize = CGSizeMake(90, 90);
    } else if (indexPath.section == 2) {
        cellSize = CGSizeMake(175, 276);
    }
    return cellSize;
}

/** 每个section的边距 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return UIEdgeInsetsZero;
}

@end
