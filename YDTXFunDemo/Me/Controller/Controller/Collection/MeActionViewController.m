//
//  MeActionViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/13.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeActionViewController.h"
#import "MeActionTableViewCell.h"
#import "MeActionModel.h"
#import "ActionDetailViewController.h"
#import "ActionDetailModel.h"


@interface MeActionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic ,strong) NSMutableArray *array;
@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSMutableArray *moreData;
@property (nonatomic, assign) int page;

@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation MeActionViewController
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
- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
    
    
    // 活动
    self.page = 2;
    self.view.backgroundColor = [UIColor yellowColor];
    
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
    //    self.myTableView.mj_footer.hidden = YES;
    //    self.myTableView.mj_header.hidden = NO;
    
    self.page = 2;
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    @2  userid
    dic[@"userid"] = userid;
    dic[@"method"] = @2;
    
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"我的活动收藏成功%@",responseObject);
        if (![responseObject[@"data"] isEqual:[NSNull null]]) {
            if ([responseObject[@"status"] isEqual:@200]) {
                self.array = [MeActionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
            }else if([responseObject[@"status"] isEqual:@400]){
                [self.myTableView.mj_header endRefreshing];
                //            self.myTableView.mj_header.hidden = YES;
                UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"去收藏" message:@"还没有收藏过" preferredStyle: UIAlertControllerStyleAlert];
                [alertController addAction:cancel];
                [alertController addAction:ensure];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }else {
            [self.myTableView.mj_header endRefreshing];
            self.myTableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
        //        self.myTableView.mj_footer.hidden = YES;
        [SVProgressHUD showErrorWithStatus:@"我的活动收藏获取失败"];
    }];
    
}
- (void)loadMoreData {
    //    self.myTableView.mj_footer.hidden = NO;
    [self.myTableView.mj_footer beginRefreshing];
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //    @2  userid
    dic[@"userid"] = userid;
    dic[@"method"] = @2;
    dic[@"page"] = @(self.page);
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myCollection"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject[@"data"] isEqual:[NSNull null]]) {
            
            
            //        NSLog(@"我的活动收藏成功%@",responseObject);
            if ([responseObject[@"status"] isEqual:@200]) {
                self.array = [MeActionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.moreData addObjectsFromArray:self.array];
                self.page++;
                [self.myTableView.mj_footer endRefreshing];
                [self.myTableView reloadData];
            }else if([responseObject[@"status"] isEqual:@400]){
                [self.myTableView.mj_footer endRefreshingWithNoMoreData];
                self.page = 2;
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD showErrorWithStatus:@"我的活动收藏获取失败"];
    }];
}

- (void) creatView {
    
    self.myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.editing = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120*HeightScale;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.array != nil&&self.array.count>0) {
        
        
        static NSString *action = @"collection";
        MeActionModel *actionModel = self.array[indexPath.row];
        
        MeActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:action];
        
        if (!cell) {
            cell = [[MeActionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:action];
            
        }
#warning 长按手势
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
        [cell.contentView addGestureRecognizer:longPress];
        
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        //        [cell addGestureRecognizer:tap];
        
        [cell configModel:actionModel];
        
        return cell;
    } else {
        return nil;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ActionDetailViewController *actVC = [[ActionDetailViewController alloc]init];
    MeActionModel *model = self.array[indexPath.row];
    actVC.act_id = model.act_id;
    [self.navigationController pushViewController:actVC animated:YES];
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
    
    //    self.myTableView.editing = !self.myTableView.editing;
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
        MeActionModel *model = self.array[indexPath.row];
        //        NSLog(@"tiezi :%@,%@",model.pid,userid);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"method"] = @2;
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
