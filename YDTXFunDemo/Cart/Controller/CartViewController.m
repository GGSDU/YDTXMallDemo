//
//  CartViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "CartViewController.h"

#import "CartCellOperationView.h"
#import "CartListCell.h"
#import "ProductModel.h"

#import "CartDefaultView.h"

#import "NetWorkService.h"


static NSString *editString = @"编辑";
static NSString *completeString = @"完成";

@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,CartDefaultViewDelegate,CartCellOperationViewDelegate,CartListCellDelegate>

@property (nonatomic,strong) CartDefaultView *cartDefaultView;
@property (nonatomic,strong) UIView *cartListMainView;

@property (nonatomic,strong) UIBarButtonItem *rightBarButtonItem;

@property (nonatomic,strong) NSMutableArray *cartProductModelArray;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) CartCellOperationView *cartCellOperationView;

// 用于记录cell选中状态
@property (nonatomic,strong) NSMutableDictionary *operateCellIndexPathDic;

@property (nonatomic,strong) UIButton *tempButton;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(238, 238, 238);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"购物车";
    
    [self requestCartListToInitData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self addKeyboardNotification];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self removeKeyboardNotification];
}

#pragma mark - touch event
- (void)startEdit:(UIBarButtonItem *)aSender
{
    if ([aSender.title isEqualToString:editString]) {
        aSender.title = completeString;
        [self.cartCellOperationView updateOperationButtonTitle:@"删除"];
    } else if ([aSender.title isEqualToString:completeString]) {
        aSender.title = editString;
        [self.cartCellOperationView updateOperationButtonTitle:@"结算"];
    }
}

#pragma mark - CartDefaultViewDelegate
- (void)cartDefaultView:(CartDefaultView *)cartDefaultView didClickedGoToShopMarket:(UIButton *)aSender
{
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[ShopMarketController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
        }
    }
}

#pragma mark - CartCellOperationViewDelegate
- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedSettleAccountButton:(UIButton *)settleAccountButton
{
    NSLog(@"here to start settle account button");
    NSArray *selectCellArray = [self getCurrentSelectedCellModelArray];
    
}

- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedDeleteListButton:(UIButton *)deleteListButton
{
    NSLog(@"here to delete list");
    [SXPublicTool showAlertControllerWithTitle:nil meassage:@"确定要删除选中的商品吗？" cancelTitle:@"取消" cancelHandler:^(UIAlertAction * _Nonnull action) {
        
        
        
    } confirmTitle:@"确定" confirmHandler:^(UIAlertAction * _Nonnull action) {
        
        // 删除订单
        NSArray *selectCellArray = [self getCurrentSelectedCellModelArray];
        [self requestToDeleteCartListWithArray:selectCellArray];
        
        
        [self.cartProductModelArray removeObjectsInArray:selectCellArray];
        [self initOperateCellIndexPathDicDataWithParam:NO];
        
        if (self.cartProductModelArray.count == 0) {
            
            [self.cartListMainView removeFromSuperview];
            [self showViewWhenNoList];
            
        } else {
        
        
            [self setALLCellSelectedStatus:NO];
            [self updateCartCellOperationView];
            
            [self.tableView reloadData];
        }
    }];
}

- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedAllChooseButton:(UIButton *)allChooseButton
{
    NSLog(@"here to do something after selecte all choose button");
    [self setALLCellSelectedStatus:allChooseButton.selected];
    
    [self initOperateCellIndexPathDicDataWithParam:allChooseButton.selected];
    [self updateCartCellOperationViewPrice];
    
}
#pragma mark - CartListCellDelegate
- (void)cartListCell:(CartListCell *)cartListCell didSelectedCell:(CartProductModel *)cartProductModel
{
    NSNumber *object = [NSNumber numberWithBool:cartListCell.cellSelectButton.selected];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cartListCell];
    NSNumber *key = [NSNumber numberWithInteger:indexPath.section];
    [self.operateCellIndexPathDic setObject:object forKey:key];
    
    [self updateCartCellOperationViewAllButton];
    [self updateCartCellOperationViewPrice];
}

