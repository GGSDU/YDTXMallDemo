//
//  MeCollectionViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/12.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeCollectionViewController.h"
#import "MeCollectionTableViewCell.h"
#import "MeTKCollectionModel.h"
#import "FishPointDetailViewController.h"
#import "FishPointDetailModel.h"


@interface MeCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic ,strong) NSMutableArray *array;

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSMutableArray *moreData;
@property (nonatomic, assign) int page;

@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation MeCollectionViewController

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}
- (NSMutableArray *)moreData {
    if (!_moreData) {
        _moreData = [NSMutableArray array];
    }
    return _moreData;
}
- (NSArray *)array {
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self loadData];
}

// 我的收藏

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;

    
    self.page = 2;
    self.view.backgroundColor = [UIColor blueColor];
    
//    self.title = @"塘口";
    [self creatView];
    [self setupRefresh];
    
}

-(void)setupRefresh
{
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.myTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.myTableView.mj_header beginRefreshing];
    // 设置footer 上拉加载
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadData {
    self.myTableView.mj_footer.hidden = YES;
    
    self.page = 2;
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    dic[@"userid"] = userid;
    dic[@"method"] = @1;

    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"我的塘口收藏成功%@",responseObject[@"status"]);
        if ([responseObject[@"status"] isEqual:@200]) {
            self.array = [MeTKCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView reloadData];
        }else if([responseObject[@"status"] isEqual:@400]){
            self.myTableView.mj_header.hidden = YES;
            UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                UIViewController *vc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 2];
                [self.navigationController popToViewController:vc animated:YES];
             
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去收藏" message:@"还没有收藏过" preferredStyle: UIAlertControllerStyleAlert];
            [alertController addAction:cancel];
            [alertController addAction:ensure];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
        self.myTableView.mj_footer.hidden = YES;
       [SVProgressHUD showErrorWithStatus:@"我的塘口收藏获取失败"];
    }];
    
    
}

- (void)loadMoreData {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    dic[@"userid"] = userid;
    dic[@"method"] = @1;
    dic[@"page"] = @(self.page);
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"我的塘口收藏成功%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            self.array = [MeTKCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.page ++;
            [self.moreData addObjectsFromArray:self.array];
            [self.myTableView.mj_footer endRefreshing];
            [self.myTableView reloadData];
        }else if([responseObject[@"status"] isEqual:@400]){
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            self.page = 2;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [SVProgressHUD showErrorWithStatus:@"我的塘口收藏获取失败"];
    }];
}

/**
 *  创建TalbleView
 */
- (void) creatView {

     self.myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
//    self.myTableView.tableHeaderView = self.segmentC;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [self.myTableView addGestureRecognizer:tap];
    
    [self.view addSubview:self.myTableView];
    
//    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight-104));
//    }];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeTKCollectionModel *mecollectionModel = [self.array objectAtIndex:indexPath.row];
    
    CGFloat h = [MeCollectionTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MeCollectionTableViewCell *cell = (MeCollectionTableViewCell *)sourceCell;
        [cell configModel:mecollectionModel];
        
    }];
    return h;
//    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *collection = @"collection";
    MeTKCollectionModel *memodel  = self.array[indexPath.row];
        MeCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collection];
        if (!cell) {
            cell = [[MeCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:collection];
            
       }
#warning 长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [cell.contentView addGestureRecognizer:longPress];
//    NSLog(@"%@",model.)
    [cell configModel:memodel];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FishPointDetailViewController *fpdVC = [[FishPointDetailViewController alloc]init];
    MeTKCollectionModel *model = self.array[indexPath.row];
    fpdVC.pon_id = model.pon_id;
    [self.navigationController pushViewController:fpdVC animated:YES];
}

#warning 删除
//当处于编辑状态的时候 添加一个手势让它处于不编辑状态
//- (void)tap:(UITapGestureRecognizer *)tap {
//    if (self.myTableView.editing == YES) {
//        self.myTableView.editing = NO;
//    }
//}
- (void)longPress:(UILongPressGestureRecognizer *)press {
    if (press.state == UIGestureRecognizerStateEnded) {
        if (self.myTableView.editing == NO) {
            self.myTableView.editing = YES;
        }else {
            self.myTableView.editing = NO;
        }
    }
}
- (void)setEditing:(BOOL)editing {
    [super setEditing:editing];
    [self.myTableView setEditing:editing];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        
        
        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        MeTKCollectionModel *model = self.array[indexPath.row];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"method"] = @1;
        dic[@"userid"] = userid;
        dic[@"pid"] = model.pon_id;
        [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myDelete"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"取消收藏成功");
            [self.array removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.myTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"取消收藏失败");
        }];
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
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
