//
//  SpotTypeListView.m
//  YDTX
//
//  Created by 舒通 on 2016/12/20.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "SpotTypeListView.h"

@interface SpotTypeListView ()<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    
    BOOL showList;//是否弹出下拉列表
    CGFloat tabheight;//table 下拉列表的高度
    CGFloat frameHeight;//frame 的高度
    
    
    
}
@property (strong, nonatomic) UIView *drawBackStatusBackGroundView;
@property (retain, nonatomic) UITableView *tv;//x下拉列表
@property (retain, nonatomic) NSArray *tableArray;//下拉列表数据
@property (strong, nonatomic) UILabel *statusMessage;

@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIView *backGroundBtnView;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIButton *button;

@end

@implementation SpotTypeListView
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        [_messageLabel sizeToFit];
        _messageLabel.textColor = RGB(82, 82, 82);
        _messageLabel.text = @"塘口类型";
        _messageLabel.font = [UIFont systemFontOfSize:15*HeightScale];
        [self addSubview:_messageLabel];
        
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(10*HeightScale);
            make.left.mas_equalTo(self.mas_left).offset(10*HeightScale);
            
        }];
        
    }
    return _messageLabel;
}

- (UIView *)backGroundBtnView {
    if (!_backGroundBtnView) {
        _backGroundBtnView = [UIView new];
        _backGroundBtnView.backgroundColor = [UIColor whiteColor];
        _backGroundBtnView.layer.borderColor = RGB(183, 182, 187).CGColor;
        _backGroundBtnView.layer.borderWidth = 0.8;
        _backGroundBtnView.layer.cornerRadius = 5;
        [self addSubview:_backGroundBtnView];
        [_backGroundBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.messageLabel.mas_bottom).offset(18*HeightScale);
            make.left.mas_equalTo(self.messageLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(142*WidthScale, 42*HeightScale));
            
        }];
        
    }
    return _backGroundBtnView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:15*HeightScale];
        [_label sizeToFit];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.backGroundBtnView addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.backGroundBtnView.mas_top);
            make.left.mas_equalTo(self.backGroundBtnView.mas_left).offset(5*WidthScale);
            
            make.bottom.mas_equalTo(self.backGroundBtnView.mas_bottom);
        }];
        
    }
    return _label;
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.backgroundColor = RGB(228, 229, 234);
        _button.layer.cornerRadius = 5;
        [_button setImage:[UIImage imageNamed:@"WechatIMG1"] forState:UIControlStateNormal];
        [self.backGroundBtnView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.label.mas_top);
            make.right.mas_equalTo(self.backGroundBtnView.mas_right);
            make.width.mas_equalTo(42*WidthScale);
            make.height.mas_equalTo(42*HeightScale);
        }];
        
    }
    return _button;
}



- (instancetype)initWithFrame:(CGRect)frame listArray:(NSArray *)list {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.tableArray = list;
        
        
        
        frameHeight = frame.size.height;
        
        [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self creatListView];
        
    }
    
    
    return self;
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"点击了下拉列表");
    
    
    
    if (showList == YES) {//如果下拉框已显示，什么都不做
        return;
    } else { //如果下拉框尚未显示，则进行显示
        
        //        改变view的大小
        [self setHeight:200*HeightScale + self.backGroundBtnView.size.height + self.messageLabel.size.height + 28*HeightScale];
        
        //        把dropdownList放到前面，放置下拉框被别的控制器遮住
        [self bringSubviewToFront:self.tv];
        
        showList = YES;
        
        [UIView animateWithDuration:0.025 animations:^{
            [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
                if (self.tableArray.count*40*HeightScale > 200) {
                    make.height.mas_equalTo(200*HeightScale);
                } else {
                    make.height.mas_equalTo(self.tableArray.count*40*HeightScale);
                }
                
            }];
        }];
        
        
    }
    
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"isClickList" object:@(self.frame.size.height)];
    [self getNotificationContent];
    
}


