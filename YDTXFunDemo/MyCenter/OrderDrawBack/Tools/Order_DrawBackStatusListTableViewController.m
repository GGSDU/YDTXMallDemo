//
//  Order_DrawBackStatusListTableViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/19.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "Order_DrawBackStatusListTableViewController.h"

@interface Order_DrawBackStatusListTableViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table 下拉列表的高度
    CGFloat frameHeight;//frame 的高度
    
}
@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (retain, nonatomic) UITableView *tv;//x下拉列表
@property (retain, nonatomic) NSArray *tableArray;//下拉列表数据
@property (strong, nonatomic) UILabel *statusMessage;

@end

@implementation Order_DrawBackStatusListTableViewController

- (UIView *)drawBackStatusBackGroundView {
    if (!_drawBackStatusBackGroundView) {
        _drawBackStatusBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-20*HeightScale, 40*HeightScale)];
        _drawBackStatusBackGroundView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_drawBackStatusBackGroundView];
        self.view.layer.borderColor = [UIColor blueColor].CGColor;
        self.view.layer.borderWidth = 2;
        
//        [_drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.view.mas_top).offset(18*HeightScale);
//            make.left.mas_equalTo(self.view.mas_left).offset(10*WidthScale);
//            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
//            make.height.mas_equalTo(40*HeightScale);
//        }];
    }
    return _drawBackStatusBackGroundView;
}




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (!CGRectEqualToRect(self.viewFrame, CGRectNull)) {
//        NSLog(@"appear self.viewframe width is %f,height is %f",self.viewFrame.size.width,self.viewFrame.size.height);

//        self.view.frame = self.viewFrame;
//    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"didload self.viewframe width is %f,height is %f",self.viewFrame.size.width,self.viewFrame.size.height);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self creatListView];
    [self creatView];
    [self loadNewData];
}

- (void) creatListView {
    showList = NO;//默认不显示下拉框
    
    self.tv = [[UITableView alloc]initWithFrame:CGRectMake(10*HeightScale, CGRectGetMaxY(self.view.bounds), ScreenWidth - 20*WidthScale, 0*HeightScale) style:UITableViewStyleGrouped];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    self.tv.backgroundColor = [UIColor grayColor];
    self.tv.separatorColor = [UIColor grayColor];
    self.tv.hidden = YES;
    
    
    
    [self.view addSubview:self.tv];
    
    
}

- (void)loadNewData {
    
    NSMutableDictionary *mulDic = [NSMutableDictionary dictionary];
    [mulDic setObject:[NSArray arrayWithObjects:@"15000000", @"/MHz"    , nil] forKey:@"蜂窝公众通信（全国网）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"15000000", @"/MHz"    , nil] forKey:@"蜂窝公众通信（非全国网）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"50000",    @"每频点"   , nil] forKey:@"集群无线调度系统（全国范围使用）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"10000",    @"每频点"   , nil] forKey:@"集群无线调度系统（省、自治区、直辖市范围使用）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"2000",     @"每频点"   , nil] forKey:@"集群无线调度系统（地、市范围使用）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"2000000",  @"每频点"   , nil] forKey:@"无线寻呼系统（全国范围使用）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"2000000",  @"每频点"   , nil] forKey:@"无线寻呼系统（省、自治区、直辖市范围使用"];
    [mulDic setObject:[NSArray arrayWithObjects:@"40000",    @"每频点"   , nil] forKey:@"无线寻呼系统（地、市范围使用）"];
    [mulDic setObject:[NSArray arrayWithObjects:@"150",      @"每基站"   , nil] forKey:@"无绳电话系统"];
    
    self.tableArray = [mulDic allKeys];
    
    
}
- (void) creatView {
    
    UILabel *statusReminder = [[UILabel alloc]init];
    statusReminder.text = @"申请状态";
    statusReminder.textColor = RGB(150, 150, 150);
    [statusReminder sizeToFit];
    
    statusReminder.textAlignment = NSTextAlignmentCenter;
    statusReminder.font = [UIFont systemFontOfSize:15*HeightScale];
    [self.drawBackStatusBackGroundView addSubview:statusReminder];
    [statusReminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.drawBackStatusBackGroundView.mas_left).offset(10*WidthScale);
        make.top.mas_equalTo(self.drawBackStatusBackGroundView.mas_top);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(self.drawBackStatusBackGroundView.mas_height);
    }];
    
//    UILabel *statusMessage = [[UILabel alloc]init];
//    
//    statusMessage.font = [UIFont systemFontOfSize:15*HeightScale];
//    statusMessage.textColor = RGB(25, 25, 25);
//    statusReminder.userInteractionEnabled = YES;
//    [self.drawBackStatusBackGroundView addSubview:statusMessage];
//    [statusMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(statusReminder.mas_right).offset(10);
//        make.top.mas_equalTo(statusReminder.mas_top);
//        make.right.mas_equalTo(self.view.mas_right).offset(-10);
//        make.height.mas_equalTo(self.drawBackStatusBackGroundView.mas_height);
//    }];
//    self.statusMessage = statusMessage;
//    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dropdown)];
////    [self.drawBackStatusBackGroundView addGestureRecognizer:tap];
//    [statusMessage addGestureRecognizer:tap];
    
    UIButton *statusButton = [[UIButton alloc] init];
    [statusButton setTitleColor:RGB(25, 25, 25) forState:UIControlStateNormal];
    [statusButton addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
    [self.drawBackStatusBackGroundView addSubview:statusButton];
    [statusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(statusReminder.mas_right).offset(10);
        make.top.mas_equalTo(statusReminder.mas_top);
        make.right.mas_equalTo(self.view.mas_right).offset(-10);
        make.height.mas_equalTo(self.drawBackStatusBackGroundView.mas_height);
    }];
    
    NSLog(@"here to create button");
    
    
    self.drawBackStatusBackGroundView.layer.borderColor = [UIColor redColor].CGColor;
    self.drawBackStatusBackGroundView.layer.borderWidth = 2;
    statusButton.layer.borderColor = [UIColor greenColor].CGColor;
    statusButton.layer.borderWidth = 2;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dropdown {
    
    
    
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    } else { //如果下拉框尚未显示，则进行显示
        
        //        把dropdownList放到前面，放置下拉框被别的控制器遮住
        [self.view bringSubviewToFront:self.tv];
        
        self.tv.hidden = NO;
        showList = YES;
        [UIView animateWithDuration:0.025 animations:^{
            [UIView animateWithDuration:0.025 animations:^{
                [self.tv setHeight:self.tableArray.count * 40*HeightScale];
            }];
//            [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
//            }];
        }];
    }
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = self.tableArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:12*HeightScale];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40*HeightScale;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    self.statusMessage.text = self.tableArray[indexPath.row]; 返回一个值给上个控制器
    
    showList = NO;
    self.tv.hidden = YES;
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv setHeight:0];
    }];
//    [UIView animateWithDuration:0.025 animations:^{
//        [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(0);
//        }];
//    }];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    showList = NO;
    self.tv.hidden = YES;
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv setHeight:0];
    }];
    
//    [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(0);
//    }];
    
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
