//
//  SYTradePwdInput.m
//  SYControlSet
//
//  Created by yujiao yang on 2019/3/4.
//  Copyright © 2019 Echo. All rights reserved.
//

#import "SYTradePwdInput.h"

NSString *const SYPwdInputDidBecomeFirstResponderNotification = @"SYPwdInputDidBecomeFirstResponderNotification";
NSString *const SYPwdInputDidResignFirstResponderNotification = @"SYPwdInputDidResignFirstResponderNotification";


@interface SYTradePwdInput()<UIKeyInput>
//单元格背景色
@property (nonatomic, strong) UIColor *unitColor;
//文本颜色
@property (nonatomic, strong) UIColor *textColor;
//单元格边框颜色
@property (nonatomic, strong) UIColor *borderColor;
//文本大小
@property (nonatomic, strong) UIFont *textFont;
//单元格边框宽度
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) NSMutableArray *string;
//单元格最小宽度
@property (nonatomic, assign) NSInteger minWidth;
@property (nonatomic, assign) CGContextRef context;
@end

@implementation SYTradePwdInput
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    
    return self;
}
- (CGSize)intrinsicContentSize {
    [self layoutIfNeeded];
    CGSize size = self.bounds.size;
    
    if (size.width < self.minWidth * self.unitCount) {
        size.width = self.minWidth * self.unitCount;
    }
    
    CGFloat unitWidth = (size.width + self.unitSpace) / self.unitCount - self.unitSpace;
    size.height = unitWidth;
    
    return size;
}
#pragma mark - Private
- (void)commonInit{
    [super setBackgroundColor:[UIColor clearColor]];
    self.unitCount = 6;
    self.isSecureText = YES;
    self.unitSpace = 0;
    
    self.unitColor = [UIColor whiteColor];
    self.textColor = [UIColor blackColor];
    self.borderColor = [UIColor lightGrayColor];
    self.textFont = [UIFont systemFontOfSize:22];
    self.borderWidth = 1.0;
    self.minWidth = 45.0;
    self.string = [NSMutableArray array];
}
- (void)_fillRect:(CGRect)rect clip:(BOOL)clip {
    if (self.unitSpace < 2) {
        [self.unitColor setFill];
    }else{
        [[UIColor clearColor] setFill];
    }
    
    if (clip) {
        CGContextAddPath(self.context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0].CGPath);
        CGContextClip(self.context);
    }
    CGContextAddPath(self.context, [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, _borderWidth * 0.75, _borderWidth * 0.75) cornerRadius:0].CGPath);
    CGContextFillPath(self.context);
}
/**
 * 连续的输入框只需要画线就可以了
 * 非连续的输入框 是单个画的
 **/
- (void)_drawBorder:(CGRect)rect unitSize:(CGSize)unitSize{
    CGContextSetLineWidth(self.context, self.borderWidth);
    CGContextSetLineCap(self.context, kCGLineCapRound);
    if (self.unitSpace < 2) {
        CGRect bounds = CGRectInset(rect, self.borderWidth * 0.5, self.borderWidth * 0.5);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:bounds cornerRadius:0];
        CGContextAddPath(self.context, bezierPath.CGPath);
        
        for (int i = 1; i < self.unitCount; ++i) {
            CGContextMoveToPoint(self.context, (i * unitSize.width), 0);
            CGContextAddLineToPoint(self.context, (i * unitSize.width), (unitSize.height));
        }
        CGContextDrawPath(self.context, kCGPathStroke);
    }else{
        for (int i = 0; i < self.unitCount; i++) {
            CGRect unitRect = CGRectMake(i * (unitSize.width + self.unitSpace),
                                         0,
                                         unitSize.width,
                                         unitSize.height);
            unitRect = CGRectInset(unitRect, self.borderWidth * 0.5, self.borderWidth * 0.5);
            
            CGContextSetFillColorWithColor(self.context, [UIColor whiteColor].CGColor);
            CGContextSetStrokeColorWithColor(self.context, self.borderColor.CGColor);
            CGContextAddRect(self.context, unitRect);
            CGContextDrawPath(self.context, kCGPathFillStroke);
        }
    }
}
- (void)_drawText:(CGRect)rect unitSize:(CGSize)unitSize{
    if ([self hasText] == NO) return;
    
    NSDictionary *attr = @{NSForegroundColorAttributeName: _textColor,
                           NSFontAttributeName: _textFont};
    
    for (int i = 0; i < self.string.count; i++) {
        
        CGRect unitRect = CGRectMake(i * (unitSize.width + self.unitSpace),
                                     0,
                                     unitSize.width,
                                     unitSize.height);
        
        
        if (self.isSecureText == NO) {
            NSString *subString = [self.string objectAtIndex:i];
            
            CGSize oneTextSize = [subString sizeWithAttributes:attr];
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - oneTextSize.width) / 2,
                                          (unitRect.size.height - oneTextSize.height) / 2);
            [subString drawInRect:drawRect withAttributes:attr];
        } else {
            CGRect drawRect = CGRectInset(unitRect,
                                          (unitRect.size.width - self.textFont.pointSize / 2) / 2,
                                          (unitRect.size.height - self.textFont.pointSize / 2) / 2);
            [self.textColor setFill];
            CGContextAddEllipseInRect(self.context, drawRect);
            CGContextFillPath(self.context);
        }
    }
}
/**
 在 AutoLayout 环境下重新指定控件本身的固有尺寸
  `-drawRect:`方法会计算控件完成自身的绘制所需的合适尺寸，完成一次绘制后会通知 AutoLayout 系统更新尺寸。
 */
