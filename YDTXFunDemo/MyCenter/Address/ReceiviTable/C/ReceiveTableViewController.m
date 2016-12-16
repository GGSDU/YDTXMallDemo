//
//  ReceiveTableViewController.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "ReceiveTableViewController.h"
#import "ReceiveTableViewCell.h"
#import "AddDetailMessageViewController.h"
#import "AddressListModel.h"


@interface ReceiveTableViewController ()<UITableViewDelegate,UITableViewDataSource,ReceiveTableViewCellDelegate>

@property (nonatomic, assign) BOOL isClickManager;//判断是否点击管理按钮
@property (nonatomic, strong) UIView *backGroundView;//悬浮底部视图
@property (nonatomic, strong) UIButton *addAddressBtn;//添加地址按钮
@property (nonatomic, strong) UIButton *allSelectBtn;//全选按钮
@property (nonatomic, strong) UIButton *delectedBtn;//删除按钮



@property (nonatomic, strong) AFHTTPSessionManager *AFManager;//
#pragma mark 数据源
@property (nonatomic, strong) NSMutableArray *dataSource;//所有的数据
@property (nonatomic, strong) NSMutableArray *delectArr;//选中的删除数据




@end

@implementation ReceiveTableViewController
- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}


#pragma mark lazy data source
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        
    }
    return _dataSource;
}
- (NSMutableArray *)delectArr {
    if (!_delectArr) {
        _delectArr = [NSMutableArray array];
    }
    return _delectArr;
}

