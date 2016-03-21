//
//  KSNewsHomeController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/16.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//
#import "GDTMobBannerView.h"
#import "GDTSplashAd.h"
#import "KSNewsHomeController.h"
#import "CollectionImageView.h"
#import "KSNewsHeaderModel.h"
#import "TabSliderView.h"

@interface KSNewsHomeController ()<UITableViewDelegate, UITableViewDataSource,GDTSplashAdDelegate>
{
    GDTSplashAd *_splash;
    GDTMobBannerView *_banner;
}
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
    [self loadSplash];
    [self initBanner];
}

- (void)loadSplash
{
    //开屏广告初始化
    _splash = [[GDTSplashAd alloc] initWithAppkey:GDT_APP_KEY placementId:GDT_SPLASH];
    _splash.delegate = self;//设置代理
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

- (void)initBanner
{
    _banner = [[GDTMobBannerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 100, SCREEN_WIDTH, 50) appkey:GDT_APP_KEY placementId:GDT_BANNER_ID];
    _banner.currentViewController = self;
    _banner.interval = 30;
    _banner.isAnimationOn = YES;
    [self.view addSubview:_banner];
}

- (void)loadBanner
{
    [_banner loadAdAndShow];
}

- (void)splashAdClosed:(GDTSplashAd *)splashAd
{
    [self performSelector:@selector(loadBanner) withObject:nil afterDelay:5.0f];
}

- (void)splashAdClicked:(GDTSplashAd *)splashAd
{
    [self performSelector:@selector(loadBanner) withObject:nil afterDelay:10.0f];
}
- (void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    [self performSelector:@selector(loadBanner) withObject:nil afterDelay:5.0f];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
