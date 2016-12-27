//
//  MeDataTableViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeDataTableViewController.h"
#import "MeDataTableViewCell.h"
#import "HMDatePickView.h"
#import "SGLocationPickerView.h"
#import "MeNameViewController.h"
#import "MeViewController.h"
#import "UIImage+Scale.h"

#define headPhoto @"http://m.yundiaoke.cn"
#define userID [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];

@interface MeDataTableViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}


@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *tableDic;//上传的数据源
@property (nonatomic, strong) NSMutableDictionary *dataSources;//接收到的数据
@property (assign, nonatomic) BOOL isClickButton;
@end



@implementation MeDataTableViewController
- (NSMutableDictionary *)dataSources {
    if (!_dataSources) {
        _dataSources = [NSMutableDictionary dictionary];
    }
    return _dataSources;
}
- (NSMutableDictionary *)tableDic {
    if (!_tableDic) {
//        NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        _tableDic = [NSMutableDictionary dictionary];
        _tableDic[@"userid"] = userID;
    }
    return _tableDic;
}

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [self getDataSources];
}
//- (void)viewDidAppear:(BOOL)animated {
//    [super viewDidAppear:YES];
//    [self getDataSources];
//}
#warning 上传数据
- (void)postheadpic:(NSString *)headpic nickname:(NSString *)nickname sex:(NSInteger)sex birthday:(NSString *)birthday prov:(NSString *)prov city:(NSString *)city area:(NSString *)area signature:(NSString *)signature userid:(NSString *)userid {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSLog(@"22222222222:%@,%@,%ld,%@,%@,%@",userid,nickname,(long)sex,birthday,prov,city);
    dic[@"userid"] = userid;
    dic[@"pic"] = headpic;
    dic[@"nickname"] = nickname;
    dic[@"sex"] = @(sex);
    dic[@"birthday"] = birthday;
    dic[@"prov"] = prov;
    dic[@"city"] = city;
    dic[@"area"] = area;
    dic[@"signature"] = signature;
    [self.manager POST:[postHttp stringByAppendingString:@"api/user/updateInfo"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"成功%@",responseObject[@"data"][@"headpic"]);
        //把存储在本地的图片传到另一个界面
        MeViewController *meVC = [[MeViewController alloc]init];
        NSData *data = [[NSUserDefaults standardUserDefaults]objectForKey:[NSString stringWithFormat:@"headImg%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"]]];
        meVC.headImgData = data;
        
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"失败");
    }];
}
#warning  请求数据
- (void) getDataSources {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    dic[@"userid"] = userID;
    [self.manager GET:[postHttp stringByAppendingString:@"api/user/userInfo"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataSources = responseObject[@"data"];
        if ([responseObject[@"status"] isEqual:@200]) {
            [self.myTableView reloadData];
//            NSLog(@"222个人资料请求成功%@",responseObject[@"data"]);
#pragma mark 请求下数据之后同步保存在本地
            NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
//            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"headpic"] forKey:[@"headpic" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"nickname"] forKey:[@"nickname" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setInteger:[responseObject[@"data"][@"sex"] integerValue] forKey:[@"sex" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"birthday"] forKey:[@"birthday" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"prov"] forKey:[@"prov" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"city"] forKey:[@"city" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"area"] forKey:[@"area" stringByAppendingString:userid]];

            [[NSUserDefaults standardUserDefaults]setObject:responseObject[@"data"][@"signature"] forKey:[@"signature" stringByAppendingString:userid]];
            
            
        }else if([responseObject[@"status"] isEqual:@400]){
            
            [SVProgressHUD showErrorWithStatus:@"没有个人信息"];
            NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"headpic" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"nickname" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setInteger:100 forKey:[@"sex" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"birthday" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"prov" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"city" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"area" stringByAppendingString:userid]];
            
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:[@"signature" stringByAppendingString:userid]];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"个人资料请求失败！");
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isClickButton = NO;
    self.title = @"资料设置";
    self.view.backgroundColor = [UIColor whiteColor];
    _picker = [[UIImagePickerController alloc]init];
    _picker.delegate = self;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"形状4"] style:UIBarButtonItemStylePlain target:self action:@selector(backButton:)];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = backButton;
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(rightButton:)];
    rightButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    [self creatView];
    [self getDataSources];
    
}
- (void) backButton:(UIBarButtonItem *)sender {
    if (self.isClickButton == NO) {
        [[NSUserDefaults standardUserDefaults]synchronize];
        UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [self localdatas];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否确认退出资料修改" preferredStyle: UIAlertControllerStyleAlert];
        [alertController addAction:cancel];
        [alertController addAction:ensure];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
   }
/**
 *  提交数据
 */
- (void)rightButton:(UIBarButtonItem *)sender {
    self.isClickButton = YES;
    [self localdatas];
    
}
//本地存储的数据
- (void) localdatas{
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *headpic = [[NSUserDefaults standardUserDefaults]objectForKey:[@"headpic" stringByAppendingString:userid]];
    NSString *nickname = [[NSUserDefaults standardUserDefaults]objectForKey:[@"nickname" stringByAppendingString:userid]];
    NSInteger sex = [[NSUserDefaults standardUserDefaults]integerForKey:[@"sex" stringByAppendingString:userid]];
    NSString *birthday = [[NSUserDefaults standardUserDefaults]objectForKey:[@"birthday" stringByAppendingString:userid]];
    NSString *prov =[[NSUserDefaults standardUserDefaults]objectForKey:[@"prov" stringByAppendingString:userid]];
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:[@"city" stringByAppendingString:userid]];
    NSString *area = [[NSUserDefaults standardUserDefaults]objectForKey:[@"area" stringByAppendingString:userid]];
    NSString *signature = [[NSUserDefaults standardUserDefaults]objectForKey:[@"signature" stringByAppendingString:userid]];
    [self postheadpic:headpic nickname:nickname sex:sex birthday:birthday prov:prov city:city area:area signature:signature userid:userid];
}

