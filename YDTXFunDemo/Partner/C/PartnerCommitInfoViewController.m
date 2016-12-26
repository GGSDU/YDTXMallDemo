//
//  PartnerCommitInfoViewController.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/26.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "PartnerCommitInfoViewController.h"

@interface PartnerCommitInfoViewController ()<UIScrollViewDelegate>

@property(strong,nonatomic)UIScrollView *baseScrollerView;
@property(strong,nonatomic)UITextField *nameTF;
@property(strong,nonatomic)UITextField *PersonIDTF;
@property(strong,nonatomic)UITextField *phoneNumTF;




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
    _baseScrollerView.backgroundColor = [UIColor yellowColor];
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
    UIView *leftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 45)];
    leftView.backgroundColor = [UIColor clearColor];
    //添加图片
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    headView.image = [UIImage imageNamed:@"姓名"];
    [leftView addSubview:headView];
    
    _nameTF.leftView = leftView;
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
    
    self.PersonIDTF = _PersonIDTF;
    self.PersonIDTF.delegate = self;
    //设置左边添加的图片
    //文本框左视图
    UIView *IDleftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 45)];
    leftView.backgroundColor = [UIColor clearColor];
    //添加图片
    UIImageView *IDheadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    IDheadView.image = [UIImage imageNamed:@"身份证"];
    [IDleftView addSubview:IDheadView];
    
    _PersonIDTF.leftView = IDleftView;
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
    
    
    self.phoneNumTF.delegate = self;
    //设置左边添加的图片
    //文本框左视图
    UIView *phoneleftView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 45)];
    leftView.backgroundColor = [UIColor clearColor];
    //添加图片
    UIImageView *phoneheadView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    phoneheadView.image = [UIImage imageNamed:@"手机号"];
    [phoneleftView addSubview:phoneheadView];
    
    _phoneNumTF.leftView = phoneleftView;
    _phoneNumTF.leftViewMode = UITextFieldViewModeAlways;
    

    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
