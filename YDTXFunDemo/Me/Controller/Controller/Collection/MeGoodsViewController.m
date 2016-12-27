//
//  MeGoodsViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeGoodsViewController.h"
#import "MeGoodsTableViewCell.h"
#import "MeGoodsModel.h"

#import "MarketDetailViewController.h"
#import "MarketViewController.h"
#import "MarketModel.h"

@interface MeGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *moreData;
@property (nonatomic, assign) int page;
@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation MeGoodsViewController

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
    if(!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;

    
    
    self.page = 2;
//    我的商品收藏
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    self.page = 2;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.myTableView.mj_footer.hidden = YES;
    //    @2  userid
    dic[@"userid"] = userid;
    dic[@"method"] = @4;
    dic[@"page"] = @1;
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"我的商品收藏成功%@",responseObject);
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
       
        if ([responseObject[@"status"] isEqual:@200]) {
            self.array = [MeGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.myTableView.mj_header endRefreshing];
            [self.myTableView reloadData];
        }else if([responseObject[@"status"] isEqual:@400]){
            self.myTableView.mj_header.hidden = YES;
            [self.myTableView.mj_header endRefreshing];
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"还未收藏" message:@"是否去收藏?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            
            alertView.delegate =self;
            [alertView show];
        }
            
        }else {
            [self.myTableView.mj_header endRefreshing];
            self.myTableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
        self.myTableView.mj_footer.hidden = YES;
       
        [SVProgressHUD showErrorWithStatus:@"商品收藏数据获取失败"];
    }];
}
- (void)loadMoreData {
    [self.myTableView.mj_footer beginRefreshing];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    @2  userid
    dic[@"userid"] = userid;
    dic[@"method"] = @4;
    dic[@"page"] = @(self.page);
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"我的商品收藏成功%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            self.array = [MeGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.moreData addObjectsFromArray:self.array];
           self.page++;
            [self.myTableView.mj_footer endRefreshing];
            [self.myTableView reloadData];
        }else if([responseObject[@"status"] isEqual:@400]){
           [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            self.page = 2;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"我的商品收藏失败");
    }];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        
        for (UIViewController *controller in self.navigationController.viewControllers) {
//            NSLog(@"%@",self.navigationController.viewControllers);
            if ([controller isKindOfClass:[MarketViewController class]]) {
                [self.navigationController popToViewController:controller animated:YES];
                
            }else {
               [self.navigationController popToRootViewControllerAnimated:YES];
               
            }
        }
    }
    
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    switch (buttonIndex) {
//        case 0:
//            NSLog(@"0");
//            break;
//        case 1:
//            for (UIViewController *controller in self.navigationController.viewControllers) {
//                
//                if ([controller isKindOfClass:[MarketViewController class]]) {
//                    
//                    [self.navigationController popToViewController:controller animated:YES];
//                }else {
//                    NSLog(@"1");
//                }
//            }
//            break;
//            
//        default:
//            break;
//    }
//}

- (void)creatView {
    
    self.myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [self.myTableView addGestureRecognizer:tap];
    [self.view addSubview:self.myTableView];
//    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight-104));
//    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MeGoodsModel *model = self.array[indexPath.row];
    CGFloat h = [MeGoodsTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MeGoodsTableViewCell *cell = (MeGoodsTableViewCell *)sourceCell;
        [cell configModel:model];
    }];
    
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *collection = @"collection";
    MeGoodsModel *model = self.array[indexPath.row];
    MeGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collection];
    if (!cell) {
        cell = [[MeGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:collection];
    }
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [cell.contentView addGestureRecognizer:longPress];
    [cell configModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MarketDetailViewController *mdVC = [[MarketDetailViewController alloc]init];
    MeGoodsModel *model = self.array[indexPath.row];
    NSLog(@"-----%@",model.ID);
    mdVC.goods_id = model.ID;
    [self.navigationController pushViewController:mdVC animated:YES];
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
        MeGoodsModel *model = self.array[indexPath.row];
//        NSLog(@"tiezi :%@,%@",model.pid,userid);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"method"] = @4;
        dic[@"userid"] = userid;
        dic[@"pid"] = model.pid;
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
