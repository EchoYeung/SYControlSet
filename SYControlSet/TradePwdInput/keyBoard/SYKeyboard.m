//
//  SYKeyboard.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/15.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYKeyboard.h"
#import "SYKeyObject.h"
#import "SYKeyView.h"

@interface SYKeyboard ()
//保存数字按键数据源
@property (nonatomic, strong)  NSArray<SYKeyObject *> *numArray;
@property (nonatomic, strong)  NSMutableArray<SYKeyObject *> *allKeysArray;
//按键数组
@property (nonatomic, strong)  NSMutableArray<SYKeyView *>  *keyViewArray;
@property (nullable, nonatomic, weak)  id<UIKeyInput>  keyInputResponse;
@end

@implementation SYKeyboard
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    
        [self resetNumKeys];
    }
    return self;
}

- (void)configData:(NSArray *)numArr{
    
    self.numArray = [NSArray arrayWithArray:numArr];
    self.allKeysArray = [NSMutableArray arrayWithArray:numArr];
    [self.allKeysArray insertObject:[[SYKeyObject alloc] initWithTitle:@"" value:@"blank"] atIndex:9];
    [self.allKeysArray addObject:[[SYKeyObject alloc] initWithTitle:@"" value:@"del"]];
    
    if(self.keyViewArray != nil && self.keyViewArray.count == self.allKeysArray.count){
        [self.allKeysArray enumerateObjectsUsingBlock:^(SYKeyObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SYKeyView *key = self.keyViewArray[idx];
            if ([obj.value isEqualToString:@"del"]) {
                [key setImage:[UIImage imageNamed:@"keyboard_del"]];
            }else{
                [key setTitle:obj.title];
            }
        }];
        return;
    }
    self.keyViewArray = [NSMutableArray arrayWithCapacity:12];
    for (SYKeyObject *obj in self.allKeysArray) {
        SYKeyView *key = [[SYKeyView alloc] init];
        if ([obj.value isEqualToString:@"del"]) {
            [key setImage:[UIImage imageNamed:@"keyboard_del"]];
        }else{
            [key setTitle:obj.title];
        }
        [key addTarget:self action:@selector(keyAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:key];
        [self.keyViewArray addObject:key];
    }
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 216;
    CGFloat margin = 0.5;
    CGFloat itemW = (width - 2 * margin) * 1.0/3.0f ;
    CGFloat itemH = (height - 3 * margin) * 1.0/4.0f ;
    [self.keyViewArray enumerateObjectsUsingBlock:^(SYKeyView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat x = (idx%3) * (itemW + margin);
        CGFloat y = (idx/3) * (itemH + margin);
        
        obj.tag = idx;
        obj.frame = CGRectMake(x, y, itemW, itemH);
    }];
}
- (id<UIKeyInput>)keyInputResponse{
    if (_keyInputResponse == nil) {
        if (self.nextResponder && [self.nextResponder conformsToProtocol:@protocol(UIKeyInput)]) {
            _keyInputResponse = (id<UIKeyInput>)self.nextResponder;
        }
    }
    return _keyInputResponse;
}
- (void)keyAction:(SYKeyView *)key{
    SYKeyObject *obj = self.allKeysArray[key.tag];
    
    if (!self.keyInputResponse) {
        return;
    }
    if ([obj.value isEqualToString:@"del"]) {
        [self.keyInputResponse deleteBackward];
    }else if([obj.value isEqualToString:@"blank"]){
        return;
    }else{
        [self.keyInputResponse insertText:obj.value];
    }
}
- (void)disorderNumKeys{
    NSArray *temp = [self.numArray sortedArrayUsingComparator:^NSComparisonResult(SYKeyObject *obj1, SYKeyObject *obj2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return [obj1.value compare:obj2.value];
        } else {
            return [obj2.value compare:obj1.value];
        }
    }];
    [self configData:temp];
}
- (void)resetNumKeys{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (NSNumber *num in @[@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9),@(0)]) {
        SYKeyObject *keyObj = [[SYKeyObject alloc] initWithValue:num.stringValue];
        [array addObject:keyObj];
    }
    [self configData:array];
}
@end
