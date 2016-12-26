//
//  SearchViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 23/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic,strong) NSMutableArray *resultArray;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGB(238, 238, 238);
    
    
    
    [self createSearchBar];
}

- (void)createSearchBar
{
    float originX = 15;
    float height = 30;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(originX, 0, CGRectGetWidth(self.view.bounds) - originX, height)];
    self.searchBar.searchBarStyle = UISearchBarStyleDefault;
    self.searchBar.showsCancelButton = YES;
    self.searchBar.placeholder = @"输入商品名称";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    
    self.navigationItem.hidesBackButton = YES;
}

@end
