//
//  SYKeyboard.h
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/15.
//  Copyright © 2019 Echo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SYKeyObject;
@class SYKeyView;

NS_ASSUME_NONNULL_BEGIN

@interface SYKeyboard : UIView
- (void)disorderNumKeys;
- (void)resetNumKeys;
@end

NS_ASSUME_NONNULL_END
