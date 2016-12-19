//
//  ViewController.m
//  OrderForGoods
//
//  Created by 舒通 on 2016/12/7.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "Order_ActionViewController.h"

#import "OrderTableViewCell.h"

#import "Order_DetailTableViewController.h"

#import "LogisticsTableViewController.h"

#import "OrderListModel.h"

#import "Order_HeaderTypeView.h"

#import "OrderDrawBackViewController.h"

@interface Order_ActionViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,OrderTableViewCellDelegate,Order_headerTypeViewDelegate>




@property (nonatomic, strong) UITableView *tableview;

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;//

@property (nonatomic, strong) NSMutableArray *dataSource;//数据源

@property (nonatomic, strong) Order_HeaderTypeView *headerType;

@end

@implementation Order_ActionViewController
#pragma mark  lazy

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"订单";
    
    self.tabBarController.tabBar.hidden = YES;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
//    [self loadNewData];
    
}



- (void)loadNewData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"userid"] = @"72";
//    param[@"page"] = @2;
    [self.AFManager GET:[postHttp stringByAppendingString:@"api/goodsOrder/ordermyList/"] parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"order list is :%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"data"]) {
            
            OrderListModel *model = [[OrderListModel alloc]initData:dic];
            [self.dataSource addObject:model];
            
        }
        [self.tableview reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"order list responsed error");
        [self.tableview reloadData];
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.dataSource.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return HeightScale*96;
    } else {
        return 83*HeightScale+(45+40)*HeightScale;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *defaultid = @"default";
    static NSString *cellid = @"cellid";
    NSLog(@"indexpath section is %ld",indexPath.section);
     if (indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultid];
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
         OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
         OrderListModel *model = self.dataSource[indexPath.section-1];
         NSLog(@"model status is: -- %@",model.status);
         if (!cell) {
             cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid model:model];
             cell.delegate = self;
         }
         
         [cell updataViews:model];
         // Configure the cell...
         
         return cell;
         
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
    OrderListModel *model = self.dataSource[indexPath.section];
    
    Order_DetailTableViewController *detailVC = [[Order_DetailTableViewController alloc]init];
    
    if ([model.status isEqualToString:@"1"]) {
        detailVC.isFinish = YES;
    } else detailVC.isFinish = NO;
    
    
    detailVC.goods_order_id = model.goods_order_id;
    
    
    [self.navigationController pushViewController:detailVC animated:YES];
}



#pragma orderTableViewCell delegate
- (void)orderTableViewCell:(OrderTableViewCell *)orderTableViewCell didClickDelectedBtn:(UIButton *)btn tag:(NSInteger)tag{
    NSLog(@"success delect ordrtablecell tag is :%ld",(long)tag);
    if ([btn.titleLabel.text isEqualToString:@"查看物流"]) {
        LogisticsTableViewController *logistics = [[LogisticsTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        [self.navigationController pushViewController:logistics animated:YES];
        
    } else if ([btn.titleLabel.text isEqualToString:@"退款"]) {
        OrderDrawBackViewController *drawBackGvc = [[OrderDrawBackViewController alloc]init];
        [self.navigationController pushViewController:drawBackGvc animated:YES];
    }
    
}

#pragma mark orderHeaderView delegate 
- (void)didClickBtn:(UIButton *)btn tag:(NSInteger)tag {
    
    [self loadNewData];
    
    NSLog(@"receivery tag is %ld",tag);
    
//    [self.headerType addObserver:self forKeyPath:@"tag" options:NSKeyValueObservingOptionNew
//     | NSKeyValueObservingOptionOld context:nil];
    
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    // 判断是否为self.myKVO的属性“num”:
    if([keyPath isEqualToString:@"tag"]) {
        // 响应变化处理：UI更新（label文本改变）
       
        
        //change的使用：上文注册时，枚举为2个，因此可以提取change字典中的新、旧值的这两个方法
        NSLog(@"\\noldnum:%@ newnum:%@",[change valueForKey:@"old"],
              [change valueForKey:@"new"]); 
    }
}

- (void) pan:(UIPanGestureRecognizer *) panGR {
    CGPoint point = [panGR translationInView:self.tableview];
    [panGR setTranslation:CGPointZero inView:self.tableview];
    NSLog(@"point %f ----- %f",point.x,point.y);
    if (point.x > 100) {
        self.tableview.center = CGPointMake(self.tableview.centerX+point.x, self.tableview.y);
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
