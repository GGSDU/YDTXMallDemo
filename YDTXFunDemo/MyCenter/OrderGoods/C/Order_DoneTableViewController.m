//
//  Order_ActionTableViewController.m
//  OrderForGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.


#import "Order_DoneTableViewController.h"
#import "OrderTableViewCell.h"

#import "Order_DetailTableViewController.h"

#import "LogisticsTableViewController.h"

#import "OrderListModel.h"

@interface Order_DoneTableViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;//

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源



@end

@implementation Order_DoneTableViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithDisplayP3Red:238.0 / 255.0 green:238.0 / 255.0 blue:238.0 / 255.0 alpha:1];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self loadNewData];
    
    
}
/*
 //订单列表
 http://test.m.yundiaoke.cn/api/goodsOrder/ordermyList/userid/72/page/2
 请求方式：GET
 参数：userid：用户id，page：分页
 返回字段：
 goods_order_id：数据id
 user_id:用户id
 goods_id：商品id
 images_url：商品图片
 goods_name：商品名称
 goods_model_id:商品型号id
 Price：价格
 Nums:数量
 Total_price:总价格
 Status: -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
 
 
 */
- (void)loadNewData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = @"72";
    
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goodsOrder/ordermyList/"] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"order list is :%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            OrderListModel *model = [[OrderListModel alloc]initData:dic];
            [self.dataSource addObject:model];
            
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"order list responsed error");
        [self.tableView reloadData];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 83*HeightScale+(45+40)*HeightScale;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    OrderListModel *model = self.dataSource[indexPath.section];
    
    if (!cell) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model];
        cell.delegate = self;
    }
    
    // Configure the cell...
    
    return cell;
}


#pragma mark --tableView header view height and view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
     return 10*HeightScale;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 96*HeightScale)];
//        backGroundView.backgroundColor = [UIColor whiteColor];
//        
//        //    47
//        NSArray *notSelect = @[@"已完成未选中",@"待付款未选中",@"待收货未选中",@"退款未选中"];
//        NSArray *selected = @[@"已完成",@"待付款",@"待收货",@"退款"];
//        
//        CGFloat width = ScreenWidth/4;
//        
//        for (int i = 0; i<4; i++) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(width*i, 0, width, backGroundView.frame.size.height);
//            button.tag = 10+i;
//            button.selected = NO;
//            button.titleLabel.font = [UIFont systemFontOfSize:12*HeightScale];
//            
//            //        标题
//            //        [button setTitle:notSelect[i] forState:UIControlStateNormal];
//            
//            [button setTitle:selected[i] forState:UIControlStateNormal];
//            //        字体颜色
//            [button setTitleColor:[UIColor colorWithDisplayP3Red:95.0 / 255.0 green:95.0 / 255.0 blue:95.0 / 255.0 alpha:1] forState:UIControlStateNormal];
//            [button setTitleColor:[UIColor colorWithDisplayP3Red:255.0 / 255.0 green:146.0 / 255.0 blue:2.0 / 255 alpha:1] forState:UIControlStateSelected];
//            
//            
//            
//            //        图片
//            [button  setImage:[UIImage imageNamed:notSelect[i]] forState:UIControlStateNormal];
//            [button setImage:[UIImage imageNamed:selected[i]] forState:UIControlStateSelected];
//            
//            
//            
//            [button addTarget:selected action:@selector(typeBtn:) forControlEvents:UIControlEventTouchUpInside];
//            
//            
//            
//            //    / button标题的偏移量
//            button.titleEdgeInsets = UIEdgeInsetsMake(button.imageView.frame.size.height+5, -button.imageView.bounds.size.width, 0,0);
//            //    // button图片的偏移量
//            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.titleLabel.frame.size.width/2,button.titleLabel.frame.size.height+5, -button.titleLabel.frame.size.width/2);
//            
//            
//            [backGroundView addSubview:button];
//        }
//        
//        
//        
//        return backGroundView;
//        
//    } return nil;
//    
//}
//

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderListModel *model = self.dataSource[indexPath.section];
    
    Order_DetailTableViewController *detailVC = [[Order_DetailTableViewController alloc]init];
    
    if ([model.status isEqualToString:@"1"]) {
        detailVC.isFinish = YES;
    } else detailVC.isFinish = NO;
    
    
    detailVC.goods_order_id = model.goods_order_id;
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)typeBtn:(UIButton *)sender {
    NSInteger index = sender.tag - 10;
    sender.selected = !sender.selected;
    switch (index) {
        case 0:
            
            break;
            
        case 1:
            break;
            
            
        case 2:
            break;
            
            
        case 3:
            
            break;
            
        default:
            break;
            
    }
    NSLog(@"clicked typebtn tag is :%ld",(long)index);
}

#pragma orderTableViewCell delegate
- (void)orderTableViewCell:(OrderTableViewCell *)orderTableViewCell didClickDelectedBtn:(UIButton *)btn tag:(NSInteger)tag{
    NSLog(@"success delect ordrtablecell tag is :%ld",(long)tag);
    if ([btn.titleLabel.text isEqualToString:@"查看物流"]) {
        LogisticsTableViewController *logistics = [[LogisticsTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        [self.navigationController pushViewController:logistics animated:YES];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
