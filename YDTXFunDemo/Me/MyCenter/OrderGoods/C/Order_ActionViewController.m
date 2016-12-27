//
//  MyOrederGoodsViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "Order_ActionViewController.h"
#import "MyOrderGoodsTableViewCell.h"
#import "MyOrderGoodsModel.h"
#import "ActionShowOrderDetailViewController.h"

@interface Order_ActionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong)  AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *moreData;

@property (nonatomic, assign) int page;
@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation Order_ActionViewController

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
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
    
    self.title = @"我的订单";
    self.page = 2;
    [self.view addSubview:self.myTableView];
    self.myTableView.allowsMultipleSelectionDuringEditing = YES;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupRefresh];
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
        MyOrderGoodsModel *model = self.dataSource[indexPath.row];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"method"] = @6;
        dic[@"userid"] = userid;
        dic[@"pid"] = model.order_id;
        [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myDelete"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //            NSLog(@"ssss%@",responseObject);
            [self.dataSource removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.myTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
        
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)setupRefresh
{
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    self.myTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.myTableView.mj_header beginRefreshing];
    // 设置footer 上拉加载
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMo)];
}
- (void)loadData {
    self.page = 2;
    [self.myTableView.mj_footer endRefreshing];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"userid"] = userid;
    
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myOrder"] parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            
            if ([responseObject[@"status"] isEqual:@200]) {
                self.dataSource = [MyOrderGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
                
            }
            else if([responseObject[@"status"] isEqual:@400]) {
                UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去下单" message:@"还没有下过单" preferredStyle: UIAlertControllerStyleAlert];
                [alertController addAction:cancel];
                [alertController addAction:ensure];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
        }else {
            [self.myTableView.mj_header endRefreshing];
        }
        
         NSLog(@"我的订单请求成功：%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.myTableView.mj_header endRefreshing];
        self.myTableView.mj_footer.hidden = YES;
        NSLog(@"error is _+_+_+%@  _+_+_++%@",task,error);
        [SVProgressHUD showErrorWithStatus:@"我的订单数据获取失败"];
    }];
    
}
- (void)loadMo {
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer beginRefreshing];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    dic[@"page"] = @(self.page);
    dic[@"userid"] = userid;
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myOrder"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //         NSLog(@"aaaaa%@",responseObject[@"status"]);
        if (![responseObject[@"data"]isEqual:[NSNull null]]) {
            
            if ([responseObject[@"status"] isEqual:@200]) {
                self.moreData = [MyOrderGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.dataSource addObjectsFromArray:self.moreData];
                self.page ++;
                [self.myTableView.mj_footer endRefreshing];
                
                [self.myTableView reloadData];
            }else if([responseObject[@"status"] isEqual:@400]){
                
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
                self.page = 2;
            }
        }else {
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            self.page = 2;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"我的订单请求失败");
    }];
    
}


- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderGoodsModel *myOrderModel = self.dataSource[indexPath.row];
    CGFloat h = [MyOrderGoodsTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MyOrderGoodsTableViewCell *cell = (MyOrderGoodsTableViewCell *)sourceCell;
        [cell configCellWithModel:myOrderModel];
    }];
    return h;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *string = @"string";
    
    MyOrderGoodsModel *myOrderModel = self.dataSource[indexPath.row];
    
    MyOrderGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:string];
    
    if (!cell) {
        cell = [[MyOrderGoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:string];
    }
    [cell configCellWithModel:myOrderModel];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *currentDate = [NSDate date];
    
    MyOrderGoodsModel *myOrderModel = self.dataSource[indexPath.row];
    ActionShowOrderDetailViewController *actionShowDVC = [[ActionShowOrderDetailViewController alloc]initWithStyle:UITableViewStyleGrouped];
    actionShowDVC.order_number = myOrderModel.order_num;
    actionShowDVC.date = currentDate;
    [self.navigationController pushViewController:actionShowDVC animated:YES];
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