#pragma mark - tableVeiw delegate & datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CartListCell";
    CartListCell *cartListCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cartListCell == nil) {
        cartListCell = [[CartListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cartListCell.delegate = self;
        //        [cartListCell mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(135);
        //        }];
    }
    
    
    CartProductModel *cartProductModel = (CartProductModel *)self.cartProductModelArray[indexPath.section];
    int quantity = cartProductModel.quantity;
    [[NetWorkService shareInstance] getCurrentQuantityWithGoodsModelId:cartProductModel.goods_model_id quantity:&quantity];
    cartListCell.cartProductModel = cartProductModel;
    
    NSNumber *boolObject = [self.operateCellIndexPathDic objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    [cartListCell updateCellStatusButtonSelected:boolObject.boolValue];
    
    
    return cartListCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cartProductModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 135;
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 135;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - private methods - data
- (float)getCurrentSelectedCellAllPrice
{
    float totalPrice = 0.0f;
    for (CartProductModel *cartProductModel in [self getCurrentSelectedCellModelArray]) {
        totalPrice += cartProductModel.price;
    }
    return totalPrice;
}

//return the CartProductModel array
- (NSMutableArray *)getCurrentSelectedCellModelArray
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSArray *indexArray = [self getCurrentSelectedCellIndexArray];
    for (id index in indexArray) {
        NSInteger i = [index integerValue];
        [mutableArray addObject:self.cartProductModelArray[i]];
    }
    return mutableArray;
}

- (NSMutableArray *)getCurrentSelectedCellIndexArray
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (id key in self.operateCellIndexPathDic.allKeys) {
        NSNumber *boolObject = [self.operateCellIndexPathDic objectForKey:key];
        if (boolObject.boolValue) {
            [mutableArray addObject:key];
        }
    }
    return mutableArray;
}

- (void)initOperateCellIndexPathDicDataWithParam:(BOOL)selected
{
    if (self.operateCellIndexPathDic.count != self.cartProductModelArray.count) {
        [self.operateCellIndexPathDic removeAllObjects];
    }
    
    NSNumber *object = [NSNumber numberWithBool:selected];
    for (NSInteger i = 0; i < _cartProductModelArray.count; i++) {
        NSNumber *key = [NSNumber numberWithInteger:i];
        [self.operateCellIndexPathDic setObject:object forKey:key];
    }
}

- (NSMutableDictionary *)operateCellIndexPathDic
{
    if (_operateCellIndexPathDic == nil) {
        _operateCellIndexPathDic = [[NSMutableDictionary alloc] initWithCapacity:self.cartProductModelArray.count];
        
        [self initOperateCellIndexPathDicDataWithParam:NO];
    }

    return _operateCellIndexPathDic;
}

- (NSMutableArray *)cartProductModelArray
{
    if (_cartProductModelArray == nil) {
        _cartProductModelArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _cartProductModelArray;
}

- (void)requestToDeleteCartListWithArray:(NSArray *)array
{
    NSMutableArray *param = [[NSMutableArray alloc] initWithCapacity:0];
    for (CartProductModel *cartProductModel in array) {
        [param addObject:[NSNumber numberWithInt:cartProductModel.goods_order_id]];
    }
    [[NetWorkService shareInstance] requestForDeleteCartListWithGoodsOrderIdArray:param];
}

- (void)requestCartListToInitData{
    
    [self.cartProductModelArray removeAllObjects];
    [[NetWorkService shareInstance] requestForCartListWithUserId:USER_ID responseBlock:^(NSArray *responsecartProductModelArray) {
        
        if (responsecartProductModelArray && responsecartProductModelArray.count > 0) {
            
            [self.cartProductModelArray addObjectsFromArray:responsecartProductModelArray];
            
            
            [self customRightBarButtonItemWithTitle:editString];
            [self creatUI];
            
        } else {
            
            [self showViewWhenNoList];
        }
        
    }];
}


#pragma mark - private methods - view
- (void)updateCartCellOperationView
{
    [self updateCartCellOperationViewAllButton];
    [self updateCartCellOperationViewPrice];
}

- (void)updateCartCellOperationViewAllButton
{
    NSArray *selectedModelArray = [self getCurrentSelectedCellModelArray];
    if (selectedModelArray.count < self.cartProductModelArray.count) {
        self.cartCellOperationView.allChooseButton.selected = NO;
    } else if (selectedModelArray.count == self.cartProductModelArray.count){
        self.cartCellOperationView.allChooseButton.selected = YES;
    }
}

- (void)updateCartCellOperationViewPrice
{
    float totalPrice = [self getCurrentSelectedCellAllPrice];
    [self.cartCellOperationView updateTotalPrice:totalPrice];
}

- (void)setALLCellSelectedStatus:(BOOL)selected
{
    for (int i = 0; i < self.tableView.visibleCells.count; i++) {
        // 1.update current visible cells‘s view（not all cell）
        CartListCell *cartListCell = (CartListCell *)self.tableView.visibleCells[i];
        [cartListCell updateCellStatusButtonSelected:selected];
    }
}


#pragma mark - init UI
- (void)showViewWhenNoList
{
    [self customRightBarButtonItemWithTitle:nil];
    [self createDefaultView];
}

- (void)createDefaultView{
    CGRect frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64);
    _cartDefaultView = [[CartDefaultView alloc] initWithFrame:frame];
    _cartDefaultView.delegate = self;
    [self.view addSubview:_cartDefaultView];
}

- (void)creatUI{
    _cartListMainView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_cartListMainView];
    
    
    _cartCellOperationView = [[CartCellOperationView alloc] init];
    _cartCellOperationView.delegate = self;
    [_cartListMainView addSubview:_cartCellOperationView];
    [_cartCellOperationView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_cartListMainView.mas_left).offset(0);
        make.bottom.equalTo(_cartListMainView.mas_bottom).offset(0);
        make.right.equalTo(_cartListMainView.mas_right).offset(0);
        make.height.mas_equalTo(49);
    }];
    
    
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, cartListMainView.frame.size.width, cartListMainView.frame.size.height - 64 - _cartCellOperationView.frame.size.height) style:UITableViewStylePlain];
    _tableView = [[UITableView alloc] init];
    _tableView.rowHeight = 135;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_cartListMainView addSubview:_tableView];
    [_cartListMainView sendSubviewToBack:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_cartListMainView.mas_left).offset(0);
        make.right.equalTo(_cartListMainView.mas_right).offset(0);
        
        make.top.mas_equalTo(64);
        make.bottom.equalTo(_cartCellOperationView.mas_top).offset(0);
    }];
    
    [_cartCellOperationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(0);
    }];
}

