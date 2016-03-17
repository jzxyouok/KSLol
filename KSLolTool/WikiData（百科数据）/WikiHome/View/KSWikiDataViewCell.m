//
//  KSWikiDataViewCell.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/17.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSWikiDataViewCell.h"
#import <Masonry/Masonry.h>

@interface KSWikiDataViewCell()
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation KSWikiDataViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor lightGrayColor]];
        [self addSubview:self.imageView];
        [self addSubview:self.title];
        [self setUILayout];
    }
    return self;
}

- (void)setUILayout
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
    }];
    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.imageView.mas_bottom);
        make.bottom.mas_equalTo(self);
    }];
}

- (void)setModel:(KSWikiDataModel *)model
{
    _model = model;
    self.title.text = _model.titleName;
    self.imageView.image = [UIImage imageNamed:_model.iconName];
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:13];
        _title.textColor = [UIColor darkGrayColor];
        _title.textAlignment = NSTextAlignmentCenter;
    }
    return _title;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}
@end
