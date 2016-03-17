//
//  KSWikiDataModel.h
//  KSLolTool
//
//  Created by xiaoshi on 16/3/15.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, WikiDataOpenType) {
    WikiDataOpenTypeDefault = 0,    //默认，一般不使用，如果是这个点击无反应
    WikiDataOpenTypeOther,          //其他类型，一般用于打开详细界面
    WikiDataOpenTypeBoxUrl,         //多玩接口的html类型
    WikiDataOpenTypeLaoyueUrl,      //捞月狗接口的html类型
    WikiDataOpenTypeQtUrl           //掌盟接口的html类型
};

@interface KSWikiDataModel : NSObject
@property (nonatomic, strong) NSString *titleName;
@property (nonatomic, strong) NSString *iconName;
@property (nonatomic, strong) NSString *clickUrl;
@property (nonatomic, assign) WikiDataOpenType openType;
/**
 *  初始化数据
 *
 *  @param titleName
 *  @param iconName
 *
 *  @return 
 */
- (instancetype)initWithTitleName:(NSString *)titleName iconName:(NSString *)iconName;

- (instancetype)initWithTitleName:(NSString *)titleName iconName:(NSString *)iconName clickUrl:(NSString *)url openType:(WikiDataOpenType) openType;

@end
