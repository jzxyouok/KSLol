//
//  KSRequestTool.h
//  KSLolTool
//
//  Created by xiaoshi on 16/3/16.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id response);
typedef void(^FailureBlock)(NSError *error);

@interface KSRequestTool : NSObject
+ (void)RequestToolGetUrl:(NSString *)url Success:(SuccessBlock)successBlock Failure:(FailureBlock)failureBlock;
@end
