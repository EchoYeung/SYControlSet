//
//  SYKeyObject.h
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/18.
//  Copyright © 2019 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYKeyObject : NSObject
//key显示内容
@property (nonatomic,copy)NSString *title;
//key实际内容
@property (nonatomic,copy)NSString *value;

//title + value相同
- (instancetype)initWithValue:(NSString *)value;
- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
