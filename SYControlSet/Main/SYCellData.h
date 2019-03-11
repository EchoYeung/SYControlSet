//
//  SYCellData.h
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYCellData : NSObject
@property (nonatomic, copy)NSString *cellName;
@property (nonatomic, copy)void (^cellAction)(void);
- (instancetype)initWithName:(NSString *)name
                      action:(void(^)(void))action;
@end

NS_ASSUME_NONNULL_END
