//
//  ViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ViewController.h"

#import "SXAdjustNumberView.h"
#import "CartViewController.h"


//
#import "MarketListViewController.h"
#import "MarketCheakOrderInfoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    CGSize size = CGSizeMake(40, 20);
    float originX = 20;
    float originY = 80;
    float gap = 20;
    int count = 375 / (gap + size.width);
    // commit test
    // commit test
    for (int i = 0; i < 10; i ++) {
        int x = i / count;
        int y = i % count;
        UIButton *jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(originX + y * (gap + size.width), originY + x * (gap + size.height), size.width, size.height)];
        jumpButton.backgroundColor = [UIColor blueColor];
        jumpButton.titleLabel.font = [UIFont systemFontOfSize:10];
        jumpButton.titleLabel.textColor = [UIColor whiteColor];
        [jumpButton setTitle:[NSString stringWithFormat:@"button%d",i] forState:UIControlStateNormal];
        jumpButton.tag = i;
        [jumpButton addTarget:self action:@selector(jumpButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:jumpButton];
        [jumpButton release];
    }
    
}

- (void)jumpButtonClick:(UIButton *)aSender
{
    switch (aSender.tag) {
        case 0:
        {
            NSMutableArray *modelArray = [[NSMutableArray alloc] initWithCapacity:10];
            for (int i = 0; i < 10; i++) {
                ProductModel *pModel = [[ProductModel alloc] init];
                pModel.infoImageURL = @"http://avatar.csdn.net/2/2/4/1_story51314.jpg";
                pModel.infoName = [NSString stringWithFormat:@"infoName %d",i];
                pModel.modelType = [NSString stringWithFormat:@"model : xx%d",i];
                pModel.price = i * 1.0f + 100.0f;
                pModel.number = i + 1;
                [modelArray addObject:pModel];
            }
            CartViewController *cartVC = [[CartViewController alloc] init];
            cartVC.productModelArray = modelArray;
            [self.navigationController pushViewController:cartVC animated:YES];
    
        }
            break;
         
        //商品列表
        case 6:
        {
            MarketListViewController *markListVC = [[MarketListViewController alloc]initWithCollectionViewLayout:[UICollectionViewLayout new]];
            [self.navigationController pushViewController:markListVC animated:YES];
        
        }
        
            break;
        //确认订单
            case 7:
        {
            MarketCheakOrderInfoViewController *marketCheckOrderInfoVC = [MarketCheakOrderInfoViewController new];
            [self.navigationController pushViewController:marketCheckOrderInfoVC animated:YES];
        
        
        }
            
            
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