#pragma mark ---下拉列表----
- (void) creatListView {
    
    //    self.tableArray = @[@"野塘",@"江河",@"湖库",@"农家乐",@"斤塘",@"黑坑",@"公园",@"海域",@"竞技池"];
    
    showList = NO;//默认不显示下拉框
    
    self.tv = [[UITableView alloc]init];
    
    self.tv.layer.borderColor = RGB(183, 182, 187).CGColor;
    self.tv.layer.borderWidth = 1;
    self.tv.layer.cornerRadius = 5;
    
    self.tv.delegate = self;
    self.tv.dataSource = self;
    
    self.tv.backgroundColor = [UIColor grayColor];
    self.tv.separatorColor = [UIColor grayColor];
    
    //默认选中行，放在 reloadData 后
    NSIndexPath *path=[NSIndexPath indexPathForItem:0 inSection:0];
    [self tableView:self.tv didSelectRowAtIndexPath:path];
    
    
    [self addSubview:self.tv];
    
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backGroundBtnView.mas_bottom);
        make.left.mas_equalTo(self.backGroundBtnView.mas_left);
        make.width.mas_equalTo(self.backGroundBtnView.mas_width);
        
    }];
    
    
    
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
    
    NSLog(@"self.tableArray count is :%ld",self.tableArray.count);
    self.label.text = self.tableArray[indexPath.row]; //返回一个值给上个控制器
    [self setHeight:frameHeight];
    
    NSLog(@"frameHeight is %f===%@",frameHeight,self.label.text);
    showList = NO;
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }];
    
    //    [[NSNotificationCenter defaultCenter] postNotificationName:@"isClickList" object:@(self.frame.size.height)];
    [self getNotificationContent];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self setHeight:frameHeight];
    
    
    showList = NO;
    
    [UIView animateWithDuration:0.025 animations:^{
        [self.tv mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
    }];
    
    [self getNotificationContent];
    
}

- (void) getNotificationContent {
    
    if (self.label.text) {
        NSString *string = [self spotTypeNum:self.label.text];
        NSLog(@"1---:%@",self.label.text);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isClickList" object:@(self.frame.size.height) userInfo:@{@"text":string}];
    } else {
        NSLog(@"2");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"isClickList" object:@(self.frame.size.height) userInfo:@{@"text":@""}];
    }
    
    
}

- (NSString *) spotTypeNum:(NSString *) string {
    //    (1=>野塘 2=>江河 3=>湖库 4=>农家乐 5=>斤塘 6=>黑坑 7=>公园 8=>海域 9=>竞技池)
    NSString *textNum = nil;
    
    if ([string isEqualToString:@"野塘"]) {
        textNum = @"1";
    } else if ([string isEqualToString:@"江河"]) {
        textNum = @"2";
    } else if ([string isEqualToString:@"湖库"]) {
        textNum = @"3";
    } else if ([string isEqualToString:@"农家乐"]) {
        textNum = @"4";
    } else if ([string isEqualToString:@"斤塘"]) {
        textNum = @"5";
    } else if ([string isEqualToString:@"黑坑"]) {
        textNum = @"6";
    } else if ([string isEqualToString:@"公园"]) {
        textNum = @"7";
    } else if ([string isEqualToString:@"海域"]) {
        textNum = @"8";
    } else if ([string isEqualToString:@"竞技池"]) {
        textNum = @"9";
    } else if ([string isEqualToString:@"钓鱼"]) {
        textNum = @"1";
    } else if ([string isEqualToString:@"露营"]) {
        textNum = @"2";
    } else if ([string isEqualToString:@"徒步"]) {
        textNum = @"3";
    } else if ([string isEqualToString:@"其他"]) {
        textNum = @"4";
    }
    
    
    //    @[@"钓鱼",@"露营",@"徒步",@"其他"]
    
    return textNum;
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
