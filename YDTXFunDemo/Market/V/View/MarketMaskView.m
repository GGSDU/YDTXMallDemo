//
//  MarketMaskView.m
//  market
//
//  Created by RookieHua on 2016/12/6.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MarketMaskView.h"

#import "PPNumberButton.h"
#import "MarketGoodsModelCell.h"
@interface MarketMaskView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(strong,nonatomic)UIView *baseMaskView;//遮罩view
@property(strong,nonatomic)UIView *baseView;//进行商品信息选择的baseView
@property(strong,nonatomic)UICollectionView *modelCollectView;

/** 数据数组*/
@property(strong,nonatomic)NSMutableArray *modelDataArr;

/***/
@property(strong,nonatomic)MarketGoodsModelCell *CurrentSelectCell;
@property(strong,nonatomic)marketProductModel *currentProductModel;


@property(strong,nonatomic)UIImageView *ImgView; //图片
@property(strong,nonatomic)UILabel *goodsTitleLabel;//商品名称
@property(strong,nonatomic)UILabel *priceLabel;//价格
@property(strong,nonatomic)PPNumberButton *numberButton;//加减控件
@property(strong,nonatomic)UIButton *bottomBtn;



@end



static NSString *kmodelCellId = @"modelCell";
@implementation MarketMaskView
//Lazy
-(NSMutableArray *)modelDataArr{

    if (!_modelDataArr) {
        _modelDataArr = [NSMutableArray array];
    }
    return _modelDataArr;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setUI];//创建界面
    }
    return self;
}


-(void)setBasic{

    _modelCollectView.delegate = self;
    _modelCollectView.dataSource = self;
    _modelCollectView.backgroundColor = [UIColor whiteColor];
    
    _modelCollectView.showsHorizontalScrollIndicator = NO;
    _modelCollectView.showsVerticalScrollIndicator = NO;
    
    
    
    //注册cell
    
    
    [_modelCollectView registerNib:[UINib nibWithNibName:@"marketGoodsModelCell" bundle:nil] forCellWithReuseIdentifier:kmodelCellId];

}

//布局界面
-(void)setUIWithGoods_name:(NSString *)goods_name ImageUrl:(NSURL *)imageUrl{
    
//底部的maskView
    
    _baseMaskView = [[UIView alloc]initWithFrame:self.bounds];
    
    [_baseMaskView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5f]];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_baseMaskView];
    //添加点击手势  当用户点击的时候移除self
    UITapGestureRecognizer *tapRemoveSelf = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMiss)];
    [_baseMaskView addGestureRecognizer:tapRemoveSelf];
    
//baseView
     _baseView = [[UIView alloc]initWithFrame:CGRectMake(0, YDTXScreenH , YDTXScreenW, 418)];
    
    _baseView.backgroundColor = [UIColor whiteColor];
    
//    baseView.userInteractionEnabled = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:_baseView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _baseView.frame = CGRectMake(0, YDTXScreenH -418, YDTXScreenW, 418);
        
    }];


//右上角的关闭btn
    UIButton *closeBtn = [[UIButton alloc]init];
    [closeBtn setImage:[UIImage imageNamed:@"market_MaskView_closeBtn"] forState:UIControlStateNormal];
    [_baseView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(_baseView).offset(-10);
        make.centerY.equalTo(_baseView.mas_top);
    }];
    
//imageView
    _ImgView = [[UIImageView alloc]init];
    _ImgView.backgroundColor = [UIColor redColor];
    _ImgView.layer.borderWidth = 2;
    _ImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _ImgView.layer.cornerRadius = 5;
    _ImgView.layer.masksToBounds = YES;
    [_ImgView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"zwt"]];
    [_baseView addSubview:_ImgView];
    [_ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(125, 125));
        make.leading.equalTo(_baseView).offset(15);
        make.top.equalTo(_baseView).offset(-15);
    }];

