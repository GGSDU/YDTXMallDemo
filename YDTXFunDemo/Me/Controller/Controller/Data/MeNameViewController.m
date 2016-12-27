//
//  MeNameViewController.m
//  YDTX
//
//  Created by 舒通 on 16/9/8.
//  Copyright © 2016年 RookieHua. All rights reserved.
//

#import "MeNameViewController.h"


@interface MeNameViewController ()<UITextFieldDelegate,UITextViewDelegate>



@end

@implementation MeNameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.918 alpha:1.000];

}
#warning UITextFile
- (void)creatTextFile{
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder = @"未填写";
    self.textField.delegate = self;
    self.textField.backgroundColor = [UIColor whiteColor];
    [self.textField becomeFirstResponder];
    self.textField.borderStyle = UITextBorderStyleNone;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20*WidthScale, 42*HeightScale)];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = leftView;
    self.textField.font = [UIFont systemFontOfSize:18*HeightScale];

    
    [self.view addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30*HeightScale);
        make.left.mas_equalTo(self.view).offset(5*WidthScale);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*WidthScale, 45*HeightScale));
        
    }];
    
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightBut:)];
    rightBut.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBut;

    
}
- (void)rightBut:(UIBarButtonItem *)sender {
    [self.textField resignFirstResponder];
//    if (self.textField.text.length == 0) {
//        [self.navigationController popViewControllerAnimated:YES];
//    }else {
        self.finishInputMsgBlock(self.textField.text);
        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#warning UITextView

- (void)creatTextView {
    
    self.textView = [[UITextView alloc]init];
    self.textView.font = [UIFont systemFontOfSize:18*HeightScale];
    self.textView.backgroundColor = [UIColor whiteColor];
    [self.textView becomeFirstResponder];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor colorWithRed:0.886 green:0.894 blue:0.886 alpha:1.000].CGColor;
    self.textView.delegate = self;
    
    UIBezierPath *bezi = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,10,20)];
    self.textView.textContainer.exclusionPaths=@[bezi];
    self.textView.translatesAutoresizingMaskIntoConstraints=YES;
    self.textView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5*HeightScale);
        make.top.mas_equalTo(30*HeightScale);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-10*HeightScale, 150*HeightScale));
    }];
//
    
    
    self.placeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.placeLabel.font = [UIFont systemFontOfSize:15];
    self.placeLabel.text = @"请输入签名";
    self.placeLabel.textColor = [UIColor colorWithWhite:0.906 alpha:1.000];
    [self.textView addSubview:self.placeLabel];

    
    
    UISwipeGestureRecognizer *swipeG = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeG:)];
    swipeG.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeG1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeG:)];
    swipeG1.direction = UISwipeGestureRecognizerDirectionLeft;
    
    UISwipeGestureRecognizer *swipeG2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeG:)];
    swipeG2.direction = UISwipeGestureRecognizerDirectionUp;
    
    UISwipeGestureRecognizer *swipeG3 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeG:)];
    swipeG3.direction = UISwipeGestureRecognizerDirectionDown;
    
    
    [self.textView addGestureRecognizer:swipeG];
    [self.textView addGestureRecognizer:swipeG1];
    [self.textView addGestureRecognizer:swipeG2];
    [self.textView addGestureRecognizer:swipeG3];
    
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightB:)];
    rightBut.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}
- (void)swipeG:(UIGestureRecognizer *)gesture {
    if ([self.textView isFirstResponder]) {
        [self.textView resignFirstResponder];
    }
}
- (void)rightB:(UIBarButtonItem *)sender {
    [self.textView resignFirstResponder];
    if (self.textView.text.length == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        self.finishInputMsgBlock(self.textView.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
//    self.placeLabel.text = @"";
    
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    self.placeLabel.text = @"";
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
