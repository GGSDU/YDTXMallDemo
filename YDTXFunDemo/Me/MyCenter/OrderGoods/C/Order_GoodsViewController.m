//
//  ViewController.m
//  OrderForGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_GoodsViewController.h"

#import "OrderTableViewCell.h"

#import "Order_DetailTableViewController.h"

#import "LogisticsTableViewController.h"

#import "OrderListModel.h"

#import "Order_HeaderTypeView.h"

#import "OrderDrawBackViewController.h"

#import "OrderUnOwnView.h"

#import "OrderPayStatus.h"

#import "ActionPayOnlineViewController.h"

#import "FindCouponStatus.h"

@interface Order_GoodsViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate,Order_headerTypeViewDelegate,OrderPayStatusDelegate>




@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;//

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源
@property (nonatomic, strong) NSMutableArray *moreData;

@property (nonatomic, strong) Order_HeaderTypeView *headerType;


@property (nonatomic, assign) NSInteger selecteIndex;
@property (nonatomic, strong) OrderUnOwnView *unOwnView;

@property (nonatomic, assign) int page;

@end

@implementation Order_GoodsViewController
#pragma mark  lazy

- (OrderUnOwnView *)unOwnView {
    if (!_unOwnView) {
        _unOwnView = [[OrderUnOwnView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-(96+40)*HeightScale) imageName:@"OrderUnOwn" labelText:@"您还没购买过商品哦!"];
    }
    return _unOwnView;
}

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-40*HeightScale) style:UITableViewStyleGrouped];
        
        //        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        //        [_tableview addGestureRecognizer:pan];
        
        [self.view addSubview:_tableview];
    }
    return _tableview;
}
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
- (NSMutableArray *)moreData {
    if (!_moreData) {
        _moreData = [NSMutableArray array];
    }
    return _moreData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"订单";
    
    self.page = 1;
    self.tabBarController.tabBar.hidden = YES;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.selecteIndex = 0;
            [self refresh];
    
}

- (void)refresh {
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tableview.mj_header.automaticallyChangeAlpha = YES;
    [self.tableview.mj_header beginRefreshing];
    
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData {
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = userid; //@
    param[@"status"] = @(self.selecteIndex);
    param[@"page"] = @(self.page);
    NSString *url = nil;

        url = @"api/goodsOrder/ordermyList/";
    
    
    [self.AFManager GET:[postHttp stringByAppendingString:url] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.dataSource removeAllObjects],self.dataSource = nil;
        NSLog(@"param is :%@",param);
        NSLog(@"order list is :%@",responseObject);

        if ([responseObject[@"status"] isEqual:@200]) {
            
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                OrderListModel *model = [[OrderListModel alloc]initData:dic];
                [self.dataSource addObject:model];
            }
        } else if ([responseObject[@"status"] isEqual:@400]) {
            
        }
        [self.tableview.mj_header endRefreshing];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"order list responsed error");
        [self.tableview.mj_header endRefreshing];
        [self.dataSource removeAllObjects],self.dataSource = nil;
        [self.tableview reloadData];
    }];
}

