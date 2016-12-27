//
//  AddActionMessageTableViewController.m
//  
//
//  Created by 舒通 on 2016/12/21.
//
//

#import "AddActionMessageTableViewController.h"

#import "SpotTypeListView.h"
#import "SpotTextFileView.h"
#import "SpotAddDescribView.h"


@interface AddActionMessageTableViewController ()<SpotTextFileViewDelegate,SpotAddDescribViewDelegate>
{
    NSArray *actionMessageArr;
    
    /*
     type: 1-钓鱼 2-露营 3-徒步 4-其他
     name-活动名称
     person
     mobile
     content-活动内容
     */
    NSString *actionType;
    NSString *actionName;
    NSString *actionPerson;
    NSString *actionMobile;
    NSString *actionContent;
    
}

@property (strong, nonatomic) SpotTypeListView *spotListView;
@property (assign, nonatomic) BOOL isClickList;//下拉列表是点击
@property (assign, nonatomic) CGFloat ListHeight;//获取到的列表高度

@property (strong, nonatomic) SpotTextFileView *textFielView;
@property (strong, nonatomic) SpotAddDescribView *spotAddDesctibView;


@property (strong, nonatomic) AFHTTPSessionManager *AFManager;

@end

@implementation AddActionMessageTableViewController

- (AFHTTPSessionManager *)AFManager {
    if (!_AFManager) {
        _AFManager = [AFHTTPSessionManager manager];
    }
    return _AFManager;
}

- (SpotTypeListView *)spotListView {
    if (!_spotListView) {

        _spotListView = [[SpotTypeListView alloc]initWithFrame:CGRectMake(0, 40*HeightScale, ScreenWidth, 98*HeightScale) listArray:@[@"钓鱼",@"露营",@"徒步",@"其他"]];
    }
//    钓鱼 露营 徒步 其他
    return _spotListView;
}


- (SpotTextFileView *)textFielView {
    if (!_textFielView) {
        _textFielView = [[SpotTextFileView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45 * actionMessageArr.count*HeightScale) Array:actionMessageArr];
        _textFielView.delegate = self;
    }
    return _textFielView;
}

- (SpotAddDescribView *)spotAddDesctibView {
    if (!_spotAddDesctibView) {
        _spotAddDesctibView = [[SpotAddDescribView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 400*HeightScale) collectionViewBackGroundColorArr:nil palceHoldString:@"如时间、地点、适合人群、活动行程、活动亮点、建议价格、装备要求等"];
        _spotAddDesctibView.delegate = self;
    }
    return _spotAddDesctibView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动信息";
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    actionMessageArr = @[@"活动名称",@"联系人",@"手机号"];
    self.isClickList = NO;
//    注册一个通知 获取高度
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rePostData:) name:@"isClickList" object:nil];
    
    [self creatRightBtn];
    
}
/*
 test.m.yundiaoke.cn/api/partner/detidea_act
 post
 
 uid
 type: 1-钓鱼 2-露营 3-徒步 4-其他
 name-活动名称
 person
 mobile
 content-活动内容
 
 */
- (void) rePostData:(NSNotification *)notif {
    self.isClickList = YES;
    self.ListHeight = [notif.object floatValue];
    
    actionType = notif.userInfo[@"text"];
    
    [self.tableView reloadData];
}

#pragma mark rightBtn
- (void)creatRightBtn {
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)rightAction:(UIBarButtonItem *)sender {
    
    NSString *userid = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"uid"] = userid;
    param[@"type"] = actionType;
    param[@"name"] = actionName;
    param[@"person"] = actionPerson;
    param[@"mobile"] = actionMobile;
    param[@"content"] = actionContent;
    
    [self.AFManager POST:[postHttp stringByAppendingString:@"api/partner/detidea_act"] parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"_+_+_+:%@_+_+__+_+%@",responseObject,param);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"哎啊，出错了"];
    }];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//        if (self.isClickList) {
//            return self.ListHeight;
//        } else
            return 98*HeightScale;
    }
    else if (indexPath.section == 1)
    {
        return 135*HeightScale;
    }
    else return 400*HeightScale;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.section == 0) {
        [self.view addSubview:self.spotListView];
        
        
    } else if (indexPath.section == 1) {
        [cell.contentView addSubview:self.textFielView];
    } else if (indexPath.section == 2) {
        [cell.contentView addSubview:self.spotAddDesctibView];
    }
    
    // Configure the cell...
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 40*HeightScale)];
        label.backgroundColor = RGB(234, 234, 234);
        label.textColor = RGB(135, 135, 135);
        label.text = @"请填写正确的资料信息，方便平台审核";
        return label;
    }else return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 40*HeightScale;
    } else return 0.001;
}


#pragma mark  delegate
- (void)didEditEndString:(NSString *)textString tag:(NSInteger)tag {
    if (tag == 10) {
        
        actionName = textString;
        
    } else if (tag == 11) {
        
        actionPerson = textString;
        
    } else if (tag == 12) {
        
        actionMobile = textString;
        
    }
    
    NSLog(@"textString is :%@,tag is :%ld",textString,tag);
}

- (void)didEditEndString:(NSString *)text {
    NSLog(@"text context is :%@",text);
    actionContent = text;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
