//
//  AddSpotMessageViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/19.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "AddSpotMessageViewController.h"



#import "SpotFeatureView.h"

#import "SpotTypeListView.h"
#import "SpotTextFileView.h"


#import "SpotAddDescribView.h"

/*
 name => 塘口名称
 price => 塘口价格
 person => 塘口负责人名字
 phone => 塘口负责人电话
 basan => 塘口类型 (1=>野塘 2=>江河 3=>湖库 4=>农家乐 5=>斤塘 6=>黑坑 7=>公园 8=>海域 9=>竞技池)
 special => 塘口特色(1=>停车位 2=>餐饮 3=>住宿 4=>棋牌 5=>夜钓)
 img => 塘口图片
 content => 塘口描述
 
 fishtype => 鱼种
 
 prov
 city
 area
 address => 塘口地址
 */
@interface AddSpotMessageViewController () <SpotFeatureViewDelegate,SpotTextFileViewDelegate,SpotAddDescribViewDelegate,UITextFieldDelegate>{
    NSArray *spotMessageArr;
#pragma mark  要穿的参数
    NSString *spotName;
    NSString *spotPrice;
    NSString *spotPerson;
    NSString *spotPhone;
    NSString *spotBasan;
    NSArray *spotSpecial;
    NSArray *spotImg;
    NSString *spotContent;
    NSString *spotAddress;
    NSString *spotFishType;
    NSString *spotProv;
    NSString *spotCity;
    NSString *spotArea;
    
}
@property (strong, nonatomic) AFHTTPSessionManager *AFManager;

@property (assign, nonatomic) BOOL isClickList;//下拉列表是点击
@property (assign, nonatomic) CGFloat ListHeight;
//
@property (strong, nonatomic) SpotTypeListView *spotListView;
@property (strong, nonatomic) SpotTextFileView *textFielView;
@property (strong, nonatomic) SpotFeatureView *spotFeatureView;
@property (strong, nonatomic) SpotAddDescribView *spotAddDesctibView;


@end

@implementation AddSpotMessageViewController
- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}

//- (SpotTypeListView *)spotListView {
//    if (!_spotListView) {
//        _spotListView = [[SpotTypeListView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 98*HeightScale) listArray:@[@"野塘",@"江河",@"湖库",@"农家乐",@"斤塘",@"黑坑",@"公园",@"海域",@"竞技池"]];
//    }
//    return _spotListView;
//}
- (SpotTextFileView *)textFielView {
    if (!_textFielView) {
        _textFielView = [[SpotTextFileView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45 * spotMessageArr.count*HeightScale) Array:spotMessageArr];
        _textFielView.delegate = self;
    }
    return _textFielView;
}
- (SpotFeatureView *)spotFeatureView {
    if (!_spotFeatureView) {
        _spotFeatureView = [[SpotFeatureView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120*HeightScale)];
        _spotFeatureView.delegate = self;
    }
    return _spotFeatureView;
}

- (SpotAddDescribView *)spotAddDesctibView {
    if (!_spotAddDesctibView) {
        _spotAddDesctibView = [[SpotAddDescribView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300*HeightScale) collectionViewBackGroundColorArr:@[@255,@255,@255] palceHoldString:nil];
        _spotAddDesctibView.delegate = self;
    }
    return _spotAddDesctibView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"塘口信息";
    self.view.backgroundColor = [UIColor whiteColor];
    spotMessageArr = @[@"塘口名称",@"塘口价格",@"塘口鱼种",@"塘口负责人",@"负责人电话",@"省市区",@"详细地址，街道"];
    
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.isClickList = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rePostData:) name:@"isClickList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getImageArr:) name:@"selectImage" object:nil];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
}
/*
 
 探长推荐塘口接口：
 test.m.yundiaoke.cn/api/partner/detidea_pond
 请求方式：POST
 参数：   uid => 用户id
 name => 塘口名称
 price => 塘口价格
 person => 塘口负责人名字
 phone => 塘口负责人电话
 basan => 塘口类型 (1=>野塘 2=>江河 3=>湖库 4=>农家乐 5=>斤塘 6=>黑坑 7=>公园 8=>海域 9=>竞技池)
 special => 塘口特色(1=>停车位 2=>餐饮 3=>住宿 4=>棋牌 5=>夜钓)
 img => 塘口图片
 content => 塘口描述
 address => 塘口地址
 fishtype => 鱼种
 
 返回值：200成功 400失败  403非法参数
 */

