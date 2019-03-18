//
//  SYTradePwdVC.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYTradePwdVC.h"
#import "SYTradePwdInput.h"
#import "SYKeyboard.h"
#import "SYKeyboardAccessoryView.h"

@interface SYTradePwdVC ()
@property (nonatomic, strong)SYTradePwdInput *input;
@end

@implementation SYTradePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.input];
    SYKeyboard *keyboard = [[SYKeyboard alloc] initWithFrame:CGRectMake(0, 0, 0, 216)];
    self.input.inputView = keyboard;
    SYKeyboardAccessoryView *accessoryView = [[SYKeyboardAccessoryView alloc] initWithFrame:CGRectMake(0, 0, 0, 50)];
    accessoryView.resetKey = ^{
        SYKeyboard *view = self.input.inputView;
        [view resetNumKeys];
    };
    accessoryView.disorderKey = ^{
        SYKeyboard *view = self.input.inputView;
        [view disorderNumKeys];
    };
    self.input.inputAccessoryView = accessoryView;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tradePwsInputEditingChanged:) name:SYPwdInputDidChangeNotification object:nil];
    

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.input becomeFirstResponder];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - Getter
- (SYTradePwdInput *)input{
    if (_input == nil) {
        _input = [[SYTradePwdInput alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.frame) - 40.0,45.0)];
        _input.unitSpace = 13.0;
    }
    return _input;
}
#pragma mark - 密码输入控件
- (void)tradePwsInputEditingChanged:(NSNotification *)notification{
    SYTradePwdInput *input = notification.object;
    NSLog(@"input %@",input.text);
}

@end
