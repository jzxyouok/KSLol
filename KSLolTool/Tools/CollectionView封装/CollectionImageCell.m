//
//  CollectionImageCell.m
//  CollectionView轮播图
//
//  Created by xiaoshi on 16/2/17.
//  Copyright © 2016年 kamy. All rights reserved.
//

#import "CollectionImageCell.h"
#import "UIImageView+WebCache.h"

@interface CollectionImageCell()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CollectionImageCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addSubview:self.imageView];
        
        self.imageView.frame = self.bounds;
    }
    return self;
}

- (void)setImageUrl:(NSString *)imageUrl
{
    _imageUrl = imageUrl;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_imageUrl] placeholderImage:[UIImage imageNamed:@"startImage"]];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
