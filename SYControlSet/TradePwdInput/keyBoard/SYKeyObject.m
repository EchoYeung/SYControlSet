//
//  SYKeyObject.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/18.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYKeyObject.h"

@implementation SYKeyObject
- (instancetype)initWithValue:(NSString *)value{
    if (self = [super init]) {
        _value = value;
        _title = value;
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value{
    if (self = [super init]) {
        _value = value;
        _title = title;
    }
    return self;
}
@end
