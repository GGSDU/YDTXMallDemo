//
//  MarketCheakOrderInfoViewController.m
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketCheakOrderInfoViewController.h"
#import "MarketCheckOrderCell.h"
@interface MarketCheakOrderInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView;

@end

static NSString *kMarketCheckOrderCellId = @"MarketCheckOrderCell";

@implementation MarketCheakOrderInfoViewController
//Lazy
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setUI];
}

-(void)setBasic{
    
    //导航标题
    self.title = @"确认订单";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    //缩进
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    //配置tableView
    tableView.delegate = self;
    tableView.dataSource =self;
    
    // 注册cell
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketCheckOrderCell class]) bundle:nil] forCellReuseIdentifier:kMarketCheckOrderCellId];
    
    
    [self.tableView registerClass:[MarketCheckOrderCell class] forCellReuseIdentifier:kMarketCheckOrderCellId];

}

-(void)setUI{

    
    
//收货地址  作为tableView的头部
    UIView *HeaderBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 65)];
    HeaderBaseView.backgroundColor = [UIColor colorForHex:@"eeeeee"];
    
    //作为tableView的头部
    self.tableView.tableHeaderView = HeaderBaseView;

    
    //收货地址View   //手势
    UIView *addressView = [[UIView alloc]init];
    addressView.backgroundColor = [UIColor whiteColor];
    [HeaderBaseView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(HeaderBaseView);
        make.height.mas_equalTo(45);
        make.leading.equalTo(HeaderBaseView);
        make.trailing.equalTo(HeaderBaseView);
    }];
    
    UITapGestureRecognizer *JumpToAddressListGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JumpToAddressList)];
    [addressView addGestureRecognizer:JumpToAddressListGes];
    
    
    
    
    //➕imageView
    UIImageView *plusImgView = [[UIImageView alloc]init];
    plusImgView.image =[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"];
    [addressView addSubview:plusImgView];
    [plusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addressView);
        make.leading.equalTo(addressView).offset(15);
        
    }];
    
    //添加新地址
    UILabel *addNewAddressLabel = [[UILabel alloc]init];
    addNewAddressLabel.text = @"添加新地址";
    addNewAddressLabel.font = [UIFont systemFontOfSize:15];
    addNewAddressLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    [addressView addSubview:addNewAddressLabel];
    [addNewAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(plusImgView);
        make.leading.equalTo(plusImgView.mas_trailing).offset(10);
    }];
    
    
//底部结算View
    UIView *toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor redColor];
    toolView.layer.borderWidth = 0.5;
    toolView.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(YDTXScreenW, 50));
        
    }];
    
    //提交订单btn
    UIButton *summitOrderBtn = [[UIButton alloc]init];
    [summitOrderBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [summitOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [summitOrderBtn setBackgroundColor:[UIColor orangeColor]];
    summitOrderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [toolView addSubview:summitOrderBtn];
    [summitOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolView);
        make.trailing.equalTo(toolView);
        make.height.equalTo(toolView);
        make.width.mas_equalTo(100);
    }];
    
    
    //结算Label
    UILabel *settleAccountLabel = [[UILabel alloc]init];
    settleAccountLabel.backgroundColor = [UIColor whiteColor];
    settleAccountLabel.font = [UIFont systemFontOfSize:15];
    settleAccountLabel.text = @"合计：¥108";
    settleAccountLabel.textAlignment = NSTextAlignmentRight;
    
    //处理富文本
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:settleAccountLabel.text];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor orangeColor]
                    range:NSMakeRange(3, settleAccountLabel.text.length - 3)];
    settleAccountLabel.attributedText = attrStr;
  
    [toolView addSubview:settleAccountLabel];
    [settleAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(toolView);
        make.top.equalTo(toolView);
        make.bottom.equalTo(toolView);
        make.trailing.equalTo(summitOrderBtn.mas_leading).offset(-15);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//提交订单
-(void)summitOrder{


    NSLog(@"提交订单");
}

#pragma mark -TableView delegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MarketCheckOrderCell *marketCheckOrderCell = [tableView dequeueReusableCellWithIdentifier:kMarketCheckOrderCellId];
    
    

    
    return marketCheckOrderCell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 330;
    
}

#pragma mark --Gesture Method
-(void)JumpToAddressList{

    NSLog(@"-JumpToAddressList-");

}
@end
