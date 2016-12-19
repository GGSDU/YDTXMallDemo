//
//  MeViewController.m
//  YDTX
//
//  Created by 舒通 on 16/8/30.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeViewController.h"
#import "MeTableViewCell.h"
#import "MyTableViewCell.h"
#import "MyCollentTableViewCell.h"


#import "MyModel.h"

#import "MeHeadImageViewTableViewCell.h"
#import "ManagerMyMessage.h"

//
#import "ReceiveTableViewController.h"
#import "OrderViewController.h"
#import "CouponViewController.h"
#import "EquityTableViewController.h"



//#define headPhoto @"http://m.yundiaoke.cn"


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,ManagerMyMessageDelegate>{
    NSArray *buttonName;
    NSArray *collectionName;
    NSArray *ButtonName;
}

@property UITableView *myTableView;

@property (nonatomic, strong) UIImageView *heardImageV;
@property (nonatomic, strong) UIButton *loginBut;
@property (nonatomic, strong) UIImageView *heardView;
@property (nonatomic, strong) UIImagePickerController *pickerC;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *dataSources;//接受的数据源
@property (nonatomic, strong) UIButton *logoutBut;// 退出登录
@property (nonatomic, strong) UIView *logoutView;

@end


@implementation MeViewController
- (UIImageView *)heardImageV {
    if (!_heardImageV) {
        _heardImageV = [UIImageView new];
        
    }
    return _heardImageV;
}
- (NSMutableDictionary *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableDictionary dictionary];
    }
    return _dataSources;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (UIImagePickerController *)pickerC {
    if (!_pickerC) {
        _pickerC = [[UIImagePickerController alloc]init];
        _pickerC.delegate =self;
    }
    return _pickerC;
}
- (UIButton *)loginBut {
    if (!_loginBut) {
        _loginBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
        [_loginBut addTarget:self action:@selector(loginbut:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBut;
}
- (UIButton *)logoutBut {
    if (!_logoutBut) {
        _logoutBut = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutBut setBackgroundImage:[UIImage imageNamed:@"退出图标"] forState:UIControlStateNormal];
        
        [_logoutBut setTitle:@"退出" forState:UIControlStateNormal];
        [_logoutBut addTarget:self action:@selector(logoutBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.logoutView addSubview:_logoutBut];
        
        [_logoutBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.logoutView).offset(15*HeightScale);
            make.left.mas_equalTo(self.view.mas_left).offset(20*WidthScale);
            make.right.mas_equalTo(self.view.mas_right).offset(-20*WidthScale);
            make.bottom.mas_equalTo(self.logoutView).offset(-5*HeightScale);
        }];
        
    }
    return _logoutBut;
}
- (UIView *)logoutView {
    if (!_logoutView) {
        _logoutView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 60*HeightScale)];
        self.myTableView.tableFooterView = _logoutView;
        self.myTableView.contentInset = UIEdgeInsetsMake(0, 0, 44+CGRectGetHeight(_logoutView.bounds), 0);
    }
    return _logoutView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
//    buttonName = @[@"城市",@"生日",@"签名"];
    collectionName = @[@"我的帖子",@"我的收藏",@"我的订单"];
    ButtonName = @[@"资料设置",@"账号设置",@"邀请好友",@"清除缓存"];
    
    
    [self creatView];
    [self lodaMeData];
    
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"65" forKey:@"userid"];;
    
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     @{
//       NSForegroundColorAttributeName : [UIColor whiteColor]
//       }];
    self.navigationItem.title = @"我的";
    
    
    
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *strname = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"nickname%@",userid]];
    NSLog(@"nickname is isi isi :%@",strname);
    BOOL statu = [[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]];
    if (statu==YES) {//如果登录了
        
#pragma mark 如果登陆了，不论有没有昵称都要显示出来
        self.loginBut.enabled = NO;
        [self.loginBut setTitle:strname forState:UIControlStateNormal];
    }else {
        [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
        self.loginBut.enabled = YES;
    }
    
    //  退出登录
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
#pragma mark 如果登录状态 显示退出登录按钮
        self.logoutBut.hidden = NO;
        self.heardImageV.userInteractionEnabled = NO;
    }else{
        self.logoutBut.hidden = YES;
        self.heardImageV.userInteractionEnabled = YES;
    }
    
    
    [self lodaMeData];
    
    [self.myTableView reloadData];
}
-(void)setupRefresh
{
    self.myTableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(lodaMeData)];
    
    self.myTableView.mj_header.automaticallyChangeAlpha = YES;
    [self.myTableView.mj_header beginRefreshing];//进来
}

