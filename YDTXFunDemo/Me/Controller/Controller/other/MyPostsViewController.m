//
//  MyPostsViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/27.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MyPostsViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"
#import "SocialPostViewController.h"
#import "SocialContentViewController.h"

@interface MyPostsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@property (nonatomic, strong) NSMutableArray *moreData;
@property (nonatomic, assign) int page;

@end

static BOOL SDImageCacheOldShouldDecompressImages = YES;
static BOOL SDImagedownloderOldShouldDecompressImages = YES;

@implementation MyPostsViewController
- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
   return _AFManager;
}
- (NSArray *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableArray array];
    }
    return _dataSources;
}
- (NSMutableArray *)moreData {
    if (!_moreData) {
        _moreData = [NSMutableArray array];
        
    }
    return _moreData;
}
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self loadData];
    self.navigationItem.title = @"我的帖子";

    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
 }

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SDImageCache *canche = [SDImageCache sharedImageCache];
    SDImageCacheOldShouldDecompressImages = canche.shouldDecompressImages;
    canche.shouldDecompressImages = NO;
    
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
    
    self.title = @"我的帖子";
    self.page = 2;
    self.view.backgroundColor = [UIColor whiteColor];
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
- (void)loadData{
    self.page = 2;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    self.myTableView.userInteractionEnabled = NO;
    dic[@"page"] = @1;
    dic[@"userid"] = userid;
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/published"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"responseObject is %@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            self.dataSources = [MessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.myTableView.mj_header endRefreshing];
          
//            NSLog(@"mypost is :%@",responseObject[@"data"]);
            
            self.myTableView.userInteractionEnabled = YES;
            [self.myTableView reloadData];
        }else if([responseObject[@"status"] isEqual:@400]){
            UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SocialPostViewController *socvc = [[SocialPostViewController alloc]init];
//
                [self.navigationController pushViewController:socvc animated:YES];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否去发布" message:@"还没有发表过帖子" preferredStyle: UIAlertControllerStyleAlert];
            [alertController addAction:cancel];
            [alertController addAction:ensure];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
     
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.myTableView.mj_header endRefreshing];
        self.myTableView.mj_footer.hidden = YES;
        
        [SVProgressHUD showErrorWithStatus:@"我的帖子数据获取失败"];
    }];
    
    
}
- (void)loadMoreData {
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer beginRefreshing];
    self.myTableView.userInteractionEnabled = NO;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    dic[@"page"] = @(self.page);
    dic[@"userid"] = userid;
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/published"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqual:@200]) {
            
            self.moreData = [MessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.dataSources addObjectsFromArray:self.moreData];
            
            self.myTableView.userInteractionEnabled = YES;
            [self.myTableView reloadData];
            [self.myTableView.mj_footer endRefreshing];
            self.page ++;
  
        }else if([responseObject[@"status"] isEqual:@400]){
            self.myTableView.userInteractionEnabled = YES;
            [self.myTableView.mj_footer endRefreshingWithNoMoreData];
            self.page = 2;
//            NSLog(@"self.page = 2 ");
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"我的帖子请求失败");
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageModel *messageModel = [self.dataSources objectAtIndex:indexPath.row];

    CGFloat h = [MessageCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        MessageCell *cell = (MessageCell *)sourceCell;
        [cell configCellWithModel:messageModel indexPath:indexPath];
        
    }];
    return h;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID =@"cell";
    MessageModel *model = self.dataSources[indexPath.row];
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    [cell configCellWithModel:model indexPath:indexPath];
//    NSLog(@"ssss%@",model.pic);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SocialContentViewController* socialContentViewC = [[SocialContentViewController alloc]init];
    MessageModel *messageModel = [self.dataSources objectAtIndex:indexPath.row];
    socialContentViewC.c_id = messageModel.c_id;
    [self.navigationController pushViewController:socialContentViewC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}
#warning 删除
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
        MessageModel *model = self.dataSources[indexPath.row];
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"method"] = @5;
        dic[@"userid"] = userid;
        dic[@"pid"] = model.c_id;
        [self.AFManager POST:[postHttp stringByAppendingString:@"api/user/myDelete"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"我的帖子删除成功");
            [self.dataSources removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.myTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"我的帖子删除失败");
        }];

    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