- (void)_resize {
    [self invalidateIntrinsicContentSize];
}
#pragma mark - Getter
- (NSString *)text {
    if (_string.count == 0) return nil;
    return [_string componentsJoinedByString:@""];
}
#pragma mark - Setter
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}
- (void)setUnitCount:(NSInteger)unitCount{
    if (unitCount < 4 || unitCount > 9) return;
    if (_unitCount ==  unitCount) return;
    
    _unitCount = unitCount;
    [self setNeedsDisplay];
}
- (void)setUnitSpace:(NSInteger)unitSpace{
    if (unitSpace < 0) {
        return;
    }
    if (_unitSpace == unitSpace) {
        return;
    }
    _unitSpace = unitSpace;
    [self setNeedsDisplay];
}
#pragma mark - override(绘制)
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //单个单元格的尺寸
    CGSize unitSize = CGSizeMake((rect.size.width + self.unitSpace) / self.unitCount - self.unitSpace, rect.size.height);
    
    self.context = UIGraphicsGetCurrentContext();
    [self _fillRect:rect clip:YES];
    [self _drawBorder:rect unitSize:unitSize];
    [self _drawText:rect unitSize:unitSize];
    
    [self _resize];
}
#pragma mark - override(UIResponder)
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    [self becomeFirstResponder];
}
- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)becomeFirstResponder{
    BOOL result = [super becomeFirstResponder];
    if (result) {
        [self sendActionsForControlEvents:UIControlEventEditingDidBegin];//弹出键盘
        [[NSNotificationCenter defaultCenter] postNotificationName:SYPwdInputDidBecomeFirstResponderNotification object:nil];
    }
    return result;
}
- (BOOL)canResignFirstResponder{
    return YES;
}
- (BOOL)resignFirstResponder{
    BOOL result = [super resignFirstResponder];
    if (result) {
        [self sendActionsForControlEvents:UIControlEventEditingDidEnd];//收起键盘
        [[NSNotificationCenter defaultCenter] postNotificationName:SYPwdInputDidResignFirstResponderNotification object:nil];
    }
    return result;
}
#pragma mark - UIKeyInput
- (BOOL)hasText{
    return _string != nil && _string.count > 0;
}
- (void)insertText:(NSString *)text{
    if (self.string.count >= self.unitCount) {
        return;
    }
    [self.string addObject:text];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [self setNeedsDisplay];
    
}
- (void)deleteBackward{
    if ([self hasText] == NO) {
        return;
    }
    [self.string removeLastObject];
    [self sendActionsForControlEvents:UIControlEventEditingChanged];
    [self setNeedsDisplay];
    
}
#pragma mark - UITextInputTraits
- (UIKeyboardType)keyboardType{
    return UIKeyboardTypeNumberPad;
}

@end
