//
//  KSWikiDataModel.h
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSWikiDataModel : NSObject
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *iconName;
/**
 *  初始化数据
 *
 *  @param titleName
 *  @param iconName
 *
 *  @return 
 */
- (instancetype)initWithTitleName:(NSString *)titleName iconName:(NSString *)iconName;

@end
