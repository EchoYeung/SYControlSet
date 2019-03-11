//
//  SYCellData.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYCellData.h"

@implementation SYCellData
- (instancetype)initWithName:(NSString *)name
                      action:(void(^)(void))action{
    if (self = [super init]) {
        _cellName = name;
        _cellAction = action;
    }
    return self;
}
@end
