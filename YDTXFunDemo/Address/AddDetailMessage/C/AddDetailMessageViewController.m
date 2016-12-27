//
//  AddDetailMessageViewController.m
//  ReceivingGoods
//
//  Created by 舒通 on 2016/12/6.
//  Copyright © 2016年 yundiaoke. All rights reserved.
//

#import "AddDetailMessageViewController.h"
#import "AddDetailMessageView.h"
#import "SGLocationPickerView.h"
#import "AddressListModel.h"

@interface AddDetailMessageViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) AFHTTPSessionManager *AFManager;

@property (nonatomic, assign) BOOL isDefaultStatus;//是否是默认地址

@property (nonatomic, strong) SGLocationPickerView *PickerView;//地址选择器

@property (nonatomic, strong) NSDictionary *dic;//数据源

@property (nonatomic, strong) UISwitch *Switch;

@property (nonatomic, strong) UIButton *button;//省市区的点击事件


@end

@implementation AddDetailMessageViewController
{
//    用于接收传来的省市区
    NSString *provs;
    NSString *citys;
    NSString *areas;
}
- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
        
    }
    return _AFManager;
}
//- (SGLocationPickerView *)PickerView {
//    if (!_PickerView) {
//        _PickerView = [[SGLocationPickerView alloc]init];
//    }
//    return _PickerView;
//}
- (NSDictionary *)dic {
    if (!_dic) {
        _dic = [NSMutableDictionary dictionary];
    }
    return _dic;
}

/*
 //修改收货地址显示信息
 http://test.m.yundiaoke.cn/api/user/upAddress/adres_id/1
 请求方式：get
 参数：adres_id：当前数据的ID
 返回字段：
 adres_id：数据id
 User_name：收货人名字
 Mobile：收货人电话
 Prov：省份
 City：城市
 Area：区
 Address：详细地址
 Zcode：邮编
 Status：是否设为默认收货地址，默认为0，1为设置该地址为默认地址
 200：成功，400：失败，401：数据不合法，

 */
#pragma mark 判断是添加地址还是修改地址
- (void) modificationData {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"adres_id"] = self.addressID;
    
    [self.AFManager GET:@"http://test.m.yundiaoke.cn/api/user/upAddress/" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"modification address is %@",responseObject);
//        [AddressListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        self.dic = [AddressListModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.dic = [responseObject[@"data"] copy];
        NSLog(@"self dic is :%@",self.dic);
        
        
            UITextField *textField0 = [self.view viewWithTag:10];
        textField0.text = self.dic[@"user_name"];
        UITextField *textField1 = [self.view viewWithTag:11];
        textField1.text = self.dic[@"mobile"];
        UITextField *textField2 = [self.view viewWithTag:12];
        textField2.text = [NSString stringWithFormat:@"%@%@%@",self.dic[@"prov"],self.dic[@"city"],self.dic[@"area"]];
        UITextField *textField3 = [self.view viewWithTag:13];
        textField3.text = self.dic[@"address"];
        UITextField *textField4 = [self.view viewWithTag:14];
        textField4.text = self.dic[@"zcode"];
        
            if ([self.dic[@"status"] isEqualToString:@"0"]) {
                self.Switch.on = NO;
            }else if([self.dic[@"status"] isEqualToString:@"1"]){
                self.Switch.on = YES;
            }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.view.backgroundColor = [UIColor colorWithDisplayP3Red:234.0 / 255.0 green:234.0 / 255.0 blue:234.0 / 255.0 alpha:1];
//    如果是编辑状态就读取数据
    if (self.isEdit) {
        [self modificationData];
        
    }
    [self rightBtn];
    [self creatView];
    self.isDefaultStatus = NO;

}

- (void)rightBtn {
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn:)];
    rightBtn.tintColor = [UIColor colorWithDisplayP3Red:100.0 / 255 green:200.0 / 255 blue:238.0 / 255 alpha:1];
    self.navigationItem.rightBarButtonItem = rightBtn;
}



- (void)creatView {
    
#pragma mark 提示
    UIView *reminderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 38*HeightScale)];
    reminderView.backgroundColor = [UIColor colorWithDisplayP3Red:234.0 / 255 green:234.0 / 255 blue:234.0 / 255 alpha:1];
    [self.view addSubview:reminderView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth-20, 38)];
    
    label.text = @"请正确填写您的收货地址，确保商品正确到达";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithDisplayP3Red:176.0 / 255 green:176.0 / 255 blue:176.0 / 255 alpha:1];
    [reminderView addSubview:label];
    
