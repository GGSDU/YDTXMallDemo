//
//  EquityTableViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/14.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "EquityTableViewController.h"
#import "EquityModel.h"


#import "EquityWithMeViewController.h"


@interface EquityTableViewController ()

@property (nonatomic, strong) NSMutableArray *equityTypeArr;
@property (nonatomic, strong) NSMutableArray *datasource;

@property (nonatomic, strong) AFHTTPSessionManager *AFManeger;


@end



@implementation EquityTableViewController
- (NSMutableArray *)equityTypeArr {
    if (!_equityTypeArr) {
        _equityTypeArr = [NSMutableArray array];
        
    }
    return _equityTypeArr;
}
- (NSMutableArray *)datasource {
    if (!_datasource) {
        _datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (AFHTTPSessionManager *)AFManeger {
    if (!_AFManeger) {
        _AFManeger = [AFHTTPSessionManager manager];
    }
    return _AFManeger;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的权益";
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    [self.equityTypeArr addObjectsFromArray:
                                            @[@"活动合伙人/年费型/单人",
                                              @"活动合伙人/年费型/家庭",
                                              @"活动合伙人/创业型",
                                              @"塘口合伙人/单塘",
                                              @"塘口合伙人/全国",
                                              @"探长合伙人/初级探长",
                                              @"探长合伙人/高级探长",
                                              @"探长合伙人/荣誉探长"]];

    [self loadNewData];
}

- (void)loadNewData {
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = userid;
    
    [self.AFManeger GET:[postHttp stringByAppendingString:@"api/partner/ispartner"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"合伙人标签数据请求成功：%@",responseObject);
        
//        for (NSDictionary *dic in responseObject) {
            EquityModel *model = [[EquityModel alloc]initData:responseObject];
            [self.datasource addObject:model];
//        }
        
//        [self updateStatusWithDataArr:self.datasource];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"合伙人标签数据请求失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    if (self.datasource.count > 0) {
        
        EquityModel *model = self.datasource[0];
        return model.data.count;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45*HeightScale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.equityTypeArr[indexPath.section];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    

    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = RGB(134, 134, 134);
    
    if (self.datasource.count >0) {
        EquityModel *model =self.datasource[0];
        NSLog(@"model data is :%@",model.data[indexPath.section]);
        if ([model.data[indexPath.section] isEqual:@1]) {
            cell.textLabel.textColor = [UIColor blackColor];
        }
        
    }
 
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    EquityModel *model =self.datasource[0];
    
    if ([model.data[indexPath.section] isEqual:@1]) {
        
        EquityWithMeViewController *equityWithMeVC = [[EquityWithMeViewController alloc]init];
        equityWithMeVC.equityType = [NSString stringWithFormat:@"%ld",indexPath.section];
        [self.navigationController pushViewController:equityWithMeVC animated:YES];
    }
    NSLog(@"indexpath section text:%@",cell.textLabel.textColor);
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