- (void)rightButtonAction:(UIBarButtonItem *)sender {
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = userid;
    param[@"name"] = spotName;
    param[@"price"] = spotPrice;
    param[@"person"] = spotPerson;
    param[@"phone"] = spotPhone;
    param[@"basan"] = spotBasan;
    param[@"special"] = spotSpecial;
    param[@"img"] = spotImg;
    param[@"content"] = spotContent;
    param[@"address"] = spotAddress;
    param[@"fishtype"] = spotFishType;
    param[@"prov"] = spotProv;
    param[@"city"] = spotCity;
    param[@"area"] = spotArea;
    
    
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/partner/detidea_pond"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"----+++++++%@------%@",responseObject,param);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];
    
    
   
    
}
#pragma mark  获取图片数组
- (void) getImageArr:(NSNotification *) notif {
    NSArray *array = notif.object;
    NSLog(@"notif object is:%ld",array.count);
    spotImg = notif.object;
}

#pragma mark  获取高度和点击状态
- (void)rePostData:(NSNotification *) notificat {
//    self.isClickList = YES;
//    NSLog(@"sender::::%@",notificat.object);
//    self.ListHeight = [notificat.object floatValue];
//    
//    spotBasan = notificat.userInfo[@"text"];
//    NSLog(@"spotBasan is :%@",spotBasan);
//    
//    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 1;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 45*HeightScale * spotMessageArr.count;
    }else if (indexPath.section == 1) {
//        if (self.isClickList) {
//            return self.ListHeight;
//        } else
            return 98*HeightScale;
        
    } else if (indexPath.section == 2) {
       return 120*HeightScale;
    } else if (indexPath.section == 3) {
        
        return 350*HeightScale;
    }
    else {
        return 40*HeightScale;
    }

}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if (indexPath.section == 0) {

        [cell.contentView addSubview:self.textFielView];
        
//       
    } else if (indexPath.section == 1) {
        
        if (!self.spotListView) {
            self.spotListView = [[SpotTypeListView alloc]initWithFrame:CGRectMake(0, 45*HeightScale * spotMessageArr.count + (10 + 40)*HeightScale, ScreenWidth, 98*HeightScale) listArray:@[@"野塘",@"江河",@"湖库",@"农家乐",@"斤塘",@"黑坑",@"公园",@"海域",@"竞技池"]];
        }

        [self.view addSubview:self.spotListView];
        
    } else if (indexPath.section == 2) {
        
        [cell.contentView addSubview:self.spotFeatureView];
    } else if (indexPath.section == 3) {
        
        [cell.contentView addSubview:self.spotAddDesctibView];
        
    }
    
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40*HeightScale;
    } else return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*HeightScale)];
        label.backgroundColor = RGB(234, 234, 234);
        label.textColor = RGB(135, 135, 135);
        label.text = @"请填写正确的资料信息，方便平台审核";
        return label;
    } else return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == spotMessageArr.count-2) {
            
        }
    }
}

- (void) tap:(UITapGestureRecognizer *)tap {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    self.isClickList = NO;
}

#pragma  mark ------delegate spotFeatureView----
- (void)didClickSpotStypeBtn:(UIButton *)button tag:(NSInteger)tag array:(NSArray *)array {
    NSLog(@"spotFeatureView delegate button is :%@,,,,,tag is %ld----%@",button,tag,array);
    
    spotSpecial = array;
    
}

- (void)didEditEndString:(NSString *)textString tag:(NSInteger)tag {
    NSLog(@"点击textfield textString is：%@===%ld",textString,tag);
    if (tag == 10) {
        
        spotName = textString;
        
    } else if (tag == 11) {
        
        spotPrice = textString;
        
    } else if (tag == 12) {
        
        spotFishType = textString;
        
    } else if (tag == 13) {
        
        spotPerson = textString;
        
    } else if (tag == 14) {
        
        spotPhone = textString;
    } else if (tag == 16) {
        spotAddress = textString;
    }
}
- (void)didSelectProv:(NSString *)prov city:(NSString *)city area:(NSString *)area {
    spotProv = prov;
    spotCity = city;
    spotArea = area;
    
}

- (void)didEditEndString:(NSString *)text {
    NSLog(@"输入的文字是：%@",text);
    spotContent = text;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