//商品Label
    _goodsTitleLabel = [[UILabel alloc]init];
    _goodsTitleLabel.numberOfLines = 2;
    _goodsTitleLabel.font = [UIFont systemFontOfSize:16];
    _goodsTitleLabel.textColor = [UIColor blackColor];
    _goodsTitleLabel.text = goods_name;
    [_baseView addSubview:_goodsTitleLabel];
    [_goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_ImgView.mas_trailing).offset(10);
        make.top.equalTo(_baseView).offset(30);
        make.trailing.equalTo(_baseView).offset(-10);
    }];
    
//价格Label
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.numberOfLines = 1;
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:18];
    [_baseView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_goodsTitleLabel);
        make.top.equalTo(_goodsTitleLabel.mas_bottom).offset(20);
    }];
    
//型号Label
    UILabel *typeLabel = [[UILabel alloc]init];
    typeLabel.text = @"型号";
    typeLabel.font = [UIFont systemFontOfSize:16];
    typeLabel.textColor = [UIColor blackColor];
    [_baseView addSubview:typeLabel];
    [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_ImgView);
        make.top.equalTo(_ImgView.mas_bottom).offset(15);
        
    }];
//型号collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 最小列间距
    layout.minimumInteritemSpacing = 10;
    
//     item的size
    CGFloat itemW = (YDTXScreenW - 50) / 3;
    layout.estimatedItemSize = CGSizeMake(itemW, 30);
    // 每一组的缩进
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    _modelCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _modelCollectView.backgroundColor = [UIColor whiteColor];
    _modelCollectView.showsHorizontalScrollIndicator = NO;
    _modelCollectView.showsVerticalScrollIndicator = NO;
    _modelCollectView.delegate = self;
    _modelCollectView.dataSource = self;
    [_baseView addSubview:_modelCollectView];
    [_modelCollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_baseView);
        make.right.equalTo(_baseView);
        make.top.equalTo(typeLabel.mas_bottom);
        make.height.mas_equalTo(160);
    }];

    [_modelCollectView registerNib:[UINib nibWithNibName:@"MarketGoodsModelCell" bundle:nil] forCellWithReuseIdentifier:kmodelCellId];

    

    //购买数量Label
    UILabel *buyNumLabel = [[UILabel alloc]init];
    buyNumLabel.text = @"购买数量";
    buyNumLabel.font = [UIFont systemFontOfSize:16];
    buyNumLabel.textColor = [UIColor blackColor];
    [_baseView addSubview:buyNumLabel];
    [buyNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_ImgView);
        make.top.equalTo(_modelCollectView.mas_bottom).offset(15);
        
    }];
    

//加入购物车btn
    /*   */
    _bottomBtn = [[UIButton alloc]init];
   
    _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    if (_BtnID == 0) {
        [_bottomBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor colorForHex:@"fe9402"]];
        [_bottomBtn addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
    }else if (_BtnID == 1){
        [_bottomBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_bottomBtn setBackgroundColor:[UIColor colorForHex:@"ff5b02"]];
        [_bottomBtn addTarget:self action:@selector(buyItNow) forControlEvents:UIControlEventTouchUpInside];
    }
   
    
    
    
    [_baseView addSubview:_bottomBtn];
    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_baseView);
        make.leading.equalTo(_baseView);
        make.trailing.equalTo(_baseView);
        make.height.mas_equalTo(50);
    }];
    
    
//加减数量btn与textfiled

    
    _numberButton = [[PPNumberButton alloc]init];;
    _numberButton.shakeAnimation = YES;
    //设置边框颜色
    _numberButton.borderColor = [UIColor grayColor];
    
    _numberButton.increaseTitle = @"＋";
    _numberButton.decreaseTitle = @"－";
    _numberButton.inputFieldFont = 14;
    
    
    
    [_baseView addSubview:_numberButton];
    [_numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buyNumLabel);
        make.trailing.equalTo(_baseView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(120, 35));
    }];
    
}


