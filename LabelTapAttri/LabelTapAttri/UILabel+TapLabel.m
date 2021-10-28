//
//  UILabel+TapLabel.m
//  LabelTapAttri
//
//  Created by zhoufei on 2021/8/9.
//

#import "UILabel+TapLabel.h"
#import <CoreText/CoreText.h>
#import <objc/runtime.h>

@interface UILabel ()
@property (nonatomic, strong) NSMutableArray *ranges;
@property (nonatomic, weak) id target;

@end

@implementation UILabel (TapLabel)
- (void)setRanges:(NSMutableArray *)ranges {
    objc_setAssociatedObject(self, @selector(ranges), ranges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)ranges {
    return objc_getAssociatedObject(self, @selector(ranges));
}

- (void)setTarget:(id)target {
    objc_setAssociatedObject(self, @selector(target), target, OBJC_ASSOCIATION_ASSIGN);
}

- (id)target {
    return objc_getAssociatedObject(self, @selector(target));
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    for (NSDictionary *info in self.ranges) {
        CGRect rect = [info[@"rect"] CGRectValue];
        if (CGRectContainsPoint(rect, point)) {
            SEL sel = NSSelectorFromString(info[@"sel"]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.target performSelector:sel];
#pragma clang diagnostic pop
        }
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)addTarget:(id)target selector:(SEL)sel range:(NSRange)range {
    self.target = target;
    if (!self.ranges) {
        self.ranges = [NSMutableArray array];
    }
    self.userInteractionEnabled = YES;
    NSArray *lineRanges = [self lines];
    NSRange targetRange = range;
    for (int i = 0; i < lineRanges.count; i++) {
        NSRange lineRange = [lineRanges[i] rangeValue];
        NSRange intersectionRange = NSIntersectionRange(targetRange, lineRange);
        // 两个range有相交
        if (intersectionRange.length != 0) {
            // 如果targetRange的范围超出了lineRange
            if (NSMaxRange(targetRange) > NSMaxRange(lineRange)) {
                [self addTarget:target selector:sel range:intersectionRange];
                [self addTarget:target selector:sel range:NSMakeRange(NSMaxRange(intersectionRange), targetRange.length - intersectionRange.length)];
            }else {
                CGRect rangeRect = [self boundingRectForCharacterRange:range];
                [self.ranges addObject:@{@"sel":NSStringFromSelector(sel),
                                         @"rect":[NSValue valueWithCGRect:rangeRect]
                                         }];
            }
            /*
             一旦有相交，则相交的range如果是多行，会被拆分成多个range。
             原始的range就不再使用了，这里直接跳出循环*/
            break;
        }
    }
}

- (CGRect)boundingRectForCharacterRange:(NSRange)range {
    NSTextStorage *textStore = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    [textStore addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, textStore.string.length)];
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    [textStore addLayoutManager:layoutManager];
    
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)];
    textContainer.lineFragmentPadding = 0;
    textContainer.lineBreakMode = self.lineBreakMode;
    [layoutManager addTextContainer:textContainer];
    
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    CGRect rect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    return rect;
}


- (NSArray *)lines {
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    [attStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attStr.length)];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, CGRectGetWidth(self.frame), MAXFLOAT));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (__bridge NSArray*)CTFrameGetLines(frame);
    NSMutableArray *linesArray = @[].mutableCopy;
    
    for (id line in lines) {
        CTLineRef lineref = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineref);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        [linesArray addObject:[NSValue valueWithRange:range]];
    }
    
    CFRelease(frameSetter);
    CFRelease(path);
    CFRelease(frame);
    
    return linesArray;
}

@end
