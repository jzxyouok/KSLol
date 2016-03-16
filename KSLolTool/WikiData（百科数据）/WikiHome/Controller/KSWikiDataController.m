//
//  KSWikiDataController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSWikiDataController.h"
#import "KSWikiDataView.h"

@interface KSWikiDataController ()

@end

@implementation KSWikiDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"百科数据";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
    
    KSWikiDataView *view = [[KSWikiDataView alloc]initWithFrame:CGRectMake(0, 64, 50, 70)];
    view.model = [[KSWikiDataModel alloc] initWithTitleName:@"测试" iconName:@"tabbar_me_highlight"];
    [self.view addSubview:view];
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