- (void)creatView {
    self.myTableView = [[UITableView alloc]init];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor clearColor];
    self.myTableView.scrollEnabled = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.myTableView];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth, ScreenHeight));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if(section == 1){
    return 5;
    }else {
        return 0;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *nickname = [[NSUserDefaults standardUserDefaults]objectForKey:[@"nickname" stringByAppendingString:userid]];
    NSInteger sex = [[NSUserDefaults standardUserDefaults]integerForKey:[@"sex" stringByAppendingString:userid]];
    NSString *birthday = [[NSUserDefaults standardUserDefaults]objectForKey:[@"birthday" stringByAppendingString:userid]];
    NSString *prov =[[NSUserDefaults standardUserDefaults]objectForKey:[@"prov" stringByAppendingString:userid]];
    NSString *city = [[NSUserDefaults standardUserDefaults]objectForKey:[@"city" stringByAppendingString:userid]];
    NSString *area = [[NSUserDefaults standardUserDefaults]objectForKey:[@"area" stringByAppendingString:userid]];
    NSString *signature = [[NSUserDefaults standardUserDefaults]objectForKey:[@"signature" stringByAppendingString:userid]];

    static NSString *MedataStr = @"medata";
    static NSString *tablev = @"tableview";
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tablev];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tablev];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"头像";
            /**
             *  头像
             */
            self.imageView = [[UIImageView alloc]init];
            
            [cell.contentView addSubview:self.imageView];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(cell.mas_right).offset(-36*HeightScale);
                make.centerY.mas_equalTo(cell.mas_centerY);
                make.size.mas_equalTo(CGSizeMake(50*HeightScale, 50*HeightScale));
            }];
            self.imageView.layer.cornerRadius = 25*HeightScale;
            self.imageView.layer.masksToBounds = YES;
            
            if (self.dataSources[@"headpic"] == nil) {
                self.imageView.image = [UIImage imageWithContentsOfFile:imagePath];
            }else {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:[postHttp stringByAppendingString:self.dataSources[@"headpic"]]] placeholderImage:[UIImage imageNamed:@"zwt"]];
            }
            return cell;
            
        }
            case 1:
        {
            NSArray *dataName = @[@"昵称",@"性别",@"生日",@"城市",@"签名"];
            MeDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MedataStr];
            if (!cell) {
                cell = [[MeDataTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MedataStr];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = dataName[indexPath.row];
            switch (indexPath.row) {
                case 0:
                {
                    if (nickname) {
                        cell.label.text = nickname;
                    }else {
                    cell.label.text = self.dataSources[@"nickname"];
                    }
                }
                    break;
                case 1:
                {
                    if (sex) {
                        if (sex == 0) {
                            cell.label.text = @"女";
                        }else {
                            cell.label.text = @"男";
                        }
                    }else{
                    if (self.dataSources[@"sex"] == 0) {
                        cell.label.text = @"女";
                    }else {
                        cell.label.text = @"男";
                    }
                    }
                }
                    break;
                case 2:
                {
                    if (birthday) {
                        cell.label.text = birthday;
                    } else {
                    cell.label.text = self.dataSources[@"birthday"];
                    }
                }
                    break;
                case 3:
                {
                    if (prov&&city&&area) {
                        cell.label.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
                    }else {
                    cell.label.text = [NSString stringWithFormat:@"%@%@%@",self.dataSources[@"prov"],self.dataSources[@"city"],self.dataSources[@"area"]];
                    }
                }
                    break;
                case 4:
                {
                    if (signature) {
                        cell.label.text = signature;
                    }else {
                    cell.label.text = self.dataSources[@"signature"];
                    }
                }
                    break;
                    
                default:
                    break;
            }
          
            if ([cell.label.text isEqualToString:@""]||[cell.label.text isEqualToString:@"(null)(null)(null)"]||[cell.label.text isEqualToString:@"0000-00-00"]) {
                cell.label.text = @"未填写";
            }
            return cell;
        }
            break;
            
        default:
            return nil;
            break;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 68*HeightScale;
    }else {
        return 44*HeightScale;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 20*HeightScale;
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.isClickButton = NO;
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    MeNameViewController *meName = [[MeNameViewController alloc]init];
   
            if (indexPath.section == 0)
        {
            self.imageView.userInteractionEnabled = YES;
            UIAlertAction * act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            //拍照：
            UIAlertAction * act2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                // 调用相机
                UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
                if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                    self.picker.sourceType = sourceType;
                    if(iOS8Later) {
                        self.picker.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                        
                    }
                    if (iOS9Later) {
                        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                    }
                    [self presentViewController:self.picker animated:YES completion:nil];
                } else {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"当前设备不支持拍照" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alertView show];
                }
            }];
            //相册
            UIAlertAction * act3 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                NSLog(@"%ld",(long)self.picker.sourceType);
                _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:_picker animated:YES completion:nil];
            }];
            UIAlertController * aleVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"选择图片" preferredStyle:UIAlertControllerStyleActionSheet];
            [aleVC addAction:act1];
            [aleVC addAction:act2];
            [aleVC addAction:act3];
            
            [self presentViewController:aleVC animated:YES completion:nil];
        }
           else if (indexPath.section ==1) {
                
                MeDataTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                switch (indexPath.row) {
                    case 0:
                    {
                        [meName creatTextFile];
                        if ([[NSUserDefaults standardUserDefaults]objectForKey:[@"nickname" stringByAppendingString:userid]]) {
                            meName.textField.text = [[NSUserDefaults standardUserDefaults]objectForKey:[@"nickname" stringByAppendingString:userid]];
                        }
                        [self.navigationController pushViewController:meName animated:YES];
                        
                        meName.finishInputMsgBlock = ^(NSString *msg){
                            
                            cell.label.text = msg;
                            [[NSUserDefaults standardUserDefaults]setObject:msg forKey:[@"nickname" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"nickname"] = msg;
                        };
                    }
                        break;
                    case 1:
                    {
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"性别" message:@"选择性别" preferredStyle:UIAlertControllerStyleActionSheet];
                        UIAlertAction *bAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            cell.label.text = action.title;
                            [[NSUserDefaults standardUserDefaults]setInteger:1 forKey:[@"sex" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"sex"] = @1;
                        }];
                        
                        UIAlertAction *gAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            cell.label.text = action.title;
                            [[NSUserDefaults standardUserDefaults]setObject:0 forKey:[@"sex" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"sex"] = @0;
                        }];
                        
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                        
                        
                        [alertController addAction:bAction];
                        [alertController addAction:gAction];
                        [alertController addAction:cancel];
                        
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                        break;
                    case 2:
                    {
                        /** 自定义日期选择器 */
                        HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                        //距离当前日期的年份差（设置最大可选日期）
                        datePickVC.maxYear = -1;
                        //设置最小可选日期(年分差)
                        //    _datePickVC.minYear = 10;
                        datePickVC.date = [NSDate date];
                        //设置字体颜色
                        //                    datePickVC.fontColor = [UIColor redColor];
                        //日期回调
                        datePickVC.completeBlock = ^(NSString *selectDate) {
                            cell.label.text = selectDate;
                            [[NSUserDefaults standardUserDefaults]setObject:selectDate forKey:[@"birthday" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"birthday"] = cell.label.text;
                        };
                        //配置属性
                        [datePickVC configuration];
                        [self.view addSubview:datePickVC];
                    }
                        break;
                    case 3:
                    {
                        SGLocationPickerView *PickerView = [[SGLocationPickerView alloc] init];
                        PickerView.MyBlock = ^(NSString *prov,NSString *city,NSString *area){
                            cell.label.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
                            [[NSUserDefaults standardUserDefaults]setObject:prov forKey:[@"prov" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            [[NSUserDefaults standardUserDefaults]setObject:city forKey:[@"city" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            [[NSUserDefaults standardUserDefaults]setObject:area forKey:[@"area" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"prov"] = prov;
                            self.tableDic[@"city"] = city;
                            self.tableDic[@"area"] = area;
                        };
                    }
                        break;
                    case 4:
                    {
                        [meName creatTextView];
                        if ([[NSUserDefaults standardUserDefaults]objectForKey:[@"signature" stringByAppendingString:userid]]) {
                            meName.textView.text = [[NSUserDefaults standardUserDefaults]objectForKey:[@"signature" stringByAppendingString:userid]];
                        }
                        [self.navigationController pushViewController:meName animated:YES];
                        
                        meName.finishInputMsgBlock = ^(NSString *msg){
                            cell.label.text = msg;
                            [[NSUserDefaults standardUserDefaults]setObject:msg forKey:[@"signature" stringByAppendingString:userid]];
                            [[NSUserDefaults standardUserDefaults]synchronize];
                            self.tableDic[@"signature"] = msg;
                        };
                    }
                        break;
                        
                    default:
                        break;
                }
            }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.myTableView reloadData];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * upImage = [info objectForKeyedSubscript:@"UIImagePickerControllerOriginalImage"];

    CGFloat scale = upImage.size.height / upImage.size.width;
    //    NSLog(@"原始图片的尺寸：%f,%f",image.size.width,image.size.height);
//    UIImage *newImage;
//    if (upImage.size.width>1000) {

//    }else {
//        newImage = [UIImage imageWithImage:upImage scaledToSize:CGSizeMake(upImage.size.width, upImage.size.width) scaled:scale];
//    }
//    NSLog(@"newImage is %@",[UIImage imageWithImage:upImage scaledToSize:CGSizeMake(upImage.size.width/3, upImage.size.width/3*scale) scaled:scale]);
    

//    NSData *data = UIImageJPEGRepresentation([UIImage imageWithImage:upImage scaledToSize:CGSizeMake(upImage.size.width / 3, upImage.size.width / 3 * scale) scaled:scale], 0.7);
    
    UIImage *scaledImage = [UIImage imageWithOriginImage:upImage scale:0.8];
    NSData *data = UIImageJPEGRepresentation(scaledImage, 1);
    
    
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSString *dataKey = [NSString stringWithFormat:@"headImg%@",userid];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:dataKey];
    
    NSString *imageStr = [data base64Encoding];
    NSString *imageKey = [@"headpic" stringByAppendingString:userid];
    [[NSUserDefaults standardUserDefaults] setObject:imageStr forKey:imageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    self.tableDic[@"pic"] = imageStr;
    [picker dismissViewControllerAnimated:YES completion:nil];

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
