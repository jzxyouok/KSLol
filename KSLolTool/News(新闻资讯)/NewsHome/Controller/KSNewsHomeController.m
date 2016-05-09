//
//  KSNewsHomeController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/16.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSNewsHomeController.h"
#import "KSRequestTool.h"
#import "TabSliderView.h"
#import "KSNewestController.h"
#import "KSVideoController.h"

@interface KSNewsHomeController ()
{
    NSArray *_tabDataArray;
}
@property (nonatomic, strong) TabSliderView *tabSliderView;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation KSNewsHomeController

#pragma mark - Cycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"资讯";
    [self loadTabIndexData];
    [self addChildViewController:[[KSNewestController alloc] init]];
    [self addChildViewController:[[KSViewController alloc] init]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTabIndexData
{
    [KSRequestTool RequestToolGetUrl:[NSString stringWithFormat:@"%@index.js",Qt_BaseUrl] Success:^(id response) {
        _tabDataArray = [NSArray yy_modelArrayWithClass:[KSNewsIndexModel class] json:response];
        [self.view addSubview:self.tabSliderView];
        [self.view addSubview:self.scrollView];
    } Failure:^(NSError *error) {
        
    }];
}

#pragma mark - 懒加载
- (TabSliderView *)tabSliderView
{
    if (!_tabSliderView) {
        _tabSliderView = [[TabSliderView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 50)];
        _tabSliderView.dataArray = _tabDataArray;
        _tabSliderView.returnIndexBlock = ^(NSInteger index){
            NSLog(@"控制器滑动  %d",index);
        };
    }
    return _tabSliderView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        CGFloat offsetY = StatusHeight + NavagationHeight + 49 + self.tabSliderView.height;
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tabSliderView.frame), self.view.width, self.view.height - offsetY)];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

//- (UITableView *)tableView
//{
//    if (!_tableView) {
//        CGFloat offsetY = StatusHeight + NavagationHeight + 50;
//        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, offsetY, self.view.width, self.view.height - offsetY) style:UITableViewStylePlain];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//#warning 需要优化——目前轮播图的数据是从网络获取的，所以有数据之后才开始加载，暂时先放在这里，之后优化
//        _tableView.tableHeaderView = self.collectionImage;
//        _tableView.backgroundColor = [UIColor grayColor];
//    }
//    return _tableView;
//}

@end
