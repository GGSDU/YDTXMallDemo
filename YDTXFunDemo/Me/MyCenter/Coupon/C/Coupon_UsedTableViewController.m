//
//  Coupon_UnUsedTableViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/15.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "Coupon_UsedTableViewController.h"
#import "CouponTableViewCell.h"

#import "CouponModel.h"
#import "OrderUnOwnView.h"

@interface Coupon_UsedTableViewController ()
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *moreData;
@property (strong, nonatomic) AFHTTPSessionManager *AFManager;
@property (strong, nonatomic) OrderUnOwnView *unOwnView;
@property (assign, nonatomic) int page;

@end

@implementation Coupon_UsedTableViewController
#pragma mark lazy



- (OrderUnOwnView *)unOwnView {
    if (!_unOwnView) {
        _unOwnView = [[OrderUnOwnView alloc]initWithFrame:CGRectMake(0, 40*HeightScale, ScreenWidth, ScreenHeight-(40)*HeightScale) imageName:@"couPonNoOwn" labelText:@"暂无优惠券"];
    }
    return _unOwnView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}
- (NSMutableArray *)moreData {
    if (!_moreData) {
        _moreData = [NSMutableArray array];
    }
    return _moreData;
}

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    
    self.tableView = [[UITableView alloc]initWithFrame:[[UIScreen mainScreen]bounds] style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refresh];
    
}

- (void)refresh {
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    // 设置footer 上拉加载
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmoreData)];
    [GiFHUD showWithOverlay];
}


- (void)loadNewData {
    
    self.page = 1;
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"method"] = @0;
    params[@"uid"] = userid;
    params[@"page"] = @(self.page);
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goods/couponlist/"] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self.dataSource removeAllObjects],self.dataSource = nil;
        
        NSLog(@"coupon data is :%@",responseObject);
        if ([responseObject[@"status"] isEqual:@200]) {
            for (NSDictionary *dic in responseObject[@"data"]) {
                CouponModel *model = [[CouponModel alloc]initData:dic];
                [self.dataSource addObject:model];
                
                
            }
            
            
        }else {
            [SVProgressHUD showSuccessWithStatus:@"您尚未拥有该优惠券"];
        }
        
        [GiFHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [GiFHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        [SVProgressHUD showErrorWithStatus:@"哎呀，数据出错了"];
    }];
}
- (void)loadmoreData {
    {
        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"method"] = @0;
        params[@"uid"] = userid;
        params[@"page"] = @(++self.page);
        [self.AFManager GET:[postHttp stringByAppendingString:@"api/goods/couponlist/"] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSLog(@"coupon data is :%@",responseObject);
            if ([responseObject[@"status"] isEqual:@200]) {
                [self.moreData removeAllObjects],self.moreData = nil;
                
                for (NSDictionary *dic in responseObject[@"data"]) {
                    CouponModel *model = [[CouponModel alloc]initData:dic];
                    [self.moreData addObject:model];
                    
                    
                }
                [self.dataSource addObjectsFromArray:self.moreData];
//                [self.tableView.mj_footer endRefreshing];
                
            } else if ([responseObject[@"status"] isEqual:@400]) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            else {
                [SVProgressHUD showSuccessWithStatus:@"您尚未拥有该优惠券"];
            }
            [GiFHUD dismiss];
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self.tableView.mj_footer endRefreshing];
            self.page--;
            [GiFHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"哎呀，数据出错了"];
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    NSInteger count = self.dataSource.count > 0 ? self.dataSource.count : 1;
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = self.dataSource.count > 0 ? 90*HeightScale : ScreenHeight-40*HeightScale;
    
    return count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSInteger count = self.dataSource.count > 0 ? 10*HeightScale : 1;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    static NSString *unOwn = @"unOwn";
    
    if (self.dataSource.count > 0) {
        CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[CouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
//        [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        CouponModel *model = self.dataSource[indexPath.section];
        [cell upData:cell couponModel:model];
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unOwn];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unOwn];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = RGB(249, 249, 249);
        
        [cell.contentView addSubview:self.unOwnView];
        return cell;
    }

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
