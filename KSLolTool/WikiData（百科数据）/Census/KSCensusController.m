//
//  KSCensusController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/17.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSCensusController.h"
#import "KSWikiDataModel.h"
#import "KSFirstWebController.h"

@interface KSCensusController ()

@end

@implementation KSCensusController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setWebViewWithWebType:WebTypeUrl urlString:_model.clickUrl htmlString:nil title:_model.titleName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openNewView:(NSString *)url
{
    KSFirstWebController *ctrl = [[KSFirstWebController alloc] init];
    ctrl.urlStr = url;
    [self.navigationController pushViewController:ctrl animated:YES];
}

@end
