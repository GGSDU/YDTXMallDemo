//
//  CategoryView.m
//  YDTXFunDemo
//
//  Created by RookieHua on 2016/12/20.
//  Copyright © 2016年 Story5. All rights reserved.
//

#import "CategoryView.h"
#import "PartnerModel.h"
#import "CategoryWebView.h"
@interface CategoryView ()


@property (strong,nonatomic)CategoryWebView *categoryWebView;
@property (strong,nonatomic)UIButton *selectBtn;
@property (strong,nonatomic)UIButton *payBtn;

@property (strong,nonatomic)NSMutableArray *categoryDataArr;
@end

@implementation CategoryView
//lazy
-(NSMutableArray *)categoryDataArr{
    if (!_categoryDataArr) {
        _categoryDataArr = [NSMutableArray array];
    }
    return _categoryDataArr;
}

-(CategoryWebView *)categoryWebView{
    if (!_categoryWebView) {
        _categoryWebView = [[CategoryWebView alloc]init];
    }
    return _categoryWebView;

}

-(void)setUIWithDataArr:(NSArray *)DataArr{

    if (DataArr) {
        //循环创建btn
        
        CGFloat btnW = (YDTXScreenW -100) /DataArr.count ;
        for (int i = 0; i < DataArr.count; i++) {
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(i *(btnW +30) +20 , 17.5, btnW, 35)];
            [btn setTitle:DataArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:RGB(189, 189, 189)];
            btn.layer.cornerRadius = 5;
            btn.layer.masksToBounds = YES;
            btn.tag = i + 6;
            [btn addTarget:self action:@selector(changeStatusWithBtn:) forControlEvents:UIControlEventTouchUpInside];
            //布局
            [self addSubview:btn];

        }
        
        [self changeStatusWithBtn:self.subviews[0]];
        
    }else{
    
        return;
    }
    

}


-(void)changeStatusWithBtn:(UIButton *)btn{

    //先处理btn状态
    [btn setBackgroundColor:RGB(254, 148, 2)];
    
    [self.selectBtn setBackgroundColor:RGB(189, 189, 189)];
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;

    NSLog(@"tag===>:%ld",(long)btn.tag);
    
    [self setPayViewWithBtnTag:btn.tag];
    [self loadPartnerRightsExplainDataWithType:btn.tag];

}

-(void)setPayViewWithBtnTag:(NSInteger)tag{

    if (tag == 6) {
        _payBtn = [[UIButton alloc]init];
        [_payBtn setTitle:@"立即参与" forState:UIControlStateNormal];
        [_payBtn setBackgroundColor:RGB(254, 148, 2)];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.superview addSubview:_payBtn];
        [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.superview);
            make.right.equalTo(self.superview);
            make.bottom.equalTo(self.superview);
            make.height.mas_equalTo(50);
        }];
        
    }else{
        [_payBtn removeFromSuperview];
        return;
    }

}

#pragma mark --loadDataMethod
//加载合伙人权益说明
-(void)loadPartnerRightsExplainDataWithType:(NSInteger) type{
    
    NSString *urlString = @"http://test.m.yundiaoke.cn/api/partner/partner_right";
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"type"] = @(type);

    
    [[NetWorkService shareInstance] GET:urlString parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"--合伙人权益--：%@",responseObject);
        
        if ([responseObject[@"status"] integerValue] == 200) {
            
            
//            self.categoryDataArr = [PartnerModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            NSString *htmlStr = responseObject[@"data"][@"right"];
//            PartnerModel *model = self.categoryDataArr[0];
            [self SendDelegateWithHtmlString:htmlStr];
            
          
            
        }else if([responseObject[@"status"] integerValue] == 400){
            [RHNotiTool NotiShowWithTitle:@"刷新失败" Time:1.0];
            
        }else if([responseObject[@"status"] integerValue] == 401){
            [RHNotiTool NotiShowWithTitle:@"刷新失败" Time:1.0];
        }else if([responseObject[@"status"] integerValue] == 403){
            [RHNotiTool NotiShowWithTitle:@"刷新失败" Time:1.0];
        }
        

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error---:%@",error);
        
        [RHNotiTool NotiShowWithTitle:@"网络出错了~" Time:1.0];
        
    }];


}


#pragma Send-delegte-Method
-(void)SendDelegateWithHtmlString:(NSString *)htmlstring{

    if ([self.delegate respondsToSelector:@selector(updateWebViewInfoWithHtmlString:)]) {
        [self.delegate updateWebViewInfoWithHtmlString:htmlstring];
    }

}

@end
