//
//  SYKeyView.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/18.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYKeyView.h"
@interface SYKeyView()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *imgView;
@end

@implementation SYKeyView
- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imgView];
        self.imgView.hidden = YES;
    }
    return self;
}
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    self.imgView.hidden = YES;
    self.titleLabel.hidden = NO;
}
- (void)setImage:(UIImage *)image{
    self.titleLabel.hidden = YES;
    self.imgView.hidden = NO;
    
    self.imgView.image = image;
}
#pragma mark - override(布局)
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.imgView setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];

}
#pragma mark - Getter
- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];
        [_titleLabel setFont:[UIFont systemFontOfSize:28.0]];
        [_titleLabel setTextColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}
- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
        [_imgView setContentMode:UIViewContentModeCenter];
    }
    return _imgView;
}
@end
