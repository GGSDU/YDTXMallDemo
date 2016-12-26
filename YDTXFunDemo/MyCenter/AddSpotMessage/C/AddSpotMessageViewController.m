//
//  AddSpotMessageViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/19.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "AddSpotMessageViewController.h"

#import "SGLocationPickerView.h"

#import "SpotFeatureView.h"


@interface AddSpotMessageViewController () <SpotFeatureViewDelegate,UITextFieldDelegate>{
    NSArray *spotMessageArr;
}

@end

@implementation AddSpotMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    spotMessageArr = @[@"塘口名称",@"塘口价格",@"塘口鱼种",@"塘口负责人",@"负责人电话",@"省市区",@"详细地址，街道"];
    
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return spotMessageArr.count;
    } else return 1;
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 45*HeightScale;
    }else if (indexPath.section == 1) {
        return 120*HeightScale;
    } else {
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
        
//        if (indexPath.row == spotMessageArr.count-2) {
//            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//            button.frame = CGRectMake(10, 0, ScreenWidth, 45*HeightScale);
//            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//            
//            button.titleLabel.textAlignment = NSTextAlignmentLeft;
//            
//            [button setTitleColor:RGB(140, 140, 146) forState:UIControlStateNormal];
//            [button setTitle:spotMessageArr[indexPath.row] forState:UIControlStateNormal];
//            [cell.contentView addSubview:button];
//            
//        }else {
            UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth, 45*HeightScale)];
            textField.tag = 20+indexPath.row;
            textField.delegate = self;
            textField.placeholder = spotMessageArr[indexPath.row];
            [cell.contentView addSubview:textField];
        
        if (indexPath.row == spotMessageArr.count -2) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
            
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, ScreenWidth, textField.size.height);
            
            [textField addSubview:button];
            [button addTarget:self action:@selector(addAddressBtn:) forControlEvents:UIControlEventTouchUpInside];

            
            [textField addGestureRecognizer:tap];
        }
        
        
//
//        }
//
//       
    } else if (indexPath.section == 1) {
        SpotFeatureView *view = [[SpotFeatureView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120*HeightScale)];
        view.delegate = self;
        [cell.contentView addSubview:view];
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

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    
//    if (textField.tag-20 == spotMessageArr.count - 2) {
//      NSLog(@"省市区====");
//        SGLocationPickerView *PickerView = [[SGLocationPickerView alloc]init];
//        PickerView.MyBlock = ^(NSString *prov,NSString *city,NSString *area){
//            textField.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
//                               NSLog(@"省市区----%@%@%@",prov,city,area);
////            provs = prov;
////            citys = city;
////            areas = area;
//            [textField resignFirstResponder];
//            
//        };
//
//        
//    }
//    
//    return YES;
//}

#pragma mark 选择省市区
- (void) addAddressBtn:(UIButton *)sender {
    
   UITextField *textField = (UITextField *)sender.superview;
    NSLog(@"%ld",(long)textField.tag);
    SGLocationPickerView *PickerView = [[SGLocationPickerView alloc]init];
            PickerView.MyBlock = ^(NSString *prov,NSString *city,NSString *area){
                textField.text = [NSString stringWithFormat:@"%@%@%@",prov,city,area];
                                   NSLog(@"省市区----%@%@%@",prov,city,area);
    //            provs = prov;
    //            citys = city;
    //            areas = area;
//                [textField resignFirstResponder];
                
            };

    
}

#pragma  mark ------delegate spotFeatureView----
- (void)didClickSpotStypeBtn:(UIButton *)button tag:(NSInteger)tag {
    NSLog(@"spotFeatureView delegate button is :%@,,,,,tag is %ld",button,tag);
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
