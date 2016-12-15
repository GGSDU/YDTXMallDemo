//
//  MarketDetailViewController.m
//  market
//
//  Created by RookieHua on 2016/12/5.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketDetailViewController.h"

#import "MarketDetailCell.h"
#import "MarketMaskView.h"
#import "CartViewController.h"
#import "SDCycleDispalyView.h"
@interface MarketDetailViewController ()<UITableViewDataSource,UITableViewDelegate,reMoveAnimationDelegate>

@property(strong,nonatomic)UITableView *tableView ;

@property(strong,nonatomic)MarketMaskView *maskView;
@end




static NSString *kMarketDetialCellId = @"marketDetailCell";
@implementation MarketDetailViewController

//-(MarketMaskView *)maskView{
//    if (_maskView) {
//        _maskView = [[MarketMaskView alloc]init];
//    }
//    return _maskView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self setBasic];
}
-(void)setBasic{
    
    //nav标题  商品详情
    self.title = @"商品详情";
    //导航右边的购物车
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"market_cart_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(JumpToCartVC)];
    
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    //基本设置
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // 注册
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketDetailCell class]) bundle:nil] forCellReuseIdentifier:kMarketDetialCellId];
    
    

}
-(void)setUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
  
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    
//头部底层view
    UIView *headBaseView  =[[UIView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, YDTXScreenW + 200)];
    
    headBaseView.backgroundColor = [UIColor whiteColor];
   tableView.tableHeaderView = headBaseView;
//轮播
    SDCycleDispalyView *bannerView  =[[SDCycleDispalyView alloc]initWithFrame:CGRectMake(0, 0, YDTXScreenW, YDTXScreenW )];
    
//    bannerView.backgroundColor = [UIColor greenColor];
    
    [headBaseView addSubview:bannerView];
//商品名Label
    UILabel *goodsTitleLabel = [[UILabel alloc]init];
    goodsTitleLabel.numberOfLines = 2;
    goodsTitleLabel.font = [UIFont systemFontOfSize:18];
    goodsTitleLabel.textColor = [UIColor colorForHex:@"2f2f2f"];
    goodsTitleLabel.text = @"hahhahahahaahhahhahahahaahhahhaha";
    [headBaseView addSubview:goodsTitleLabel];
    [goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(bannerView).offset(15);
        make.top.equalTo(bannerView.mas_bottom).offset(15);
        make.trailing.equalTo(bannerView).offset(-10);
        
    }];
    
//价格Label
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.numberOfLines = 1;
    priceLabel.font = [UIFont systemFontOfSize:18];
    priceLabel.textColor = [UIColor colorForHex:@"f13e3a"];
    priceLabel.text = @"¥108";
    [headBaseView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(bannerView).offset(15);
        make.top.equalTo(goodsTitleLabel.mas_bottom).offset(18);
        
        
    }];

    
//会员价格Label
    UILabel *vipPriceLabel = [[UILabel alloc]init];
    vipPriceLabel.numberOfLines = 1;
    vipPriceLabel.font = [UIFont systemFontOfSize:18];
    vipPriceLabel.textColor = [UIColor colorForHex:@"fc9512"];
    vipPriceLabel.text = @"会员价：¥98";
    [headBaseView addSubview:vipPriceLabel];
    [vipPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(priceLabel).offset(60);
        make.top.equalTo(goodsTitleLabel.mas_bottom).offset(18);
        
        
    }];
    
    
//库存Label
    UILabel *stockLabel = [[UILabel alloc]init];
    stockLabel.numberOfLines = 1;
    stockLabel.font = [UIFont systemFontOfSize:12];
    stockLabel.textColor = [UIColor colorForHex:@"3f3f3f"];
    stockLabel.text = @"商家库存1000件";
    [headBaseView addSubview:stockLabel];
    [stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headBaseView).offset(15);
        make.top.equalTo(priceLabel.mas_bottom).offset(15);
        
        
    }];

    
    
    
