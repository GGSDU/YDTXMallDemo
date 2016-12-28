//
//  MarketCheakOrderInfoViewController.m
//  market
//
//  Created by RookieHua on 2016/12/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketCheakOrderInfoViewController.h"
#import "MarketCheckOrderCell.h"
#import "PayWayView.h"
#import "ReceiveTableViewCell.h"
@interface MarketCheakOrderInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UIView *HeaderBaseView;
@property(strong,nonatomic)NSMutableArray *OrderDataArr;
@property(strong,nonatomic)UILabel *settleAccountLabel;

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
//
-(NSArray *)OrderDataArr{
    if (!_OrderDataArr) {
        _OrderDataArr = [NSMutableArray array];
    }
    return _OrderDataArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    
    [self setUIWithTotalPrice:_totalPrice];
    
    [self updateAddressInfo];
}

-(void)updateAddressInfo{


    [[NetWorkService shareInstance]requestForDefaultAddressWithUser_id:@"65" responseBlock:^(Boolean hasDefault,AddressListModel *addressListModel) {
        
        
        NSLog(@"---%hhu",hasDefault);
        if (hasDefault == YES) {
            

            //收货地址  作为tableView的头部
            _HeaderBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 120)];
            _HeaderBaseView.backgroundColor = [UIColor colorForHex:@"eeeeee"];
           
            UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"market_CheckOrder_AddressBackground"]];
            [_HeaderBaseView addSubview:imgView];

            [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_HeaderBaseView);
                make.right.equalTo(_HeaderBaseView);
                make.centerY.equalTo(_HeaderBaseView);
            }];

            //作为tableView的头部
            _tableView.tableHeaderView = _HeaderBaseView;
            [_tableView.tableHeaderView layoutIfNeeded];
            

        }else if (hasDefault == 0){
        
            //收货地址  作为tableView的头部
            _HeaderBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 65)];
            _HeaderBaseView.backgroundColor = [UIColor colorForHex:@"eeeeee"];
            
            //作为tableView的头部
            self.tableView.tableHeaderView = _HeaderBaseView;
            
            //收货地址View   //手势
            UIView *addressView = [[UIView alloc]init];
            addressView.backgroundColor = [UIColor whiteColor];
            [_HeaderBaseView addSubview:addressView];
            [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(_HeaderBaseView);
                make.height.mas_equalTo(45);
                make.leading.equalTo(_HeaderBaseView);
                make.trailing.equalTo(_HeaderBaseView);
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
            

        
        
        }
    }];
    

}



-(void)setBasic{
    
    //导航标题
    self.title = @"确认订单";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
    //缩进
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    
    //配置tableView
    tableView.delegate = self;
    tableView.dataSource =self;
    
    // 注册cell
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketCheckOrderCell class]) bundle:nil] forCellReuseIdentifier:kMarketCheckOrderCellId];
    
    
    [self.tableView registerClass:[MarketCheckOrderCell class] forCellReuseIdentifier:kMarketCheckOrderCellId];

}

-(void)setUIWithTotalPrice:(CGFloat)totalPrice{

    
    
////收货地址  作为tableView的头部
//    _HeaderBaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 65)];
//    _HeaderBaseView.backgroundColor = [UIColor colorForHex:@"eeeeee"];
//    
//    //作为tableView的头部
//    self.tableView.tableHeaderView = _HeaderBaseView;
//
//    //收货地址View   //手势
//    UIView *addressView = [[UIView alloc]init];
//    addressView.backgroundColor = [UIColor whiteColor];
//    [_HeaderBaseView addSubview:addressView];
//    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_HeaderBaseView);
//        make.height.mas_equalTo(45);
//        make.leading.equalTo(_HeaderBaseView);
//        make.trailing.equalTo(_HeaderBaseView);
//    }];
//    
//    UITapGestureRecognizer *JumpToAddressListGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(JumpToAddressList)];
//    [addressView addGestureRecognizer:JumpToAddressListGes];
//    
//    
//    
//    
//    //➕imageView
//    UIImageView *plusImgView = [[UIImageView alloc]init];
//    plusImgView.image =[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"];
//    [addressView addSubview:plusImgView];
//    [plusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(addressView);
//        make.leading.equalTo(addressView).offset(15);
//        
//    }];
//    
//    //添加新地址
//    UILabel *addNewAddressLabel = [[UILabel alloc]init];
//    addNewAddressLabel.text = @"添加新地址";
//    addNewAddressLabel.font = [UIFont systemFontOfSize:15];
//    addNewAddressLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
//    [addressView addSubview:addNewAddressLabel];
//    [addNewAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(plusImgView);
//        make.leading.equalTo(plusImgView.mas_trailing).offset(10);
//    }];
    
    
//底部结算View
    UIView *toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor whiteColor];
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
    [summitOrderBtn setBackgroundColor:[UIColor colorForHex:@"ff5b02"]];
    summitOrderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [summitOrderBtn addTarget:self action:@selector(summitOrder) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:summitOrderBtn];
    [summitOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolView);
        make.trailing.equalTo(toolView);
        make.height.equalTo(toolView);
        make.width.mas_equalTo(100);
    }];
    
    
    //结算Label
    _settleAccountLabel = [[UILabel alloc]init];
    _settleAccountLabel.backgroundColor = [UIColor whiteColor];
    _settleAccountLabel.font = [UIFont systemFontOfSize:15];
    _settleAccountLabel.text = [NSString stringWithFormat:@"合计：¥%.2f",totalPrice];
    _settleAccountLabel.textAlignment = NSTextAlignmentRight;
    
    //处理富文本
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_settleAccountLabel.text];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:[UIColor orangeColor]
                    range:NSMakeRange(3, _settleAccountLabel.text.length - 3)];
    _settleAccountLabel.attributedText = attrStr;
  
    [toolView addSubview:_settleAccountLabel];
    [_settleAccountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(toolView);
        make.top.equalTo(toolView);
        make.bottom.equalTo(toolView);
        make.trailing.equalTo(summitOrderBtn.mas_leading).offset(-15);
    }];
    
    
    


    
//支付方式
    PayWayView *payView = [[PayWayView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 90)];
    
    
    
    self.tableView.tableFooterView = payView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//提交订单
-(void)summitOrder{

    NSLog(@"提交订单");
    
    PayWayView *payWayView = (PayWayView *)self.tableView.tableFooterView;
    
    if (payWayView.payType == isAliPay) {
        
        NSLog(@"-AliPay-");
    }else if (payWayView.payType == isWePay){
    
        NSLog(@"-WePay-");
    }else{
    
        NSLog(@"未选择支付方式");
       
        [RHNotiTool NotiShowErrorWithTitle:@"请选择支付方式" Time:1.0];
    
    }
    
    
}

#pragma mark -TableView delegate Method


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _OrderDataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MarketCheckOrderCell *marketCheckOrderCell = [tableView dequeueReusableCellWithIdentifier:kMarketCheckOrderCellId];
    marketCheckOrderCell.cartProductModel = _OrderDataArr[indexPath.row];
    return marketCheckOrderCell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 330;
    
}

#pragma mark -- Deal Data Method

-(void)updateCheckVCWithDataArr:(NSArray *)DataArr{

    _OrderDataArr = [NSMutableArray array];
    [_OrderDataArr removeAllObjects];
    [_OrderDataArr addObjectsFromArray:DataArr];
    [_tableView reloadData];
    

}


#pragma mark --Gesture Method
-(void)JumpToAddressList{

    NSLog(@"-JumpToAddressList-");

}
@end