- (void)lodaMeData {
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    if (userid != nil && userid.length > 0) {//判断用户id是否存在
        
        if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"userid"] isEqualToString:@""]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            dic[@"userid"] = userid;
            [self.manager GET:[postHttp stringByAppendingString:@"api/user/userInfo"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //                NSLog(@"用户数据%@",responseObject);
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.dataSources[@"nickname"] forKey:[NSString stringWithFormat:@"nickname%@",userid]];
                    [self.loginBut setTitle:self.dataSources[@"nickname"] forState:UIControlStateNormal];
                    self.dataSources = responseObject[@"data"];
                    
                }else {
                    self.dataSources = nil;
                }
                [self.myTableView.mj_header endRefreshing];
                [self.myTableView reloadData];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //                NSLog(@"个人资料请求失败");
            }];
        }else  {
            [self.myTableView.mj_header endRefreshing];
            self.dataSources = NULL;
            [self.myTableView reloadData];
            [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
            self.logoutBut.hidden = YES;
            self.heardImageV.userInteractionEnabled = YES;
            //            }
        }
    }else {
        [self.myTableView.mj_header endRefreshing];
        self.dataSources = NULL;
        self.logoutBut.hidden = YES;
        self.heardImageV.userInteractionEnabled = YES;
        [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
        self.loginBut.enabled = YES;
        self.myTableView.userInteractionEnabled = YES;
        [self.myTableView reloadData];
    }
}

- (void)creatView {
    self.myTableView = [[UITableView alloc]init];
    self.myTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight-49));
        
    }];
}
/**
 *  头视图的数据
 */

/**
 *  退出登录

 */
- (void)logoutBut:(UIButton *)sender {
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"是否退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate =self;
    [alertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"uid"] = userid;
            [self.manager POST:[postHttp stringByAppendingString:@"api/Login/logout"] parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:[NSString stringWithFormat:@"userstatus%@",userid]];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[NSString stringWithFormat:@"username%@",userid]];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:[NSString stringWithFormat:@"nickname%@",userid]];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:[NSString stringWithFormat:@"birthday%@",userid]];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:[NSString stringWithFormat:@"prov%@",userid]];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:[NSString stringWithFormat:@"city%@",userid]];
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:[NSString stringWithFormat:@"area%@",userid]];
                [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userid"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];
                //            [self.loginBut setTitle:@"" forState:UIControlStateNormal];
                [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
                self.loginBut.enabled = YES;
                self.logoutBut.hidden = YES;
                
                
                //            [self lodaMeData];
                
                
                self.dataSources = NULL;
                self.heardView.userInteractionEnabled = YES;
                self.heardView.image = nil;
                self.heardImageV.image = [UIImage imageNamed:@"头像"];
//                [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                //                NSLog(@"退出成功%@",responseObject);
                [self.myTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                [SVProgressHUD showErrorWithStatus:@"退出失败"];
            }];
            
            
        }
            break;
            
        default:
            break;
    }
}
/**
 *  头型视图点击方法
 */
- (void)headtap{
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
        self.heardImageV.userInteractionEnabled = NO;
    }else {

    }
}
/**
 *  登录方法

 */