#pragma mark lazy view control
- (UIView *)backGroundView {
    if (!_backGroundView) {
        _backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-49, ScreenWidth, 49)];
        _backGroundView.tag = 10;
        _backGroundView.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication].keyWindow addSubview:_backGroundView];
    }
    return _backGroundView;
}
- (UIButton *)addAddressBtn {
    if (!_addAddressBtn) {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAddressBtn.frame = CGRectMake(0, 0, ScreenWidth, 49);
        [_addAddressBtn setTitle:@"添加地址" forState:UIControlStateNormal];
        _addAddressBtn.backgroundColor = [UIColor colorWithDisplayP3Red:56.0 / 255.0 green:190.0/ 255.0 blue:237.0 / 255.0 alpha:1];
        [_addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
        
        [_addAddressBtn addTarget:self action:@selector(pushAddDetailVC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}

- (UIButton *)allSelectBtn {
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectBtn.frame = CGRectMake(0, 0, 100, 49);
        [_allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
        
        [_allSelectBtn setImage:[UIImage imageNamed:@"circle"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"DefaultImg"] forState:UIControlStateSelected];
        //button图片的偏移量，距上左下右分别(10, 10, 10, 75)像素点
        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(17, 10, 17, 75);
        //button标题的偏移量，这个偏移量是相对于图片的
        _allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        [_allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _allSelectBtn.backgroundColor = [UIColor colorWithDisplayP3Red:56.0 / 255.0 green:190.0/ 255.0 blue:237.0 / 255.0 alpha:1];
        [self.backGroundView addSubview:_allSelectBtn];
        [_allSelectBtn addTarget:self action:@selector(allSelectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _allSelectBtn;
}

- (UIButton *)delectedBtn {
    if (!_delectedBtn) {
        _delectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delectedBtn.frame = CGRectMake(ScreenWidth-100, 0, 100, 49);
        [_delectedBtn setTitle:@"删除" forState:UIControlStateNormal];
        _delectedBtn.backgroundColor = [UIColor colorWithDisplayP3Red:255 / 255 green:75 / 255 blue:1 / 255 alpha:1];
        [_delectedBtn addTarget:self action:@selector(delectedBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _delectedBtn;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
#pragma mark 移除视图
    [[[UIApplication sharedApplication].keyWindow viewWithTag:10] removeFromSuperview];
    [self.backGroundView removeFromSuperview];
    self.backGroundView = nil;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
#pragma mark 添加视图
    [self addAddressView];
    [self setupRefresh];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"收货地址";
    self.isClickManager = NO;
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithDisplayP3Red:234.0 / 255.0 green:234.0 / 255.0 blue:234.0 / 255.0 alpha:1];
    //    支持同时选择多行
    self.tableView.allowsMultipleSelectionDuringEditing = YES;


    [self managerBtn];
    
}
#pragma mark loadData
- (void)setupRefresh {
    // 展示header  下拉触发loadNewData
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // 进入刷新状态 自动触发loadNewData
    [self.tableView.mj_header beginRefreshing];
    
}

- (void) loadNewData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = @"65";
    
    [self.AFManager GET:@"http://test.m.yundiaoke.cn/api/user/listAddress/" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"帖子列表请求成功：%@",responseObject);
        self.dataSource = [AddressListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"帖子列表请求失败：%@",error);
    }];

}
#pragma mark 管理按钮
- (void)managerBtn {
    
    
    
    UIBarButtonItem *managerBtn = [[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(managerBtn:)];
    managerBtn.tintColor = [UIColor colorWithDisplayP3Red:100.0 / 255 green:200.0 / 255 blue:238.0 / 255 alpha:1];
    
    self.navigationItem.rightBarButtonItem = managerBtn;
}




#pragma mark ---添加地址按钮
- (void) addAddressView {
   [self.backGroundView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];//删除子视图
    
//    选中管理按钮切换为全选状态
    if (self.isClickManager == YES) {
       
        
       [self.backGroundView addSubview:self.allSelectBtn];
        [self.backGroundView addSubview:self.delectedBtn];
        

    }else {

//        没有选中状态为添加按钮状态
        [self.backGroundView addSubview:self.addAddressBtn];
    }
    
}
#pragma mark 添加addaction
- (void)pushAddDetailVC:(UIButton *)sender {
    AddDetailMessageViewController *addDetailVc = [[AddDetailMessageViewController alloc]init];
    addDetailVc.title = @"添加收货地址";
    [self.navigationController pushViewController:addDetailVc animated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80*HeightScale;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressListModel *model = self.dataSource[indexPath.row];
    
    
    static NSString *cellid = @"receivecell";
    ReceiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (!cell) {
        cell = [[ReceiveTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid addressModel:model];
        cell.delegate = self;
    }
//如果从个人中心进入 不显示图片
    if (self.isMe) { // 个人中心入口
        if (self.isClickManager == YES) {
            
            [cell setStatus:self.isMe compile:self.isClickManager select:YES];
        } else {
            [cell setStatus:self.isMe compile:self.isClickManager select:NO];
        }

    }else { // 商城入口
        if (self.isClickManager) {
            [cell setStatus:self.isMe compile:self.isClickManager select:YES];
        } else {
            [cell setStatus:self.isMe compile:self.isClickManager select:NO];
            if ([model.status isEqualToString:@"1"]) {
                [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                [cell setStatus:self.isMe compile:self.isClickManager select:YES];
            }
        }
        


    }
    
    
    return cell;
}

#pragma mark  编辑收货地址delegate
- (void)didClickedEdit:(UIImageView *)editImg addressID:(NSString *)addID status:(NSString *)status{
    NSLog(@"开始编辑");
    
    
    AddDetailMessageViewController *addDetailVc = [[AddDetailMessageViewController alloc]init];
    addDetailVc.isEdit = YES;
    addDetailVc.addressID = addID;
    addDetailVc.title = @"修改收货地址";
    [self.navigationController pushViewController:addDetailVc animated:YES];
    
    
    
    
    
}

#pragma  mark 管理事件 
- (void)managerBtn:(UIBarButtonItem *)sender {
    //    是否为选中状态
    self.isClickManager = !self.isClickManager;//是否选中
    if ([sender.title isEqualToString:@"管理"]) {
        sender.title = @"保存";
    }else {
        sender.title = @"管理";
        [self loadNewData];
    }
    
//    清除删除数组中所有的元素
    [self.delectArr removeAllObjects];
    
    
//    进入管理状态之前 把之前的选中状态取消
    for (int i = 0; i<self.dataSource.count; i++) {
        
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        ReceiveTableViewCell *cell = (ReceiveTableViewCell *)[self.tableView cellForRowAtIndexPath:indexpath];

        [cell setStatus:self.isMe compile:self.isClickManager select:NO];
    }
    

//    添加地址按钮
    [self addAddressView];
    
//    把全选的状态改变为正常状态
    self.allSelectBtn.selected = NO;
    

    
}

#pragma mark  全选事件
- (void)allSelectedBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (self.isClickManager == YES) {
        for (int i = 0; i < self.dataSource.count; i++) {
            
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            ReceiveTableViewCell *cell = (ReceiveTableViewCell *)[self.tableView cellForRowAtIndexPath:indexpath];
            
            if (sender.selected == YES) {
                [self.tableView selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionTop];

                
                [self.delectArr addObjectsFromArray:self.dataSource];
                
                [cell setStatus:self.isMe compile:self.isClickManager select:YES];

                
                
                
            }else {
                [self.delectArr removeAllObjects];
                [cell setStatus:self.isMe compile:self.isClickManager select:NO];

                
            }
        }

    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark 是否可以编辑 默认为YES
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
//    if (self.isClickManager == YES) {
//        return YES;
//    }else
        return NO;
//    return YES;
}
#pragma mark 选择要对表进行的处理方式 默认是删除方式
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

#pragma mark  选中时将选中行的在self.dataSource 中的数据添加到删除数组
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ReceiveTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSLog(@"self isClickManager status is :%d",self.isClickManager);
    NSLog(@"indexPath row is :%ld",(long)indexPath.row);

            if (cell.cellStatus == YES) {
                [cell setStatus:self.isMe compile:self.isClickManager select:NO];

                [self.delectArr removeObject:[self.dataSource objectAtIndex:indexPath.row]];
            }else {
                [cell setStatus:self.isMe compile:self.isClickManager select:YES];

                [self.delectArr addObject:[self.dataSource objectAtIndex:indexPath.row]];
            }
    if (self.delectArr.count == self.dataSource.count) {
        self.allSelectBtn.selected = YES;
    }else {
        self.allSelectBtn.selected = NO;
    }

}
//
//#pragma mark 取消选中时 将存放在self.delecteArr中的数据移除
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReceiveTableViewCell *cell = (ReceiveTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];

    if (self.isClickManager == YES) {

    }else {

        [cell setStatus:self.isMe compile:self.isClickManager select:NO];

        NSLog(@"diddeselect row is :%ld",indexPath.row);
    }
}

#pragma mark delectedBtn

/*
 /删除收货地址
 http://test.m.yundiaoke.cn/api/user/delAddress/adres_id/1
 请求方式：get
 参数：adres_id：当前数据的ID
 200：成功，400：失败，401：数据不合法，403：非法参数
 
 */
- (void)delectedBtn:(UIButton *)sender {
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (AddressListModel *model in self.delectArr) {
        [array addObject: model.adres_id];
        
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"adres_id"] = array;
        NSLog(@"addressid is :%@",array);
    //    NSLog(@"");
    [self.AFManager GET:@"http://test.m.yundiaoke.cn/api/user/delAddress/" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"params content is:%@",params);
        NSLog(@"delected status is :%@",responseObject);
        //        if ([responseObject[@"status"] isEqual:@200]) {
        
        
        [self.dataSource removeObjectsInArray:self.delectArr];
        
        [self.tableView reloadData];
        //        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    NSLog(@"delected address is %@",self.delectArr);
    //        删除
    
    
}


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
