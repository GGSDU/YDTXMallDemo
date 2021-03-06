//
//  ViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 06/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "ViewController.h"

#import "CartViewController.h"
#import "ShopMarketController.h"

#import "AddDetailMessageViewController.h"
#import "ReceiveTableViewController.h"

//
#import "MarketCategoryListViewController.h"
#import "MarketCheakOrderInfoViewController.h"
#import "PartnerViewController.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor redColor];
    
    CGSize size = CGSizeMake(80, 40);
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
            ShopMarketController *smVC = [[ShopMarketController alloc] init];
            [self.navigationController pushViewController:smVC animated:YES];
    
        }
            break;
        case 1:
        {
            ReceiveTableViewController *vc = [ReceiveTableViewController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 4:
        {
            [aSender setTitle:@"舒通" forState:UIControlStateNormal];
            
            AddDetailMessageViewController *vc = [AddDetailMessageViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
            break;
 
            
        //商品列表
        case 6:
        {
            MarketCategoryListViewController *markListVC = [[MarketCategoryListViewController alloc]initWithCollectionViewLayout:[UICollectionViewLayout new]];
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
        //合伙人
            case 8:
        {
            PartnerViewController *partnerVC = [PartnerViewController new];
            [self.navigationController pushViewController:partnerVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}

@end
