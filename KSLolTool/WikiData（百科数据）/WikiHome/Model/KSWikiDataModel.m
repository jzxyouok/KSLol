//
//  KSWikiDataModel.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSWikiDataModel.h"

@implementation KSWikiDataModel
- (instancetype)initWithTitleName:(NSString *)titleName iconName:(NSString *)iconName
{
    self = [super init];
    if (self) {
        _titleName = titleName;
        _iconName = iconName;
    }
    return self;
}
@end
