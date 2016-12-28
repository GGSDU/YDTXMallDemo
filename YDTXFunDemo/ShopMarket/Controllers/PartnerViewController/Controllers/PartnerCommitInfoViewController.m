//
//  PartnerCommitInfoViewController.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/26.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "PartnerCommitInfoViewController.h"
#import "PayWayView.h"
@interface PartnerCommitInfoViewController ()<UIScrollViewDelegate,UITextFieldDelegate,UIActionSheetDelegate>

@property(strong,nonatomic)UIScrollView *baseScrollerView;
@property(strong,nonatomic)UITextField *nameTF;
@property(strong,nonatomic)UITextField *PersonIDTF;
@property(strong,nonatomic)UITextField *phoneNumTF;
@property(strong,nonatomic)UIButton *SexBtn;
@property(strong,nonatomic)UIButton *payBtn;
@property(strong,nonatomic)PayWayView *payView;


@end

@implementation PartnerCommitInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBasic];
    [self setUI];

}

-(void)setBasic{

    

}

-(void)setUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _baseScrollerView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _baseScrollerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_baseScrollerView];
    
    
    
    //姓名Label
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    nameLabel.text = @"姓名";
    
    [_baseScrollerView addSubview:nameLabel];
    
    nameLabel.frame = CGRectMake(20*WidthScale, 20*HeightScale, 100, 19);
    
    //    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(self.view).offset(20 * HeightScale);
    //        make.leading.equalTo(self.view).offset(20*WidthScale);
    //
    //    }];
    
    
    
    //姓名textfiled
    
    _nameTF = [[UITextField alloc]init];
    _nameTF.layer.borderWidth = 1;
    _nameTF.layer.borderColor = [UIColor colorWithRed:0.867 green:0.875 blue:0.882 alpha:1.000].CGColor;
    _nameTF.layer.masksToBounds = YES;
    _nameTF.layer.cornerRadius = 5;
    
    _nameTF.placeholder = @"请输入您的姓名";
    
    _nameTF.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    _nameTF.font = [UIFont systemFontOfSize:15];
    [_baseScrollerView addSubview:_nameTF];
    
    [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(10 * HeightScale);
        make.leading.equalTo(nameLabel);
        //        make.trailing.equalTo(scView).offset(-20);
        make.width.equalTo(self.view).offset(-40*WidthScale);
        make.height.equalTo(@45);
    }];
    
    _nameTF.delegate = self;
    
    //设置左边添加的图片
    //文本框左视图
    //添加图片
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    headView.image = [UIImage imageNamed:@"Name_icon"];
    _nameTF.leftView = headView;
    _nameTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    //身份证Label
    UILabel *PersonIDLabel = [[UILabel alloc]init];
    PersonIDLabel.font = [UIFont systemFontOfSize:15];
    PersonIDLabel.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    PersonIDLabel.text = @"身份证";
    
    [_baseScrollerView addSubview:PersonIDLabel];
    
    [PersonIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameTF.mas_bottom).offset(20 * HeightScale);
        make.leading.equalTo(self.view).offset(20*WidthScale);
        
    }];
    
    
    //身份证textfiled
    
    _PersonIDTF = [[UITextField alloc]init];
    _PersonIDTF.layer.borderWidth = 1;
    _PersonIDTF.layer.borderColor = [UIColor colorWithRed:0.867 green:0.875 blue:0.882 alpha:1.000].CGColor;
    _PersonIDTF.layer.masksToBounds = YES;
    _PersonIDTF.layer.cornerRadius = 5;
    
    _PersonIDTF.placeholder = @"请输入您的身份证";
    
    _PersonIDTF.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    _PersonIDTF.font = [UIFont systemFontOfSize:15];
    [_baseScrollerView addSubview:_PersonIDTF];
    
    [_PersonIDTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PersonIDLabel.mas_bottom).offset(10 * HeightScale);
        make.leading.equalTo(_nameTF);
        //        make.trailing.equalTo(scView).offset(-20);
        make.width.equalTo(self.view).offset(-40*WidthScale);
        make.height.equalTo(@45);
    }];
    
    
    _PersonIDTF.delegate = self;
    //设置左边添加的图片
    //文本框左视图
    UIImageView *IDheadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    IDheadView.image = [UIImage imageNamed:@"PersonID_icon"];
    _PersonIDTF.leftView = IDheadView;
    _PersonIDTF.leftViewMode = UITextFieldViewModeAlways;
    
    
    
    
    
    
    //手机号Label
    UILabel *PhoneNumLabel = [[UILabel alloc]init];
    PhoneNumLabel.font = [UIFont systemFontOfSize:15];
    PhoneNumLabel.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    PhoneNumLabel.text = @"手机号";
    
    [_baseScrollerView addSubview:PhoneNumLabel];
    
    [PhoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_PersonIDTF.mas_bottom).offset(20 * HeightScale);
        make.leading.equalTo(self.view).offset(20*WidthScale);
        
    }];
    
    
    //手机号textfiled
    
    _phoneNumTF = [[UITextField alloc]init];
    _phoneNumTF.layer.borderWidth = 1;
    _phoneNumTF.layer.borderColor = [UIColor colorWithRed:0.867 green:0.875 blue:0.882 alpha:1.000].CGColor;
    _phoneNumTF.layer.masksToBounds = YES;
    _phoneNumTF.layer.cornerRadius = 5;
    
    _phoneNumTF.placeholder = @"请输入您的手机号";
    
    _phoneNumTF.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    _phoneNumTF.font = [UIFont systemFontOfSize:15];
    [_baseScrollerView addSubview:_phoneNumTF];
    
    [_phoneNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(PhoneNumLabel.mas_bottom).offset(10 * HeightScale);
        make.leading.equalTo(_nameTF);
        //        make.trailing.equalTo(scView).offset(-20);
        make.width.equalTo(self.view).offset(-40*WidthScale);
        make.height.equalTo(@45);
    }];
    
    
    _phoneNumTF.delegate = self;
    //设置左边添加的图片
    //添加图片
    UIImageView *phoneheadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    phoneheadView.image = [UIImage imageNamed:@"PhoneNum_icon"];
    _phoneNumTF.leftView = phoneheadView;
    _phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    

    
    //性别Label
    
    UILabel *SexLabel = [[UILabel alloc]init];
    SexLabel.font = [UIFont systemFontOfSize:15];
    SexLabel.textColor = [UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000];
    SexLabel.text = @"性别";
    
    [_baseScrollerView addSubview:SexLabel];
    
    [SexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneNumTF.mas_bottom).offset(20 * HeightScale);
        make.leading.equalTo(self.view).offset(20*WidthScale);
        
    }];
    
    
    //性别Btn
    _SexBtn = [[UIButton alloc]init];
    _SexBtn.layer.borderWidth = 1;
    _SexBtn.layer.borderColor = [UIColor colorWithRed:0.867 green:0.875 blue:0.882 alpha:1.000].CGColor;
    _SexBtn.layer.masksToBounds = YES;
    _SexBtn.layer.cornerRadius = 5;
    [_SexBtn setTitle:@"男" forState:UIControlStateNormal];
    [_SexBtn setTitleColor:[UIColor colorWithRed:0.639 green:0.667 blue:0.690 alpha:1.000] forState:UIControlStateNormal];
    [_SexBtn setImage:[UIImage imageNamed:@"arrow_icon"] forState:UIControlStateNormal];
    [_SexBtn addTarget:self action:@selector(chooseSexInfo) forControlEvents:UIControlEventTouchUpInside];
    [_SexBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 55, 0, 0)];
    [_SexBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,-80, 0, 0)];
    [_baseScrollerView addSubview:_SexBtn];
    [_SexBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SexLabel.mas_bottom).offset(20*HeightScale);
        make.leading.equalTo(self.view).offset(20*WidthScale);
        make.width.mas_equalTo(100);
    }];
    
    
    //支付页
    _payView = [[PayWayView alloc]init];
    _payView.layer.borderWidth = 1;
    _payView.layer.borderColor = [UIColor colorWithRed:0.867 green:0.875 blue:0.882 alpha:1.000].CGColor;
    _payView.layer.masksToBounds = YES;
    _payView.layer.cornerRadius = 5;
    [_baseScrollerView addSubview:_payView];
    [_payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_SexBtn.mas_bottom).offset(40*HeightScale);
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
        make.size.mas_equalTo(CGSizeMake(YDTXScreenW- 40, 88));
    }];
    
    //支付按钮
    _payBtn = [[UIButton alloc]init];
    [_payBtn setTitle:@"立即参与" forState:UIControlStateNormal];
    [_payBtn setBackgroundColor:RGB(254, 148, 2)];
    _payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_payBtn addTarget:self action:@selector(JionYun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];

    
    
    
    _baseScrollerView.contentSize = CGSizeMake(YDTXScreenW, YDTXScreenH +50);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)chooseSexInfo{

    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择性别！" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
    [sheet showInView:self.view];

}

-(void)JionYun{



}
#pragma system --ationSheet --delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"下标：%ld",buttonIndex);
    
    if (buttonIndex == 0) {
        
        [_SexBtn setTitle:@"男" forState:UIControlStateNormal];
    }else if (buttonIndex == 1){
    
        [_SexBtn setTitle:@"女" forState:UIControlStateNormal];
    }
    
    
}

@end
