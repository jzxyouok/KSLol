//
//  KSTabBarController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//
#import "GDTSplashAd.h"
#import "KSTabBarController.h"
#import "KSViewController.h"
#import "KSNewsHomeController.h"
#import "KSWikiDataController.h"
#import "KSNavigationController.h"
@interface KSTabBarController ()
{
    GDTSplashAd *_splash;
}
@end

@implementation KSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    KSNewsHomeController *v1 = [[KSNewsHomeController alloc] init];
    [self addChildViewController:v1 barImageName:@"tabbar_me"];
    KSViewController *v2 = [[KSViewController alloc] init];
    [self addChildViewController:v2 barImageName:@"tabbar_me"];
    KSWikiDataController *v3 = [[KSWikiDataController alloc] init];
    [self addChildViewController:v3 barImageName:@"tabbar_me"];
    KSViewController *v4 = [[KSViewController alloc] init];
    [self addChildViewController:v4 barImageName:@"tabbar_me"];
    
    //[self loadSplash];
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

- (void)loadSplash
{
    //开屏广告初始化
    _splash = [[GDTSplashAd alloc] initWithAppkey:GDT_APP_KEY placementId:GDT_SPLASH];
    //_splash.delegate = self;//设置代理
    //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
        _splash.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage-568h"]];
    } else {
        _splash.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LaunchImage"]];
    }
    
    UIWindow *fK = [[UIApplication sharedApplication] keyWindow];
    //设置开屏拉取时长限制，若超时则不再展示广告
    _splash.fetchDelay = 3;
    //拉取并展示
    [_splash loadAdAndShowInWindow:fK];
}

@end