#pragma mark  底部视图、输入框
    NSArray *array = @[@"收货人姓名",@"手机号码",@"省市区",@"详细地址,街道,楼牌号等",@"邮编"];
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 38*HeightScale, ScreenWidth, 230*HeightScale+0.5*array.count)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backGroundView];
    
    for (int i = 0; i<array.count;i++ ) {
        NSString *placeholder = array[i];
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 46.5*HeightScale*i, ScreenWidth-20, 46*HeightScale)];
        textField.placeholder = placeholder;
        textField.tag = i+10;
        textField.delegate = self;
        textField.backgroundColor = [UIColor whiteColor];
        [backGroundView addSubview:textField];
        
        if (i == 2) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, ScreenWidth, textField.size.height);
            
            [textField addSubview:button];
            [button addTarget:self action:@selector(addAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
            self.button = button;
        }

        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 46*HeightScale+46.5*HeightScale*i, ScreenWidth, 0.5)];
        lineView.backgroundColor = [UIColor colorWithDisplayP3Red:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1];
        [backGroundView addSubview:lineView];
        
    }
    
#pragma mark  是否选中默认
    UIView *defaultView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY([self.view viewWithTag:14].frame)+56*HeightScale, ScreenWidth, 40)];
    defaultView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:defaultView];
    
    
    UILabel *defaultLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, ScreenWidth/3*2, 30)];
    defaultLabel.text = @"设为默认";
    defaultLabel.textColor = [UIColor blackColor];
    [defaultView addSubview:defaultLabel];
    
    self.Switch = [[UISwitch alloc]init];
    self.Switch.tag = 15;
    
    self.Switch.on = NO;
    
    [self.Switch addTarget:self action:@selector(Switch:) forControlEvents:UIControlEventValueChanged];
    [defaultView addSubview:self.Switch];
    [self.Switch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(defaultView.mas_right).offset(-10);
        make.centerY.mas_equalTo(defaultView.mas_centerY);
    }];
    
    
}

- (void)addAddressBtn:(UIButton *) sender {
    UITextField *textField = [self.view viewWithTag:12];
   SGLocationPickerView *PickerView = [[SGLocationPickerView alloc]init];
   PickerView.MyBlock = ^(NSString *prov,NSString *city,NSString *area){
        textField.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
//                   NSLog(@"省市区----%@%@%@",prov,city,area);
       provs = prov;
       citys = city;
       areas = area;
       
    };
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField.tag == 12) {
//        [self addAddressBtn:self.button];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    NSLog(@"textField tag is : %ld",(long)textField.tag);
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    

    
    return YES;
}
#pragma mark 保存
- (void)rightBtn:(UIBarButtonItem *)sender {

    
    UITextField *name = [self.view viewWithTag:10];
    UITextField *mobile = [self.view viewWithTag:11];
//    UITextField *prov = [self.view viewWithTag:12];
    UITextField *address = [self.view viewWithTag:13];
    UITextField *postcode = [self.view viewWithTag:14];
    
//    NSLog(@"--%@,--%@,--%@,--%@",name.text,mobile.text,address.text,postcode.text);

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"user_id"] = @"65";
    params[@"user_name"] = name.text;
    params[@"mobile"] = mobile.text;
    params[@"prov"] = provs;
    params[@"city"] = citys;
    params[@"area"] = areas;
    params[@"address"] = address.text;
    params[@"status"] = @(self.isDefaultStatus);
    params[@"zcode"] = postcode.text;

    if (self.isEdit) {
        params[@"adres_id"] = self.addressID;
        [self.AFManager POST:@"http://test.m.yundiaoke.cn/api/user/upAddress/" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"收货地址修改成功：%@",responseObject);
            if ([responseObject[@"status"] isEqual:@200]) {
                
//                NSLog(@"收货地址修改成功：%@",responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else {
        
        [self.AFManager POST:@"http://test.m.yundiaoke.cn/api/user/createRess" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject[@"status"] isEqual:@200]) {
                NSLog(@"收货地址添加成功：%@",responseObject);
                
            }else if ([responseObject[@"status"] isEqual:@403]) {
                NSLog(@"填写内容出错了");
            } else if ([responseObject[@"status"] isEqual:@4001]) {
                NSLog(@"添加地址不能超过5个");
            }
            
            //        200：成功，400：失败,403：非法参数
            //        4001为'该用户添加的地址已经超标！
            
            
            
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"收货地址添加失败：%@",error);
        }];
    }
    
//
    
    
}

#pragma mark Switch on status
- (void)Switch :(UISwitch *) Switch {
    self.isDefaultStatus = Switch.on;
    if (Switch.on) {
        NSLog(@"Switch on is %d",Switch.on);
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
