//
//  SYKeyboardAccessoryView.h
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/18.
//  Copyright © 2019 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYKeyboardAccessoryView : UIView
@property (nonatomic, copy) void (^resetKey)(void);
@property (nonatomic, copy) void (^disorderKey)(void);
@end

NS_ASSUME_NONNULL_END
