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

static NSString *editString = @"编辑";
static NSString *completeString = @"完成";

@interface CartViewController ()<UITableViewDataSource,UITableViewDelegate,CartCellOperationViewDelegate,CartListCellDelegate>

@property (nonatomic,retain) NSMutableArray *productModelmArray;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) CartCellOperationView *cartCellOperationView;

@property (nonatomic,retain) NSMutableDictionary *operateCellIndexPathDic;

@property (nonatomic,retain) UIButton *tempButton;

@end

@implementation CartViewController

- (void)dealloc
{
    if (_productModelmArray) {
        [_productModelmArray removeAllObjects];
        [_productModelmArray release];
        _productModelmArray = nil;
    }
    
    if (_operateCellIndexPathDic) {
        [_operateCellIndexPathDic removeAllObjects];
        [_operateCellIndexPathDic release];
        _operateCellIndexPathDic = nil;
    }
    
    if (_productModelArray) {
        [_productModelArray release];
        _productModelArray = nil;
    }
    
    [self removeKeyboardNotification];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(238, 238, 238);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"购物车";
    [self customRightBarButtonItem];
    
    [self creatUI];
    
    [self addKeyboardNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - touch event
- (void)startEdit:(UIBarButtonItem *)aSender
{
    for (ProductModel *model in self.productModelmArray) {
        NSLog(@"%d",model.number);
    }
    
    if ([aSender.title isEqualToString:editString]) {
        aSender.title = completeString;
        [self.cartCellOperationView updateOperationButtonTitle:@"删除"];
    } else if ([aSender.title isEqualToString:completeString]) {
        aSender.title = editString;
        [self.cartCellOperationView updateOperationButtonTitle:@"结算"];
    }
    
}

#pragma mark - CartCellOperationViewDelegate
- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedAllChooseButton:(UIButton *)allChooseButton
{
    NSLog(@"here to do something after selecte all choose button");
    [self setALLCellSelectedStatus:allChooseButton.selected];
    if (cartCellOperationView.allChooseButtonSelectedStatus) {
        [self setOperateCellIndexPathDicAllObject:YES];
//        NSLog(@"all choose %@",self.operateCellIndexPathDic);
    } else {
        [self setOperateCellIndexPathDicAllObject:NO];
//        NSLog(@"dis all choose%@",self.operateCellIndexPathDic);
    }
}

- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedSettleAccountButton:(UIButton *)settleAccountButton
{
    NSLog(@"here to start settle account button");
    
}

- (void)cartCellOperationView:(CartCellOperationView *)cartCellOperationView didSelectedDeleteListButton:(UIButton *)deleteListButton
{
    NSLog(@"here to delete list");
    NSArray *selectCellArray = [self getCurrentSelectedArray];
    
    NSLog(@"%@",selectCellArray);
}

#pragma mark - CartListCellDelegate
- (void)cartListCell:(CartListCell *)cartListCell didSelectedCell:(ProductModel *)productModel
{
    NSLog(@"click selected cell ******************");
    /** 这里的逻辑暂时定为
      *  1.cell选中状态时，将模型加入数组中
      *  2.cell非选中状态时，将模型从数组中移除
      */
    BOOL cellSelected = cartListCell.cellSelectButton.selected;
    NSNumber *object = [NSNumber numberWithBool:cellSelected];
    
    NSLog(@"*** cellSelected      *** %@",object);
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cartListCell];
    NSNumber *key = [NSNumber numberWithInteger:indexPath.section];
    NSLog(@"*** indexPath.row     *** %ld",indexPath.row);
    NSLog(@"*** indexPath.section *** %ld",indexPath.section);
    
    [self.operateCellIndexPathDic setObject:object forKey:key];
    
    NSLog(@"%@",self.operateCellIndexPathDic);
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
    
    ProductModel *productModel = (ProductModel *)self.productModelArray[indexPath.section];
    cartListCell.productModel = productModel;
    
    NSNumber *boolObject = [self.operateCellIndexPathDic objectForKey:[NSNumber numberWithInteger:indexPath.section]];
    [cartListCell updateCellStatusButtonSelected:boolObject.boolValue];
    
    
    return cartListCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.productModelmArray.count;
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

#pragma mark - getter/setter
- (NSMutableArray *)getCurrentSelectedArray
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (id key in self.operateCellIndexPathDic.allKeys) {
        NSNumber *boolObject = [self.operateCellIndexPathDic objectForKey:key];
        if (boolObject.boolValue) {
            [mutableArray addObject:key];
        }
    }
    return [mutableArray autorelease];
}

- (void)setOperateCellIndexPathDicAllObject:(BOOL)selected{
    
    NSNumber *object = [NSNumber numberWithBool:selected];
    for (id key in self.operateCellIndexPathDic.allKeys) {
        
        [self.operateCellIndexPathDic setObject:object forKey:key];
    }
}

- (NSMutableDictionary *)operateCellIndexPathDic
{
    if (_operateCellIndexPathDic == nil) {
        _operateCellIndexPathDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        NSNumber *object = [NSNumber numberWithBool:NO];
        for (NSInteger i = 0; i < _productModelmArray.count; i++) {
            NSNumber *key = [NSNumber numberWithInteger:i];
            [self.operateCellIndexPathDic setObject:object forKey:key];
        }
        
    }
    return _operateCellIndexPathDic;
}

- (NSMutableArray *)productModelmArray
{
    if (_productModelmArray == nil) {
        _productModelmArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _productModelmArray;
}

- (void)setProductModelArray:(NSArray *)productModelArray
{
    _productModelArray = [productModelArray retain];
    
    
    [self.productModelmArray removeAllObjects];
    [self.productModelmArray addObjectsFromArray:_productModelArray];
}

#pragma mark - private methods
- (void)setALLCellSelectedStatus:(BOOL)selected
{
    for (int i = 0; i < self.tableView.visibleCells.count; i++) {
        // 1.update current visible cells‘s view（not all cell）
        CartListCell *cartListCell = (CartListCell *)self.tableView.visibleCells[i];
        [cartListCell updateCellStatusButtonSelected:selected];
    }
}

#pragma mark - init UI
- (void)creatUI{
    _cartCellOperationView = [[CartCellOperationView alloc] init];
    _cartCellOperationView.delegate = self;
    [self.view addSubview:_cartCellOperationView];
    [_cartCellOperationView release];
    [_cartCellOperationView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(49);
    }];
 
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - _cartCellOperationView.frame.size.height) style:UITableViewStylePlain];
    _tableView = [[UITableView alloc] init];
    _tableView.rowHeight = 135;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView release];
    [self.view sendSubviewToBack:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        
        make.top.mas_equalTo(64);
        make.bottom.equalTo(_cartCellOperationView.mas_top).offset(0);
    }];
    
    [_cartCellOperationView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tableView.mas_bottom).offset(0);
    }];
}

- (void)customRightBarButtonItem
{
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:editString style:UIBarButtonItemStylePlain target:self action:@selector(startEdit:)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    [rightBarButton release];
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
    [button release];
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
    [button release];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
