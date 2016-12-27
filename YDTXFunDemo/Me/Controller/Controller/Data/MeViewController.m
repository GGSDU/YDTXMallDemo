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
#import "MeDataTableViewController.h"
#import "MeAcountViewController.h"
#import "MyActionViewController.h"
#import "MyFriendViewController.h"
#import "MyOrederGoodsViewController.h"
#import "MyModel.h"
#import "LoginViewController.h"//登录
#import "MyPostsViewController.h"
#import "LoginViewController.h"
#import "MeHeadImageViewTableViewCell.h"

//
#import "ManagerMyMessageTableViewCell.h"
#import "ReceiveTableViewController.h"
#import "OrderViewController.h"
#import "CouponViewController.h"
#import "EquityTableViewController.h"
#import "RecommentViewController.h"


#define headPhoto @"http://m.yundiaoke.cn"


@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,ManagerMyMessageTabelViewCellDelegate,MeHeadImageViewTableViewCellDelegate>{
    
    NSArray *collectionName;
    NSArray *ButtonName;
    
    
    
}

@property UITableView *myTableView;


@property (nonatomic, strong) UIImagePickerController *pickerC;
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *dataSources;//接受的数据源
@property (nonatomic, strong) UIButton *logoutBut;// 退出登录
@property (nonatomic, strong) UIView *logoutView;


//   传值给cell
@property (assign, nonatomic) BOOL isLogin;//是否登录
@property (copy, nonatomic) NSString *headerURL;
@property (copy, nonatomic) NSString *nameString;
@property (copy, nonatomic) NSString *sexString;
@property (copy, nonatomic) NSString *userIdentify;


@end
static NSString *headImg = @"headImg";
static NSString *cellID = @"Mecell";
static NSString *cellId = @"Mycells";
static NSString *collect = @"collect";

@implementation MeViewController

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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.isLogin = NO;
    collectionName = @[@"邀请好友",@"清除缓存"];
    ButtonName = @[@"资料设置",@"账号设置",@"我的收藏",@"我的帖子",@"我的推荐"];
    
    
    [self creatView];

    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    SDStatusBarBlack
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bg"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{
       NSForegroundColorAttributeName : [UIColor whiteColor]
       }];
    self.navigationItem.title = @"我的";
    
    
    
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];

    

    
    //  退出登录
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
#pragma mark 如果登录状态 显示退出登录按钮
        self.logoutBut.hidden = NO;

    }else{
        self.logoutBut.hidden = YES;

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
                
                
                                NSLog(@"用户数据%@",responseObject);
                if (![responseObject[@"data"] isEqual:[NSNull null]]) {
                    [[NSUserDefaults standardUserDefaults] setObject:self.dataSources[@"nickname"] forKey:[NSString stringWithFormat:@"nickname%@",userid]];

                    self.dataSources = responseObject[@"data"];

                    
                    self.headerURL = self.dataSources[@"headpic"];
                    self.nameString = self.dataSources[@"nickname"];
                    self.sexString = self.dataSources[@"sex"];
                    self.userIdentify = @"身份";
                    self.isLogin = YES;

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
            

            self.logoutBut.hidden = YES;
        }
    }else {
        [self.myTableView.mj_header endRefreshing];
        self.dataSources = NULL;
        self.logoutBut.hidden = YES;
        
        self.myTableView.userInteractionEnabled = YES;
        
    }
    
    [self.myTableView reloadData];
}

- (void)creatView {
    self.myTableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.myTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    
}


- (void)logoutBut:(UIButton *)sender {
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"退出登录" message:@"是否退出" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.delegate =self;
    [alertView show];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    switch (buttonIndex) {
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

                self.logoutBut.hidden = YES;
                
                
                self.dataSources = NULL;

                [SVProgressHUD showSuccessWithStatus:@"退出成功"];
                
                self.isLogin = NO;

                
                [self.myTableView reloadData];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [SVProgressHUD showErrorWithStatus:@"退出失败"];
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
//        self.heardImageV.userInteractionEnabled = NO;
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }
}
/**
 *  登录方法
 *
 *  @param sender
 */
