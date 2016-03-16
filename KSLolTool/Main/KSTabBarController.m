//
//  KSTabBarController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSTabBarController.h"
#import "KSViewController.h"
#import "KSWikiDataController.h"
#import "KSNavigationController.h"
@interface KSTabBarController ()

@end

@implementation KSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KSViewController *v1 = [[KSViewController alloc] init];
    [self addChildViewController:v1 barImageName:@"tabbar_me"];
    KSViewController *v2 = [[KSViewController alloc] init];
    [self addChildViewController:v2 barImageName:@"tabbar_me"];
    KSWikiDataController *v3 = [[KSWikiDataController alloc] init];
    [self addChildViewController:v3 barImageName:@"tabbar_me"];
    KSViewController *v4 = [[KSViewController alloc] init];
    [self addChildViewController:v4 barImageName:@"tabbar_me"];
}

- (void)addChildViewController:(UIViewController *)childController barImageName:(NSString *)imageName
{
    //childController.tabBarItem.title = @"测试";
    [childController.tabBarItem setImage:[UIImage imageNamed:imageName]];
    [childController.tabBarItem setSelectedImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight",imageName]]];
    KSNavigationController *controller = [[KSNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:controller];
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