//月销量Label
    UILabel *salesLabel = [[UILabel alloc]init];
    salesLabel.numberOfLines = 1;
    salesLabel.font = [UIFont systemFontOfSize:12];
    salesLabel.textColor = [UIColor colorForHex:@"3f3f3f"];
    salesLabel.text = @"月销100件";
    [headBaseView addSubview:salesLabel];
    [salesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(stockLabel);
        make.trailing.equalTo(headBaseView).offset(-10);
        
        
    }];
    
//正品保障说明底部View
    //添加点击手势
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDescribeVC)];
    UIView *describeView = [[UIView alloc]init];
    describeView.backgroundColor = [UIColor colorForHex:@"f7f7f7"];
    [describeView addGestureRecognizer:tapGR];
    [headBaseView addSubview:describeView];
    [describeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headBaseView);
        make.trailing.equalTo(headBaseView);
        make.bottom.equalTo(headBaseView);
        make.top.equalTo(stockLabel.mas_bottom).offset(15);
    }];

    
    
    
//view最右边的箭头button
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_rightBtn"] forState:UIControlStateNormal];
    rightBtn.userInteractionEnabled = NO;
//    [rightBtn addTarget:self action:@selector(showDescribeVC) forControlEvents:UIControlEventTouchUpInside];
    [describeView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(describeView).offset(-5);
        make.height.equalTo(describeView);
        make.width.equalTo(describeView.mas_height);
        make.top.equalTo(describeView);
        
    }];
    

    
    
//view上的三个button
    //先算每个btn的width
    CGFloat btnW = (YDTXScreenW -50)/3;
    //正品保障btn
    UIButton *realGoodsBtn = [[UIButton alloc]init];
    realGoodsBtn.userInteractionEnabled = NO;
    [realGoodsBtn setTitleColor:[UIColor colorForHex:@"828081"] forState:UIControlStateNormal];
    realGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [realGoodsBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_circle_hl"] forState:UIControlStateNormal];
    [realGoodsBtn setTitle:@"正品保障" forState:UIControlStateNormal];
    realGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    realGoodsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [describeView addSubview:realGoodsBtn];
    [realGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(stockLabel);
        make.centerY.equalTo(describeView);
        make.width.equalTo(@(btnW));
    }];

    //48小时发货btn
    UIButton *deliveryGoodsBtn = [[UIButton alloc]init];
    realGoodsBtn.userInteractionEnabled = NO;
//    deliveryGoodsBtn.backgroundColor = [UIColor redColor];
    [deliveryGoodsBtn setTitleColor:[UIColor colorForHex:@"828081"] forState:UIControlStateNormal];
    deliveryGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [deliveryGoodsBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_circle_hl"] forState:UIControlStateNormal];
    [deliveryGoodsBtn setTitle:@"48小时发货" forState:UIControlStateNormal];
    deliveryGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    deliveryGoodsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [describeView addSubview:deliveryGoodsBtn];
    [deliveryGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(realGoodsBtn.mas_trailing);
        make.centerY.equalTo(describeView);
        make.width.equalTo(@(btnW));
    }];
    
    //8天内退款btn
    UIButton *changeGoodsBtn = [[UIButton alloc]init];
    changeGoodsBtn.userInteractionEnabled = NO;
//    changeGoodsBtn.backgroundColor = [UIColor redColor];
    [changeGoodsBtn setTitleColor:[UIColor colorForHex:@"828081"] forState:UIControlStateNormal];
    changeGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [changeGoodsBtn setImage:[UIImage imageNamed:@"marketDetailVC_describeView_circle_hl"] forState:UIControlStateNormal];
    [changeGoodsBtn setTitle:@"8天内退款" forState:UIControlStateNormal];
    changeGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    changeGoodsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [describeView addSubview:changeGoodsBtn];
    [changeGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(deliveryGoodsBtn.mas_trailing);
        make.centerY.equalTo(describeView);
        make.width.equalTo(@(btnW));
    }];
    
    
    
    
