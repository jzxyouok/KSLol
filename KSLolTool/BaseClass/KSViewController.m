//
//  KSViewController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSViewController.h"

@interface KSViewController ()
@property (nonatomic, strong) UIImageView *noDataImageView;
@end

@implementation KSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.noDataImageView];
    [self setNoDataViewHide:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setNoDataViewHide:(BOOL)isHide
{
    self.noDataImageView.hidden = isHide;
}

- (UIImageView *)noDataImageView
{
    if (!_noDataImageView) {
        _noDataImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"noDataImage"]];
        [_noDataImageView sizeToFit];
        _noDataImageView.center = self.view.center;
    }
    return _noDataImageView;
}

@end
