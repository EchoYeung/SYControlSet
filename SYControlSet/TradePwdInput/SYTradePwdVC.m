//
//  SYTradePwdVC.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYTradePwdVC.h"
#import "SYTradePwdInput.h"

@interface SYTradePwdVC ()
@property (nonatomic, strong)SYTradePwdInput *input;
@end

@implementation SYTradePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.input];
    [self.input addTarget:self action:@selector(tradePwsInputEditingChanged:) forControlEvents:UIControlEventEditingChanged];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.input becomeFirstResponder];
}
- (void)tradePwsInputEditingChanged:(SYTradePwdInput *)input{
    NSLog(@"input %@",input.text);
}
- (SYTradePwdInput *)input{
    if (_input == nil) {
        _input = [[SYTradePwdInput alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.frame) - 40.0,45.0)];
        _input.unitSpace = 13.0;
    }
    return _input;
}

@end
