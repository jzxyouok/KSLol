//
//  KSWikiDataController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//
#import "GDTMobInterstitial.h"
#import "KSWikiDataController.h"
#import "KSWikiDataView.h"
#import "KSWikiDataViewCell.h"
#import "KSCensusController.h"

@interface KSWikiDataController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    GDTMobInterstitial *_interst;
}
@property (nonatomic, strong)UICollectionView *collectionView;

//data
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation KSWikiDataController
NSString *const cellIdentifier = @"KSWikiDataViewCell";
#pragma mark - Cycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"百科数据";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self loadData];
    
    [self.view addSubview:self.collectionView];
    [self initInterst];
}

- (void)initInterst
{
    _interst = [[GDTMobInterstitial alloc]initWithAppkey:GDT_APP_KEY placementId:GDT_INTERS];
    _interst.isGpsOn = YES;
    [_interst loadAd];
}

- (void)loadInterst
{
    UIViewController *vc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    [_interst presentFromRootViewController:vc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    [self performSelector:@selector(loadInterst) withObject:nil afterDelay:2.0f];
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
- (void)loadData
{
    KSWikiDataModel *censuModel = [[KSWikiDataModel alloc] initWithTitleName:@"人口普查" iconName:@"" clickUrl:@"http://h5v2.laoyuegou.com/lol/census.html" openType:WikiDataOpenTypeLaoyueUrl];
    self.dataArray = [NSMutableArray arrayWithObjects:censuModel, nil];
}

#pragma mark - collectionView delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    KSWikiDataModel *model = self.dataArray[indexPath.row];
    //多玩数据提取中间的html代码显示
    //捞月狗数据直接是url显示
    KSCensusController *ctrl = [[KSCensusController alloc]init];
    ctrl.model = model;
    [self.navigationController pushViewController:ctrl animated:YES];
}
#pragma mark - collectionView dataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KSWikiDataViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    //刚加载的时候 添加数据
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.itemSize = CGSizeMake((self.view.width - 10)/3, self.view.width/3 + 20);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64 - 49) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[KSWikiDataViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    }
    return _collectionView;
}

@end
