//
//  KSNewestController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/22.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSNewestController.h"
#import "CollectionImageView.h"
#import "KSNewsHeaderModel.h"

@interface KSNewestController ()
@property (nonatomic, strong) NSMutableArray *headerArray;
@property (nonatomic, strong) CollectionImageView *collectionImage;
@property (nonatomic, strong) NSMutableArray *headerImageArray;
@end

@implementation KSNewestController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataForHttp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Method   顶部数据
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
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.headerArray count] > 0) {
        return self.collectionImage;
    }
    return nil;
}

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
