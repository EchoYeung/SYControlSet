//
//  SYTradePwdInput.h
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//
//  交易密码输入控件
#import <UIKit/UIKit.h>
@protocol SYTradePwsInputDelegate;

UIKIT_EXTERN NSString *const SYPwdInputDidBecomeFirstResponderNotification;
UIKIT_EXTERN NSString *const SYPwdInputDidResignFirstResponderNotification;
UIKIT_EXTERN NSString *const SYPwdInputDidChangeNotification;


NS_ASSUME_NONNULL_BEGIN

@interface SYTradePwdInput : UIControl
@property (nullable, nonatomic, weak) id<SYTradePwsInputDelegate> delegate;
//获取用户输入内容
@property (nullable, nonatomic, copy, readonly) NSString *text;
//密码位数
@property (nonatomic, assign) NSInteger unitCount;
//是否明文显示
@property (nonatomic, assign) BOOL isSecureText;
//单元格之间间隙
@property (nonatomic, assign) NSInteger unitSpace;
@end

@protocol SYTradePwsInputDelegate <NSObject>

@optional

- (void)tradePwsInputDidBeginEditing:(SYTradePwdInput *)input;
- (void)tradePwsInputDidEndEditing:(SYTradePwdInput *)input;

@end

NS_ASSUME_NONNULL_END