- (void) loadMoreData {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = userid; //@
    param[@"status"] = @(self.selecteIndex);
    param[@"page"] = @(++self.page);
    NSString *url = nil;

        url = @"api/goodsOrder/ordermyList/";
    
    [self.AFManager GET:[postHttp stringByAppendingString:url] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"param is :%@",param);
        NSLog(@"order list is :%@",responseObject);
        
       
        
        if ([responseObject[@"status"] isEqual:@200]) {
            
//            [self.dataSource removeAllObjects],self.dataSource = nil;
            [self.moreData removeAllObjects], self.moreData = nil;
            
            for (NSDictionary *dic in responseObject[@"data"]) {
                
                OrderListModel *model = [[OrderListModel alloc]initData:dic];
                [self.moreData addObject:model];
                
            }
            [self.dataSource addObjectsFromArray:self.moreData];
            
        } else if ([responseObject[@"status"] isEqual:@400]) {
            
            self.page--;
            [self.tableview.mj_footer endRefreshingWithNoMoreData];
            
        }
        
        [self.tableview.mj_footer endRefreshing];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"order list responsed error");
        self.page--;
        [self.tableview.mj_footer endRefreshing];
        [self.tableview reloadData];
    }];

}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (self.dataSource.count>0) {
        return self.dataSource.count + 1;
    } else {
        return self.dataSource.count + 2;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexPath section count is %ld",indexPath.section);
    if (indexPath.section == 0) {
        return HeightScale*96;
    } else {
        if (self.dataSource.count>0) {
            
            return 83*HeightScale+(45+40)*HeightScale;
        } else {
            
            return ScreenHeight-96*HeightScale-40*HeightScale;
        }
        
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *defaultid = @"default";
    static NSString *cellid = @"cellid";
    static NSString *unOwn = @"UnOwn";
    NSLog(@"indexpath section is %ld",indexPath.section);
    
    //    if (self.dataSource.count > 0) {
    
    if (indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultid];
            
            self.headerType = [[Order_HeaderTypeView alloc]initWithFrame:CGRectMake(0, 0, ScreenHeight, 96*HeightScale)];
            NSLog(@"out delegate %@",self.headerType);
            self.headerType.delegate = self;
            [cell.contentView addSubview:self.headerType];
            
            [self.headerType firstClickButton];
        }
        
        return cell;
        
    } else {
        
        if (self.dataSource.count>0) {
            OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

            
            OrderListModel *model = self.dataSource[indexPath.section-1];
            NSLog(@"model status is: -- %@",model.status);
            if (!cell) {
                cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
                cell.delegate = self;
            }

            
            [cell updataViews:model];

            
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:unOwn];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:unOwn];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            [cell.contentView addSubview:self.unOwnView];
            return cell;
            
        }
        
    }
    
}


#pragma mark --tableView header view height and view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10*HeightScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section != 0) {
        if (self.dataSource.count > 0) {
            
            OrderListModel *model = self.dataSource[indexPath.section-1];
            NSLog(@"model goods id is :%@",model.goods_order_id);
            
            Order_DetailTableViewController *detailVC = [[Order_DetailTableViewController alloc]init];
            
            if ([model.status isEqualToString:@"1"]) {
                detailVC.isFinish = YES;
            } else detailVC.isFinish = NO;
            
            
            detailVC.goods_order_id = model.goods_order_id;
            
            
            [self.navigationController pushViewController:detailVC animated:YES];
            
        }
    }
}



