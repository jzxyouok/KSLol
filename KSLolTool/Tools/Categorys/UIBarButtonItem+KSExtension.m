//
//  UIBarButtonItem+KSExtension.m
//  KSWeibo
//
//  Created by xiaoshi on 16/3/11.
//  Copyright © 2016年 kamy. All rights reserved.
//

#import "UIBarButtonItem+KSExtension.h"

@implementation UIBarButtonItem (KSExtension)

+ (UIBarButtonItem *)initWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [itemBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight",imageName]] forState:UIControlStateHighlighted];
    itemBtn.size = itemBtn.currentImage.size;
    [itemBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
}

+ (UIBarButtonItem *)initBackWithImageName:(NSString *)imageName target:(id)target action:(SEL)action title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlight",imageName]] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