- (void)loginbut:(UIButton *) sender {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
        sender.enabled = NO;
    }else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
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
    if (section == 0) {
        return 0.01;
    }
    else {
        return 10*HeightScale;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSources != nil&&self.dataSources != NULL) {
        

        if (indexPath.section == 0) {
            MeHeadImageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headImg];
            if (!cell) {
                cell = [[MeHeadImageViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headImg];
            }
            cell.delegate = self;
            [cell setHeadContentStatus:self.isLogin headerURL:self.headerURL nameString:self.nameString sexString:self.sexString userIdentity:self.userIdentify];
            
            return cell;
            
        }  if (indexPath.section==1) {
            ManagerMyMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[ManagerMyMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.delegate = self;
            
            
            
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     资料设置
     */
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:[NSString stringWithFormat:@"userstatus%@",userid]] == YES) {
        MeDataTableViewController *meData = [[MeDataTableViewController alloc]init];
        MeAcountViewController *meAcount = [[MeAcountViewController alloc]init];
        switch (indexPath.section) {
            case 0:
            {
                
            }
                break;
            case 1:
            {
                
            }
                break;
            case 2:
            {
                switch (indexPath.row) {
                    case 0:
                    {
                        [self.navigationController pushViewController:meData animated:YES];
                    }
                        break;
                    case 1:
                    {
                        [self.navigationController pushViewController:meAcount animated:YES];
                    }
                        break;
                        
                    case 2:
                    {
                        MyActionViewController *meCollectionVC = [[MyActionViewController alloc]init];
                        [self.navigationController pushViewController:meCollectionVC animated:YES];
                        
                       
                    }
                        break;
                    case 3:
                    {
                        MyPostsViewController *Socialviewc = [[MyPostsViewController alloc]init];
                        [self.navigationController pushViewController:Socialviewc animated:YES];
                        
                        
                    }
                        break;
                    case 4: {
                        RecommentViewController *commentVC = [[RecommentViewController alloc]init];
                        [self.navigationController pushViewController:commentVC animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
                
            }
                break;
            case 3:
            {
                switch (indexPath.row) {
                    case 0:{
                        MyFriendViewController *friendVC = [[MyFriendViewController alloc]init];
                        [self.navigationController pushViewController:friendVC animated:YES];
                        
                       
                    }
                        break;
                    case 1:
                    {
                        NSString *str = [NSString stringWithFormat:@"确认要清除%0.1fM的内容吗？",[self clearCache]];
                        
                        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
                        //设置取消按钮
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        //设置确定按钮
                        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                            [self removdChace];
                        }];
                        [controller addAction:cancelAction];
                        [controller addAction:okAction];
                        [self presentViewController:controller animated:YES completion:nil];
                    }
                        break;
                                           
                    default:
                        break;
                }
//                return;
            }
                break;
                
            default:
                break;
        }
        //
    }
    else {
        if (indexPath.section==2) {
            if (indexPath.row == 3) {
                NSString *str = [NSString stringWithFormat:@"确认要清除%0.1fM的内容吗？",[self clearCache]];
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:UIAlertControllerStyleAlert];
                //设置取消按钮
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                //设置确定按钮
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [self removdChace];
                }];
                [controller addAction:cancelAction];
                [controller addAction:okAction];
                [self presentViewController:controller animated:YES completion:nil];
            }else {
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                [self.navigationController pushViewController:loginVC animated:YES];
            }
            
        }
        else {
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
    
}

#pragma mark --管理我的订单信息的代理---
- (void)didClickBtn:(UIButton *)button tag:(NSInteger)tag manageCellView:(ManagerMyMessageTableViewCell *)view {
    if (tag == 10) {
        
        OrderViewController *orderGoodsVC = [[OrderViewController alloc]init];
        
        [self.navigationController pushViewController:orderGoodsVC animated:YES];
        
    } else if (tag == 11) {
        
        ReceiveTableViewController *receiveVC = [[ReceiveTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        receiveVC.isMe = YES; //ture is mycenter ，false is market
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



#pragma mark -----头视图的代理方法--
- (void)didClickHeadImageView:(MeHeadImageViewTableViewCell *)view tag:(NSInteger)tag {
    if (self.isLogin) {

    } else {
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:login animated:YES];
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
