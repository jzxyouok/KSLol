//
//  KSNewsHeaderModel.h
//  KSLolTool
//
//  Created by xiaoshi on 16/3/16.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSNewsHeaderModel : NSObject

@property (nonatomic, copy) NSString *weight;

@property (nonatomic, copy) NSString *commentUrl;

//@property (nonatomic, copy) NSString *id;
/**
 *  详情url
 */
@property (nonatomic, copy) NSString *destUrl;
/**
 *  图片地址
 */
@property (nonatomic, copy) NSString *photo;

@property (nonatomic, copy) NSString *artId;

@property (nonatomic, assign) NSInteger commentSum;

@end
