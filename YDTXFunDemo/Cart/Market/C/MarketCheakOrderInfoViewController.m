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
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    //缩进
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
    //配置tableView
    tableView.delegate = self;
    tableView.dataSource =self;
    
    // 注册cell
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketCheckOrderCell class]) bundle:nil] forCellReuseIdentifier:kMarketCheckOrderCellId];
    
    
    [self.tableView registerClass:[MarketCheckOrderCell class] forCellReuseIdentifier:kMarketCheckOrderCellId];

}

-(void)setUI{

    
    
//收货地址  作为tableView的头部
    UIView *HeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, 45)];
    HeaderView.backgroundColor = [UIColor yellowColor];
    
    //作为tableView的头部
    self.tableView.tableHeaderView = HeaderView;
//    [HeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(YDTXScreenW);
//        make.height.mas_equalTo(45);
//    }];
    
    //➕imageView
    UIImageView *plusImgView = [[UIImageView alloc]init];
    plusImgView.image =[UIImage imageNamed:@"maket_checkGoods_addAddressbtn"];
    [HeaderView addSubview:plusImgView];
    [plusImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(HeaderView);
        make.leading.equalTo(HeaderView).offset(15);
        
    }];
    
    //添加新地址
    UILabel *addNewAddressLabel = [[UILabel alloc]init];
    addNewAddressLabel.text = @"添加新地址";
    addNewAddressLabel.font = [UIFont systemFontOfSize:15];
    addNewAddressLabel.textColor = [UIColor colorForHex:@"3e3e3e"];
    [HeaderView addSubview:addNewAddressLabel];
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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return 1;
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MarketCheckOrderCell *marketCheckOrderCell = [tableView dequeueReusableCellWithIdentifier:kMarketCheckOrderCellId];
    
    
    
    
    
    

    
    return marketCheckOrderCell;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 130;
    
}
@end
