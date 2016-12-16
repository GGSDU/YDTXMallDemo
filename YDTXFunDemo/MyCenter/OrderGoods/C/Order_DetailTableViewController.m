//
//  Order_DetailTableViewController.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/9.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_DetailTableViewController.h"
#import "Order_Status-AddressView.h"
#import "Order_DetailMessageView.h"
#import "Order_CreatTimer_NumView.h"

#import "OrderGoodsModel.h"

@interface Order_DetailTableViewController ()

@property (nonatomic, strong) UIView *floatBottomView;//

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation Order_DetailTableViewController

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

- (UIView *)floatBottomView {
    if (!_floatBottomView) {
        _floatBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        _floatBottomView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_floatBottomView];
        
    }
    
    return _floatBottomView;
}

- (void) creatWindowView {
    //删除子视图
    [self.floatBottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray *array = [NSArray array];
    //    如果是已完成 删除订单，如果不是 取消订单 去支付
    if (self.isFinish) {
        array = @[@"删除订单"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 12;
        button.layer.borderColor = [RGB(255, 75, 0) CGColor];
        button.layer.borderWidth = 1;
        [button setTitleColor:RGB(255, 75, 0) forState:UIControlStateNormal];
        button.layer.cornerRadius = 5;
        [button setTitle:array[0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14*HeightScale];
        button.frame = CGRectMake(ScreenWidth-70*WidthScale-10, 14.5, 70, 30 );
        [self.floatBottomView addSubview:button];
        
        [button addTarget:self action:@selector(orderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }else {
        array = @[@"去支付",@"取消订单"];
        NSArray *layerColorArr = @[RGB(255, 75, 0),RGB(208, 207, 208)];
        NSArray *textColorArr = @[RGB(255, 75, 0),RGB(92, 92, 92)];
        
        for (int i = 0; i < array.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(ScreenWidth - (70*WidthScale+10)*(i+1), 14.5, 70*WidthScale, 30);
            button.titleLabel.font = [UIFont systemFontOfSize:14*HeightScale];
            [button setTitle:array[i] forState:UIControlStateNormal];
            button.tag = 10+i;
            button.layer.borderWidth = 1;
            button.layer.cornerRadius = 5;
            button.layer.borderColor = [layerColorArr[i] CGColor];
            [button setTitleColor:textColorArr[i] forState:UIControlStateNormal];
            
            [self.floatBottomView addSubview:button];
            
            [button addTarget:self action:@selector(orderBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self creatWindowView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.floatBottomView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadNewData];
    
}
- (void) loadNewData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"goods_order_id"] = self.goods_order_id;
    
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goodsOrder/orderDetail/"] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        OrderGoodsModel *model = [[OrderGoodsModel alloc]initData:responseObject[@"data"]];
        [self.dataSource addObject:model];
        NSLog(@"order detail message is :%@--------%@",responseObject,self.dataSource);
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    /*
     //订单详情
     http://test.m.yundiaoke.cn/api/goodsOrder/orderDetail/order_num/2016121317214114753534
     请求方式：GET
     参数：order_num：商品的订单号
     
     返回字段：
     goods_order_id：数据id
     goods_order_num：订单号
     images_url：商品图片
     goods_name：商品名称
     Models：商品型号
     Price：价格
     Nums:数量
     Total_price:总价格
     Courier:快递名称
     Status: -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
     create_time:下单时间
     User_name：收货人名字
     Mobile：收货人电话
     Prov：省份
     City：城市
     Area：区
     Address：详细地址
     
     */
    
}

#pragma mark  响应事件

- (void) orderBtnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 10://去支付
        {
            NSLog(@"去支付");
        }
            break;
        case 11://取消订单
        {
            NSLog(@"取消订单");
        }
            break;
        case 12:// 删除订单
        {
            NSLog(@"删除订单");
        }
            break;
            
        default:
            break;
    }
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 165*HeightScale;
    } else if(indexPath.section == 1) {
        return 224*HeightScale;
    } else {
        return 65*HeightScale;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"detail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    OrderGoodsModel *model = self.dataSource[indexPath.row];
    
    if (indexPath.section == 0) {
        
        Order_Status_AddressView *orderStatus = [[Order_Status_AddressView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 165*HeightScale) orderModel:model];
        // Configure the cell...
        [cell.contentView addSubview:orderStatus];
        
    } else if (indexPath.section == 1) {
        Order_DetailMessageView *orderDetailMessageView = [[Order_DetailMessageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 224*HeightScale) orderGoodsModel:model];
        [cell.contentView addSubview:orderDetailMessageView];
    } else if (indexPath.section == 2) {
        Order_CreatTimer_NumView *order_time_num = [[Order_CreatTimer_NumView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 65*HeightScale) orderModel:model];
        
        [cell.contentView addSubview:order_time_num];
    }
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