- (void)customRightBarButtonItemWithTitle:(NSString *)title
{
    if (title == nil) {
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        if (_rightBarButtonItem == nil) {
            _rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
        }
        self.navigationItem.rightBarButtonItem = _rightBarButtonItem;
    }
}

#pragma mark - keyboard Notification
- (void)addKeyboardNotification
{
    [SXPublicTool addKeyboardWillShowNotificationObserver:self selector:@selector(keyboardWillShow:) object:nil];
    //    [SXPublicTool addKeyboardDidShowNotificationObserver:self selector:@selector(keyboardDidShow:) object:nil];
    [SXPublicTool addKeyboardWillHideNotificationObserver:self selector:@selector(keyboardWillHide:) object:nil];
}

- (void)removeKeyboardNotification
{
    [SXPublicTool removeKeyboardWillShowNotificationObserver:self object:nil];
    //    [SXPublicTool removeKeyboardDidShowNotificationObserver:self object:nil];
    [SXPublicTool removeKeyboardWillHideNotificationObserver:self object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIButton *button = [[UIButton alloc] initWithFrame:self.view.bounds];
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.2;
    [button addTarget:self action:@selector(resignFirstResponder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    _tempButton = button;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    
    NSLog(@"%@",NSStringFromCGRect([value CGRectValue]));
    
    UIWindow *window = [SXPublicTool keyWindow];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, window.bounds.size.width, keyboardRect.origin.y)];
    button.backgroundColor = [UIColor blackColor];
    button.alpha = 0.2;
    [button addTarget:self action:@selector(resignFirstResponder:) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:button];
    _tempButton = button;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [_tempButton removeFromSuperview];
}

- (void)resignFirstResponder:(UIButton *)aSender
{
    NSLog(@"%s",__func__);
    [self.tableView endEditing:YES];
}

@end
