//
//  KSBaseHtmlController.h
//  KSLolTool
//
//  Created by xiaoshi on 16/3/17.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSViewController.h"

typedef NS_ENUM(NSUInteger,WebType) {
    WebTypeUrl = 1,
    WebTypeHtml
};


@interface KSBaseHtmlController : KSViewController

/**
 *  url地址
 */
@property (nonatomic, strong) NSString *urlStr;
/**
 *  标题
 */
@property (nonatomic, strong) NSString *titleStr;
- (void)setWebViewWithWebType:(WebType)webType urlString:(NSString *)url htmlString:(NSString *)html title:(NSString *)title;

- (void)openNewView:(NSString *)url;
@end