-(void)addToCart{

    NSLog(@"--点击了加入购物车按钮--");

    if (_CurrentSelectCell ) {
        
        /*
         http://test.m.yundiaoke.cn/api/goodsOrder/submitOrder
         请求方式：POST
         参数：
         User_id：用户id
         Goods_id：商品Id
         Goods_model_id：商品型号id
         Cou_id：优惠券id
         Goods_name：商品名称
         Price：订单单价
         Total_price：订单总价
         Nums：购买数量
         Courier：快递名称
         Status：订单状态====>
         address_id :收货地址
         订单状态： -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
         */
        
        NSLog(@"currentModel--->:%@",_currentProductModel.objectDictionary);
        
       
       
        
        
        NSInteger num = [_numberButton.currentNumber integerValue];
        CGFloat totalPrice = num* _currentProductModel.price;
        
        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
        paramsDic[@"user_id"] = @"37";
        paramsDic[@"goods_id"] = _goods_id;
        paramsDic[@"goods_model_id"] = _currentProductModel.ID;
//        paramsDic[@"cou_id"] = @"3";
        paramsDic[@"goods_name"] = _goods_Name;
        paramsDic[@"price"] = @(_currentProductModel.price);
        paramsDic[@"total_price"] = @(totalPrice);
        paramsDic[@"nums"] = @(num);
        paramsDic[@"courier"] = @"申通";
        paramsDic[@"status"] = @"4";
        paramsDic[@"address_id"] = @"如东";
        
        
//
        [[NetWorkService shareInstance]requestForDealGoodsOrderWithParamsDic:paramsDic];
        
        
        [self disMiss];
    }else{
    
        [RHNotiTool NotiShowErrorWithTitle:@"请选择商品型号" Time:1.0];
    
    }
    
    

  

}


-(void)buyItNow{


    if (_CurrentSelectCell ) {
        
        /*
         http://test.m.yundiaoke.cn/api/goodsOrder/submitOrder
         请求方式：POST
         参数：
         User_id：用户id
         Goods_id：商品Id
         Goods_model_id：商品型号id
         Cou_id：优惠券id
         Goods_name：商品名称
         Price：订单单价
         Total_price：订单总价
         Nums：购买数量
         Courier：快递名称
         Status：订单状态====>
         address_id :收货地址
         订单状态： -1为已取消，0为未付款 ，1为已付款， 2为待收货，3为退款，4为加入购物车
         */
        
        NSLog(@"currentModel--->:%@",_currentProductModel.objectDictionary);
        
        
        
        
        
        NSInteger num = [_numberButton.currentNumber integerValue];
        CGFloat totalPrice = num* _currentProductModel.price;
        
        NSMutableDictionary *paramsDic = [NSMutableDictionary dictionary];
//        paramsDic[@"user_id"] = @"65";
//        paramsDic[@"goods_id"] = _goods_id;
//        paramsDic[@"goods_model_id"] = _currentProductModel.ID;
//        //        paramsDic[@"cou_id"] = @"3";
//        paramsDic[@"goods_name"] = _goods_Name;
//        paramsDic[@"price"] = @(_currentProductModel.price);
//        paramsDic[@"total_price"] = @(totalPrice);
//        paramsDic[@"nums"] = @(num);
//        paramsDic[@"courier"] = @"申通";
//        paramsDic[@"status"] = @"0";
//        paramsDic[@"address_id"] = @"如东";
//        
        
        paramsDic[@"user_id"] = @"65";
        paramsDic[@"goods_id"] = @"35";
        paramsDic[@"goods_model_id"] = @"36";
        //        paramsDic[@"cou_id"] = @"3";
        paramsDic[@"goods_name"] = @"ydk";
        paramsDic[@"price"] = @"100.00";
        paramsDic[@"total_price"] = @"200";
        paramsDic[@"nums"] = @(2);
        paramsDic[@"courier"] = @"申通";
        paramsDic[@"status"] = @"0";
        paramsDic[@"address_id"] = @"如东";
        
        //
        [[NetWorkService shareInstance]requestForDealGoodsOrderWithParamsDic:paramsDic];
        
        
        [self disMiss];

    }else{
    
        [RHNotiTool NotiShowErrorWithTitle:@"请选择商品型号" Time:1.0];
    }
}


