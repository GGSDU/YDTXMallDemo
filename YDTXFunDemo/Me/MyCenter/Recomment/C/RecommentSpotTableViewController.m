//
//  RecommentSpotTableViewController.m
//  YDTX
//
//  Created by 舒通 on 2016/12/22.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "RecommentSpotTableViewController.h"

#import "RecommentSpotTableViewCell.h"
#import "RecommentSpotModel.h"

@interface RecommentSpotTableViewController ()


@property (strong, nonatomic) AFHTTPSessionManager *AFManager;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation RecommentSpotTableViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refreshAction];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getNewData];
}


- (void)refreshAction {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];

}


- (void) getNewData {
    
    /*
     //    http://test.m.yundiaoke.cn/api/partner/myRecommend/uid/69/method/1
     //    请求方式  GET
     //    参数  uid  用户id    method  1为塘口   2为活动
     
     
     */
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = userid;
    param[@"method"] = @1;
    
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/partner/myRecommend/"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"status"] isEqual:@200]) {

            for (NSDictionary *dic in responseObject[@"data"]) {
                
                RecommentSpotModel *model = [[RecommentSpotModel alloc]initData:dic];
                [self.dataSource addObject:model];
            }
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"哎呀，没有数据"];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
        NSLog(@"recommentSpot is:%@",responseObject[@"data"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"哎呀，数据出错了"];
        [self.tableView.mj_header endRefreshing];
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100*HeightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    
    RecommentSpotTableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[RecommentSpotTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    RecommentSpotModel *model = self.dataSource[indexPath.row];
    
    
    
    [cell getDataReloadView:model];
    
    // Configure the cell...
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