- (void)loginbut:(UIButton *) sender {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
        sender.enabled = NO;
    }else {

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 180*HeightScale;
    } else if (indexPath.section == 1) {
        return 100*HeightScale;
    }
    else {
        return 50*HeightScale;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if(section == 2){
        return ButtonName.count;
    }else{
        return collectionName.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 ) {
        return 0.01;
    } else if (section == 1) {
        return 10*HeightScale;
    }
    else {
        return 15*HeightScale;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSources != nil&&self.dataSources != NULL) {
        
        
        static NSString *headImg = @"headImg";
        static NSString *cellID = @"Mecell";
        static NSString *cellId = @"Mycells";
        static NSString *collect = @"collect";
        
        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        if (indexPath.section == 0) {
            MeHeadImageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg];
            if (!cell) {
                cell = [[MeHeadImageViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headImg];
            }
            //        cell.userInteractionEnabled = NO;
            //        头像视图
            self.heardImageV.image = nil;
            self.heardImageV.image = [UIImage imageNamed:@"头像"];
            self.heardImageV.layer.borderColor = [UIColor whiteColor].CGColor;
            self.heardImageV.layer.borderWidth = 1;
            self.heardImageV.layer.masksToBounds = YES;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headtap)];
            [cell.imageV addSubview:self.heardImageV];
            [self.heardImageV addGestureRecognizer:tap];
            self.heardImageV.userInteractionEnabled = YES;
            [self.heardImageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cell.contentView).offset(30*HeightScale);
                make.centerX.mas_equalTo(cell.contentView);
                make.size.mas_equalTo(CGSizeMake(90*HeightScale, 90*HeightScale));
            }];
            if ([self.dataSources[@"headpic"] hasSuffix:@".png"]) {
                self.heardImageV.image = nil;
                [self.heardImageV sd_setImageWithURL:[NSURL URLWithString:[postHttp stringByAppendingString:self.dataSources[@"headpic"]]] placeholderImage:[UIImage imageNamed:@"zwt"]];
            }
            
            self.heardImageV.layer.cornerRadius = 90*HeightScale/2;
            self.heardImageV.layer.masksToBounds = YES;
            NSString *nickname = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"nickname%@",userid]];
            BOOL statu = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"userstatus%@",userid]];
            
            if (statu == YES) {
                [self.loginBut setTitle:nickname forState:UIControlStateNormal];
            }else {
                //            [self.loginBut setTitle:@"" forState:UIControlStateNormal];
                [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
            }

            //      登录按钮
            [cell.imageV addSubview:self.loginBut];
            [self.loginBut mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.heardImageV.mas_bottom).offset(14*HeightScale);
                make.height.mas_equalTo(40*HeightScale);
                make.centerX.mas_equalTo(cell.contentView);
            }];
            
            return cell;
            
        }  if (indexPath.section==1) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];

            }
            
            ManagerMyMessage *manager = [[ManagerMyMessage alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100*HeightScale)];
            manager.delegate = self;
            
            [cell.contentView addSubview:manager];
            
            return cell;
        }  if (indexPath.section == 2) {
            MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
            if (!cell) {
                cell = [[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
            }
            
            cell.contentButton.text = ButtonName[indexPath.row] ;
            return cell;
        }  if(indexPath.section == 3){
            MyCollentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:collect];
            if (!cell) {
                cell = [[MyCollentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:collect];
            }
            NSArray *array = @[@"我的帖子",@"我的收藏图片",@"订单图标"];
            cell.myimageView.image = [UIImage imageNamed:array[indexPath.row]];
            
            cell.contentLabel.text = collectionName[indexPath.row];
            
            return cell;
            
        }else {
            return nil;
        }
    }else {
        return nil;
    }
    
}

#pragma mark --管理我的订单信息的代理---
- (void)didClickBtn:(UIButton *)button tag:(NSInteger)tag managerview:(UIView *)view {
    if (tag == 10) {
        
        OrderViewController *orderGoodsVC = [[OrderViewController alloc]init];
        
        [self.navigationController pushViewController:orderGoodsVC animated:YES];
        
    } else if (tag == 11) {
        
        ReceiveTableViewController *receiveVC = [[ReceiveTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        receiveVC.isMe = NO; //ture is mycenter ，false is market
        [self.navigationController pushViewController:receiveVC animated:YES];
        


    } else if (tag == 12) {
        CouponViewController *couponVC = [[CouponViewController alloc]init];
        [self.navigationController pushViewController:couponVC animated:YES];
    
    } else if (tag == 13) {
        EquityTableViewController *equityVC = [[EquityTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        
        [self.navigationController pushViewController:equityVC animated:YES];

    }
    
      NSLog(@"button title and tag is :%@,%ld",button.titleLabel.text,tag);
}
#pragma mark ---------------清除缓存代码-----------------

- (float)clearCache{
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    float folderSize = 0.0f;
    if ([fileManager fileExistsAtPath:path]) {
        //拿到算有文件的数组
        NSArray *childerFiles = [fileManager subpathsAtPath:path];
        //拿到每个文件的名字,如有有不想清除的文件就在这里判断
        for (NSString *fileName in childerFiles) {
            //将路径拼接到一起
            NSString *fullPath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self fileSizeAtPath:fullPath];
//            folderSize = (folderSize + [self fileSizeAtPath:fullPath]);
        }
    }
    
    return folderSize;
}

-(float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        
        return size/1024.0/1024.0;
    }
    return 0;
}

- (void)removdChace{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
