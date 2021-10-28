//
//  SearchBar.m
//  CustomSearchViewController
//
//  Created by zhoufei on 2021/9/30.
//

#import "CustomSearchBar.h"

@interface CustomSearchBar ()
@property (nonatomic, strong) UIFont *preferredFont;
@property (nonatomic, strong) UIColor *preferredTextColor;
@property (nonatomic, strong) UITextField *inputTextField;
@end

@implementation CustomSearchBar
- (instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.preferredFont = font;
        self.preferredTextColor = textColor;
        
        self.searchBarStyle = UISearchBarStyleDefault;
        self.translucent = NO; //搜索栏，输入框都不透明
//        self.inputTextField = [self textFieldWithContainer:self];
        [self textFieldWithContainer:self];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        self.inputTextField = [self textFieldWithContainer:self];
    }
    return self;
}

- (void)textFieldWithContainer:(UIView *)container {
    if (container.subviews.count == 0) {
        return;
    }
    
    for (NSInteger i = 0; i < container.subviews.count; i++) {
        if ([container.subviews[i] isKindOfClass:[UITextField class]]) {
            NSLog(@"%@",container.subviews[i]);
            break;
        } else {
            [self textFieldWithContainer:container.subviews[i]];
        }
    }
}

- (void)drawRect:(CGRect)rect {
    if (self.inputTextField) {
        self.inputTextField.frame = CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-10);
        self.inputTextField.font = self.preferredFont;
        self.inputTextField.textColor = self.preferredTextColor;
        
        self.inputTextField.backgroundColor = [UIColor blueColor];
        
        UIBezierPath *bp = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.frame.size.width, 1)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.backgroundColor = [UIColor brownColor].CGColor;
        layer.path = bp.CGPath;
        [self.layer addSublayer:layer];
    }
    [super drawRect:rect];
}



@end