#pragma 提供给外部的方法
-(void)showWithTransformAnimation{
    [self TransformAnimation];
    
}


-(void)updateUIWithGoodsId:(NSString *)goods_id{
    
    
    //获取模型数据  并创建视图
    [[NetWorkService shareInstance]requestForMarketGoodsModelDataWithGoodsId:goods_id responseBlock:^(NSArray *marketProductModelArray) {
        
        _modelDataArr = [NSMutableArray array];
        [_modelDataArr removeAllObjects];
        [_modelDataArr addObjectsFromArray:marketProductModelArray];
        [_modelCollectView reloadData];
    }];
    

    
    
    
}




#pragma mark--modelCollectionView Method
//// 垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}
//
////- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
////{
////    return UIEdgeInsetsMake(10, 10, 10, 10);
////}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    MarketGoodsModelCell *cell = (MarketGoodsModelCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    CGFloat btnW = cell.modelBtn.titleLabel.width;
////    CGFloat itemW = (YDTXScreenW - 50) / 3;
//    return CGSizeMake(btnW +10, 30);
//}
//
// 设置每个分区返回多少item
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _modelDataArr.count ;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    marketProductModel *marketProductModel = _modelDataArr[indexPath.row];
    MarketGoodsModelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kmodelCellId forIndexPath:indexPath];
    cell.marketProductModel = marketProductModel;
    
    return cell;
}

//
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
   MarketGoodsModelCell *cell = (MarketGoodsModelCell *)[collectionView cellForItemAtIndexPath:indexPath];

    marketProductModel *marketProductModel = _modelDataArr[indexPath.row];
    _currentProductModel = marketProductModel;
    
    //选中了cell
    // 1.改变cell的边框和字体颜色
    
    cell.layer.borderColor = RGB(255, 114, 0).CGColor;
    [cell.modelBtn setTitleColor:RGB(255, 114, 0) forState:UIControlStateNormal];
    
    if (_CurrentSelectCell && ![_CurrentSelectCell isEqual:cell]) {
        _CurrentSelectCell.layer.borderColor = RGB(211, 211, 211).CGColor;
        [_CurrentSelectCell.modelBtn setTitleColor:RGB(48 , 48, 48) forState:UIControlStateNormal];
    }
    
    _CurrentSelectCell = cell;
    // 2.改变价格
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2f",marketProductModel.price];
    
    // 3.设置库存数量
    _numberButton.maxValue = marketProductModel.quantity;
    
    
    



}






#pragma 手势触发的方法
-(void)disMiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.baseView.frame = CGRectMake(0, YDTXScreenH , YDTXScreenW, 418);
    } completion:^(BOOL finished) {
        [self dismissTransformAnimation];
        [_baseView removeFromSuperview];
        [_baseMaskView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
}


#pragma mark - TranslationAnimation

//出现时执行的动画
-(void)TransformAnimation{

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.superview.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            [self.superview.layer setTransform:[self secondTransform]];
            
        } completion:^(BOOL finished) {
            [self setUIWithGoods_name:_goods_Name ImageUrl:_imageUrl];
//            [self setBasic];
        }];
        
    }];

}


//消失时执行的动画
-(void)dismissTransformAnimation{

    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.superview.layer setTransform:[self firstTransform]];
        
    } completion:^(BOOL finished) {
            //变为初始值
            [self.superview.layer setTransform:CATransform3DIdentity];
        
    }];

}


//缩放 旋转的动画
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
    t2 = CATransform3DTranslate(t2, 0, self.superview.frame.size.height * (-0.08), 0);
    //第二次缩小
    t2 = CATransform3DScale(t2, 0.85, 0.75, 1);
    return t2;
}


@end
