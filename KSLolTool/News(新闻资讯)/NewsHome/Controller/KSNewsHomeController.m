//
//  KSNewsHomeController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/16.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSNewsHomeController.h"
#import "CollectionImageView.h"
#import "KSNewsHeaderModel.h"
#import "TabSliderView.h"

@interface KSNewsHomeController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CollectionImageView *collectionImage;
@property (nonatomic, strong) NSMutableArray *headerImageArray;
@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) TabSliderView *tabSliderView;
@end

@implementation KSNewsHomeController

#pragma mark - Cycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"资讯";
    [self loadDataForHttp];
    
    [self.view addSubview:self.tabSliderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Method
/**
 *  通过url请求获取数据
 */
- (void)loadDataForHttp
{
    //第一次进来先获取数据，获取第一页的数据，拿到headerline（轮播图）
    [self gethttp:1 Success:^(id response) {
        //先获取headerline
        NSArray *headerArray = [response objectForKey:@"headerline"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in headerArray) {
            KSNewsHeaderModel *model = [KSNewsHeaderModel new];
            model.photo = [dic objectForKey:@"photo"];
            model.destUrl = [dic objectForKey:@"destUrl"];
            [array addObject:model];
            [self.headerArray addObject:model.photo];
        }
        
        [self.view addSubview:self.tableView];
    } Failure:^(NSError *error) {
        
    }];
}

- (void)gethttp:(NSInteger)page Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock
{
    //http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=headlineNews&p=1
    NSString *baseUrl = @"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=headlineNews&p=";
    NSString *url = [NSString stringWithFormat:@"%@%d",baseUrl,page];
    [KSRequestTool RequestToolGetUrl:url Success:^(id response) {
        successBlock(response);
    } Failure:^(NSError *error) {
        failureBlock(error);
    }];
}

#pragma mark - tableView delegate


#pragma mark - tableview dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

#pragma mark - 懒加载
- (TabSliderView *)tabSliderView
{
    if (!_tabSliderView) {
        _tabSliderView = [[TabSliderView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 50)];
        _tabSliderView.dataArray = @[@"新闻", @"资讯"];
        _tabSliderView.returnIndexBlock = ^(NSInteger index){
            NSLog(@"控制器滑动  %d",index);
        };
    }
    return _tabSliderView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        CGFloat offsetY = StatusHeight + NavagationHeight + 50;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, offsetY, self.view.width, self.view.height - offsetY) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#warning 需要优化——目前轮播图的数据是从网络获取的，所以有数据之后才开始加载，暂时先放在这里，之后优化
        _tableView.tableHeaderView = self.collectionImage;
        _tableView.backgroundColor = [UIColor grayColor];
    }
    return _tableView;
}

- (CollectionImageView *)collectionImage
{
    if (!_collectionImage) {
        _collectionImage = [[CollectionImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 150) imageArray:self.headerArray selectImageBlock:^(NSInteger index) {
            
        }];
    }
    return _collectionImage;
}

- (NSMutableArray *)headerArray
{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}
@end
