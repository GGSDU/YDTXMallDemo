//
//  LogisticsTableViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "LogisticsTableViewController.h"
#import "LogisticsTableViewCell.h"

#import "LogisticsHeaderView.h"


@interface LogisticsTableViewController ()

@property (strong, nonatomic) AFHTTPSessionManager *AFManager;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *dataInfo;

@end

@implementation LogisticsTableViewController

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)dataInfo {
    if (!_dataInfo) {
        _dataInfo = [NSMutableArray array];
    }
    return _dataInfo;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"查看物流";
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    [self loadNewData];
}

- (void) loadNewData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"goods_order_id"] = @17;
    
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goodsOrder/orderLogistics/"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        LogisticsModel *model = [[LogisticsModel alloc]initData:responseObject[@"data"]];
        [self.dataSource addObject:model];
        
        for (NSDictionary *dic in model.dataInfo) {
            LogisticsDetailModel *detailModel = [[LogisticsDetailModel alloc]initData:dic];
            [self.dataInfo addObject:detailModel];
        }
        [self.tableView reloadData];
        
        
        NSLog(@"-=-=-=-=-=-::%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"哎呀，出错了" ];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        return 0;
    } else return self.dataInfo.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 0;
    } else return 63*HeightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    
    LogisticsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[LogisticsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    LogisticsDetailModel *detailModel = self.dataInfo[indexPath.row];
    
//    当数据不只有一条的时候
    if (self.dataInfo.count > 1) {
        
        
        if (indexPath.row == 0) {
//            如果是第一条数据
            [cell getDetailData:detailModel isFirst:YES isLast:NO];
        } else if (indexPath.row == self.dataInfo.count-1) {
//            如果是最后一条数据
            [cell getDetailData:detailModel isFirst:NO isLast:YES];
        }
        else {
//            不是第一和最后一条数据
            [cell getDetailData:detailModel isFirst:NO isLast:NO];
        }
 
    }
//    当数据只有一条的时候
    else {
        [cell getDetailData:detailModel isFirst:YES isLast:YES];
    }
    
    
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 90*HeightScale;
    }else return 45*HeightScale;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    return @"标题";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        LogisticsHeaderView *logisticsView = [[LogisticsHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 90*HeightScale)];
        if (self.dataSource.count>0) {
            
            LogisticsModel *model = self.dataSource[section];
            
            logisticsView.imageURL = self.imageURL;
            [logisticsView getDataReloadView:model];

        }
        
         return logisticsView;
    }else {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45*HeightScale)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(12*WidthScale, 0, ScreenWidth-12*WidthScale, 45*HeightScale)];
        label.text = @"物流信息";
        label.textColor = [UIColor blackColor];
        [view addSubview:label];
     
        return view;
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