#pragma orderTableViewCell delegate
- (void)orderTableViewCell:(OrderTableViewCell *)orderTableViewCell didClickDelectedBtn:(UIButton *)btn tag:(NSInteger)tag goods_order_id:(NSString *)goods_order_id {
    
    NSLog(@"success delect ordrtablecell tag is :%ld",(long)tag);
    if ([btn.titleLabel.text isEqualToString:@"查看物流"]) {
        LogisticsTableViewController *logistics = [[LogisticsTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        logistics.goods_order_id = orderTableViewCell.orderListModel.goods_order_id;
        logistics.imageURL = orderTableViewCell.orderListModel.images_url;
        
        [self.navigationController pushViewController:logistics animated:YES];
        
    } else if ([btn.titleLabel.text isEqualToString:@"退款"]) {
        
        OrderDrawBackViewController *drawBackGvc = [[OrderDrawBackViewController alloc]init];
        drawBackGvc.order_id = orderTableViewCell.orderListModel.goods_order_id;
        drawBackGvc.goods_id = orderTableViewCell.orderListModel.goods_id;
        drawBackGvc.goods_name = orderTableViewCell.orderListModel.goods_name;
        drawBackGvc.total_price = orderTableViewCell.orderListModel.total_price;
        drawBackGvc.price = orderTableViewCell.orderListModel.price;
//        goods_model_id
//        nums
        drawBackGvc.nums = orderTableViewCell.orderListModel.nums;
        drawBackGvc.goods_model_id = orderTableViewCell.orderListModel.goods_model_id;
        
        
        
        [self.navigationController pushViewController:drawBackGvc animated:YES];
    } else if ([btn.titleLabel.text isEqualToString:@"继续支付"]) {
//        OrderGoodsModel *model = self.dataSource[0];
        FindCouponStatus *couponStatus = [[FindCouponStatus alloc]init];
//        float couponPrices = [[couponStatus data:orderTableViewCell.orderListModel.goods_order_id] floatValue];
        [couponStatus dataParam:orderTableViewCell.orderListModel.goods_order_id successBlock:^(NSString *text) {
            
            ActionPayOnlineViewController *payOnline = [[ActionPayOnlineViewController alloc]init];
            
            payOnline.couponPrice = [text floatValue];//优惠券减免价格
            
            NSLog(@"*********%f",payOnline.couponPrice);
            
            payOnline.orderParamsDic = @{@"tradeNum":orderTableViewCell.orderListModel.goods_order_id,@"subject":orderTableViewCell.orderListModel.goods_name,@"sumPrice":orderTableViewCell.orderListModel.total_price};
            
            [self.navigationController pushViewController:payOnline animated:YES];
        }];
        
//        NSLog(@"=======:%f,%@",couponPrices,[couponStatus data:orderTableViewCell.orderListModel.goods_order_id]);
       

        
    } else if ([btn.titleLabel.text isEqualToString:@"取消订单"]) {
        
        [self cancelOrder:goods_order_id url:@"api/goodsOrder/orderCancel"];
        
    } else if ([btn.titleLabel.text isEqualToString:@"确认收货"]) {
        
        //确认收货
//    http://test.m.yundiaoke.cn/api/goodsOrder/orderConfirm/goods_order_id/17
//        请求方式：GET
//        参数：goods_order_id：订单id
//        200：成功，400：失败，401：数据不合法，403：非法参数
        NSLog(@"确认收货 orderid is :%@",goods_order_id);
        [self doneOrder:goods_order_id url:@"api/goodsOrder/orderConfirm"];
        
    }
    
}

#pragma mark orderHeaderView delegate
- (void)didClickBtn:(UIButton *)btn tag:(NSInteger)tag {
    
//    [self loadNewData];
    
    //    self.selecteIndex = tag -10;
    //    NSLog(@"receivery tag is %ld",tag);
    
    //    -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
    
    //    已完成 待付款 待收货 退款
    
    switch (tag - 10) {
        case 0:
            
            self.selecteIndex = 2;
            
            break;
        case 1://待付款
            
            self.selecteIndex = 0;
            
            break;
        case 2:
            
            self.selecteIndex = 1;
            
            break;
        case 3:
            
            self.selecteIndex = 3;
            
            break;
            
        default:
            break;
    }
    
    
    [self loadNewData];
    
    
    
}


- (void) pan:(UIPanGestureRecognizer *) panGR {
    CGPoint point = [panGR translationInView:self.tableview];
    [panGR setTranslation:CGPointZero inView:self.tableview];
    NSLog(@"point %f ----- %f",point.x,point.y);
    if (point.x > 100) {
        self.tableview.center = CGPointMake(self.tableview.centerX+point.x, self.tableview.y);
    }
    
    
}


/*
 //取消订单
 http://test.m.yundiaoke.cn/api/goodsOrder/orderCancel/userid/72/goods_order_id/9
 请求方式：GET
 参数：userid：用户id，goods_order_id：订单id
 200：成功，400：失败，401：数据不合法，403：非法参数

 */

- (void)cancelOrder:(NSString *)orderID url:(NSString *)url {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = @"72";
    params[@"goods_order_id"] =  orderID;
    
    OrderPayStatus *orderPayStatus = [[OrderPayStatus alloc]init];
    [orderPayStatus orderPayCancel:params url:url];
    orderPayStatus.delegate = self;
    
    

}

- (void)doneOrder:(NSString *)orderID url:(NSString *)url {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"goods_order_id"] =  orderID;
    
    OrderPayStatus *orderPayStatus = [[OrderPayStatus alloc]init];
    [orderPayStatus orderPayDone:params url:url];
    orderPayStatus.delegate = self;

}

- (void)operationStatus:(BOOL)status {
    if (status) {
        [self loadNewData];
    }
}


#pragma mark 查询优惠券是否已使用


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
