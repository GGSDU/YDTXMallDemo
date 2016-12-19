//
//  OrderDrawBackViewController.m
//  YDTXFunDemo
//
//  Created by 舒通 on 2016/12/16.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "OrderDrawBackViewController.h"
#import "OrderDrawBackView.h"

#import "Order_DrawBackStatusListTableViewController.h"



@interface OrderDrawBackViewController ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table 下拉列表的高度
    CGFloat frameHeight;//frame 的高度
    
}

@property (retain, nonatomic) UITableView *tv;//x下拉列表
@property (retain, nonatomic) NSArray *tableArray;//下拉列表数据

//@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (strong, nonatomic) UITextView *textView;
@property (strong, nonatomic) UIButton *button;



@property (strong, nonatomic) UILabel *statusMessage;

@property (assign, nonatomic) BOOL isTap;

@property (strong, nonatomic) Order_DrawBackStatusListTableViewController *drawBackStatus;

@end

@implementation OrderDrawBackViewController

//- (UIView *)drawBackStatusBackGroundView {
//    if (!_drawBackStatusBackGroundView) {
//        _drawBackStatusBackGroundView = [[UIView alloc]init];
//        _drawBackStatusBackGroundView.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:_drawBackStatusBackGroundView];
//        
//        [_drawBackStatusBackGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.view.mas_top).offset(18*HeightScale);
//            make.left.mas_equalTo(self.view.mas_left).offset(10*WidthScale);
//            make.width.mas_equalTo(ScreenWidth-20*WidthScale);
//            make.height.mas_equalTo(40*HeightScale);
//        }];
//    }
//    return _drawBackStatusBackGroundView;
//}


//- (UITextView *)textView {
//    if (!_textView) {
//        _textView = [[UITextView alloc]init];
//        _textView.backgroundColor = [UIColor whiteColor];
//        _textView.delegate = self;
//        _textView.font = [UIFont systemFontOfSize:15*HeightScale];
//        [self.view addSubview:_textView];
//        [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.drawBackStatus.view.mas_bottom).offset(20*HeightScale);
//            make.left.mas_equalTo(self.drawBackStatus.view.mas_left);
//            make.width.mas_equalTo(self.drawBackStatus.view.mas_width);
//            make.height.mas_equalTo(40*HeightScale);
//        }];
//    }
//
//    return _textView;
//}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setImage:[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"] forState:UIControlStateNormal];
        [self.view addSubview:_button];
        
//        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self.textView.mas_left);
//            make.size.mas_equalTo(CGSizeMake(50, 50));
//            make.top.mas_equalTo(self.textView.mas_bottom).offset(20*HeightScale);
//        }];
        
    }
    return _button;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self creatDrawListView];
    
    self.isTap = NO;
//    [self loadNewData];
    [self creatView];
    
//    [self creatListView];
    
    
}

- (void) creatDrawListView {
    self.drawBackStatus = [[Order_DrawBackStatusListTableViewController alloc]init];
    self.drawBackStatus.view.frame = CGRectMake(10*WidthScale, 18*HeightScale, ScreenWidth-20*WidthScale, 40*HeightScale);
//    self.drawBackStatus.viewFrame = self.drawBackStatus.view.frame;
    
    [self.view addSubview:self.drawBackStatus.view];
    self.view.backgroundColor = [UIColor yellowColor];
    
}

#pragma mark  创建下拉列表视图
- (void) creatListView {
    showList = NO;//默认不显示下拉框
    
    self.tv = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    self.tv.backgroundColor = [UIColor grayColor];
    self.tv.separatorColor = [UIColor grayColor];
    self.tv.hidden = YES;
    
    [self.view addSubview:self.tv];
    
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.drawBackStatus.view.mas_bottom);
        make.left.mas_equalTo(self.drawBackStatus.view.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-20*HeightScale, 40*HeightScale));
    }];

}

- (void)loadNewData {

    
   self.tableArray = @[@"已收货",@"未收货"];
    
    
}

#pragma mark 退款状态提示文字

- (void) creatView {
    
//    UILabel *statusReminder = [[UILabel alloc]init];
//    statusReminder.text = @"申请状态";
//    statusReminder.textColor = RGB(150, 150, 150);
//    [statusReminder sizeToFit];
//    
//    statusReminder.textAlignment = NSTextAlignmentCenter;
//    statusReminder.font = [UIFont systemFontOfSize:15*HeightScale];
//    [self.self.drawBackStatus.view addSubview:statusReminder];
//    [statusReminder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.self.drawBackStatus.view.mas_left).offset(10*WidthScale);
//        make.top.mas_equalTo(self.self.drawBackStatus.view.mas_top);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(self.self.drawBackStatus.view.mas_height);
//    }];
//    
//    self.statusMessage = [[UILabel alloc]init];
//
//    self.statusMessage.font = [UIFont systemFontOfSize:15*HeightScale];
//    self.statusMessage.textColor = RGB(25, 25, 25);
//    self.statusMessage.userInteractionEnabled = YES;
//    [self.self.drawBackStatus.view addSubview:self.statusMessage];
//    
//    [self.statusMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(statusReminder.mas_right).offset(10);
//        make.top.mas_equalTo(statusReminder.mas_top);
//        make.right.mas_equalTo(self.self.drawBackStatus.view.mas_right);
//        make.height.mas_equalTo(self.self.drawBackStatus.view.mas_height);
//    }];
//    
////    添加手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dropdown)];
//    [self.statusMessage addGestureRecognizer:tap];
//    
    
//    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.textView.mas_left);
//        make.size.mas_equalTo(CGSizeMake(50, 50));
//        make.top.mas_equalTo(self.textView.mas_bottom).offset(20*HeightScale);
//    }];
}
#pragma mark   改变输入视图的frame
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(200*HeightScale);
    }];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (textView.text.length > 0) {
        
    } else {
        [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40*HeightScale);
        }];

    }
    
    
    return YES;
}


#pragma 下拉列表的点击事件
- (void)dropdown {
    
    self.isTap = !self.isTap;
    
    if (showList) {//如果下拉框已显示，什么都不做
        return;
    } else { //如果下拉框尚未显示，则进行显示
        if (self.isTap) {
     //        把dropdownList放到前面，放置下拉框被别的控制器遮住
            [self.view bringSubviewToFront:self.tv];
            
            self.tv.hidden = NO;
            showList = YES;
            [UIView animateWithDuration:0.025 animations:^{
                
                [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
                }];
            }];
        }else {
            [UIView animateWithDuration:0.025 animations:^{
                
                [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
                }];
            }];
        }
       
       
    }
    
}

#pragma mark  下拉列表的视图
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
    self.statusMessage.text = self.tableArray[indexPath.row];
    showList = NO;
    self.tv.hidden = YES;
    
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }];
    
    
}  
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    
    showList = NO;
    self.tv.hidden = YES;
    [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
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
