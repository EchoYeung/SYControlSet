//
//  SYKeyboardAccessoryView.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/18.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYKeyboardAccessoryView.h"

@interface SYKeyboardAccessoryView ()
@property (nonatomic, strong)UIButton *resetBtn;
@property (nonatomic, strong)UIButton *disorderBtn;
@end
@implementation SYKeyboardAccessoryView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];

        [self loadUIs];
    }
    return self;
}

- (void)loadUIs{
    self.resetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.resetBtn setTitle:@"正序" forState:UIControlStateNormal];
    [self.resetBtn addTarget:self action:@selector(resetBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.resetBtn];
    
    self.disorderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.disorderBtn setTitle:@"乱序" forState:UIControlStateNormal];
    [self.disorderBtn addTarget:self action:@selector(disorderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.disorderBtn];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.resetBtn setFrame:CGRectMake(10, 5, 100, self.frame.size.height-10)];
    [self.disorderBtn setFrame:CGRectMake(self.frame.size.width-100-10, 5, 100, self.frame.size.height-10)];
}
- (void)resetBtnAction{
    if (self.resetKey) {
        self.resetKey();
    }
}
- (void)disorderBtnAction{
    if (self.disorderKey) {
        self.disorderKey();
    }
}
@end