//底部的悬浮view
    UIView *toolView = [[UIView alloc]init];
    toolView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:toolView];
    [toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    //每个btn的宽
    CGFloat toolBtnWidth = YDTXScreenW/3;
    
    //收藏btn
    UIButton *collectBtn = [[UIButton alloc]init];
    [collectBtn setBackgroundColor:[UIColor whiteColor]];
    [collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [collectBtn addTarget:self action:@selector(collectIt) forControlEvents:UIControlEventTouchUpInside];
    
    [toolView addSubview:collectBtn];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(toolView);
        make.top.equalTo(toolView);
        make.bottom.equalTo(toolView);
        make.width.equalTo(@(toolBtnWidth));
    }];
    
    //加入购物车btn
    UIButton *jionShopCarBtn = [[UIButton alloc]init];
    [jionShopCarBtn setBackgroundColor:[UIColor colorForHex:@"fe9402"]];
    [jionShopCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    jionShopCarBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [jionShopCarBtn addTarget:self action:@selector(jionItemInShopCar) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:jionShopCarBtn];
    [jionShopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(collectBtn.mas_trailing);
        make.top.equalTo(toolView);
        make.bottom.equalTo(toolView);
        make.width.equalTo(@(toolBtnWidth));
    }];
    
    
    //立即购买btn15
    UIButton *BuyNowBtn = [[UIButton alloc]init];
    [BuyNowBtn setBackgroundColor:[UIColor colorForHex:@"ff5b02"]];
    [BuyNowBtn setTitle:@"立即购买" forState:UIControlStateNormal];
    BuyNowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [BuyNowBtn addTarget:self action:@selector(buyItNow) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:BuyNowBtn];
    [BuyNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(jionShopCarBtn.mas_trailing);
        make.top.equalTo(toolView);
        make.bottom.equalTo(toolView);
        make.width.equalTo(@(toolBtnWidth));
    }];
    
    
    
    
    
    
    
}
#pragma mark - Method
-(void)showDescribeVC{

    NSLog(@"-ShowDescribeVC-");
    
    
    

}
-(void)collectIt{

    NSLog(@"-collectIt-");

}
-(void)jionItemInShopCar{

    
    
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.view.layer setTransform:[self secondTransform]];
//            显示maskView
 
            MarketMaskView *maskView = [[MarketMaskView alloc]initWithFrame:self.view.bounds];
            self.maskView =maskView;
            maskView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:maskView];
            
            
          
        } completion:^(BOOL finished) {
            
        }];
        
    }];


}

-(void)buyItNow{

    NSLog(@"-buyItNow-");
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.view.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.view.layer setTransform:[self secondTransform]];
            //            显示maskView
            
            MarketMaskView *maskView = [[MarketMaskView alloc]initWithFrame:self.view.bounds];
            self.maskView =maskView;
            maskView.delegate = self;
            [[UIApplication sharedApplication].keyWindow addSubview:maskView];
            
            
            
        } completion:^(BOOL finished) {
            
        }];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarketDetailCell *marketDetailCell = [tableView dequeueReusableCellWithIdentifier:kMarketDetialCellId];
    return marketDetailCell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;

}

#pragma mark - tableView  headerView

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
// 15 15
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"商品详情";
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [headView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(headView).offset(15);
        make.centerY.equalTo(headView);
    }];
    

    
    
    
    return headView;
}

//头部的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    
    return 40;
    
    
    
}


#pragma mark -JumpToCartVcMethod
-(void)JumpToCartVC{

    NSLog(@"JumpToCartVC");
    CartViewController *cartVC = [CartViewController new];
    [self.navigationController pushViewController:cartVC animated:YES];
    
}


#pragma mark - TranslationAnimation
- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}

- (CATransform3D)secondTransform{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    //向上移
    t2 = CATransform3DTranslate(t2, 0, self.view.frame.size.height * (-0.08), 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.85, 0.75, 1);
    return t2;
}
#pragma mark - MarketMaskDelegate
-(void)removeMarketVCAnimation{

    [self.maskView removeFromSuperview];
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.view.layer setTransform:[self firstTransform]];
       
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //变为初始值
            [self.view.layer setTransform:CATransform3DIdentity];
            
        } completion:^(BOOL finished) {
            
       
        }];
        
    }];
    



}

@end
