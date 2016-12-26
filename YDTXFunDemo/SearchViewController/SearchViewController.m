//
//  SearchViewController.m
//  YDTXFunDemo
//
//  Created by Story5 on 23/12/2016.
//  Copyright © 2016 Story5. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (nonatomic,strong) UISearchBar *searchBar;

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
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(15, navigationBarFrame.origin.y + (navigationBarFrame.size.height - 30) / 2, self.view.frame.size.width - 30, 30)];
    [self.view addSubview:self.searchBar];
}

@end
