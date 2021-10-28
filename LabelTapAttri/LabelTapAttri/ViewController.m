//
//  ViewController.m
//  LabelTapAttri
//
//  Created by zhoufei on 2021/8/9.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupTextView];
//    [self setupTextView2];
    [self setupTextView3];
}

//1.使用自定义URL Scheme
//长按容易出现copy弹窗
- (void)setupTextView {
    NSString *str = @"本人确认阅读并同意签署《业务委托书》及《个人信息采集及征信查询授权书》";
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:str];
    //自定义url类型
    [attribute addAttribute:NSLinkAttributeName value:@"labelAction://type1" range:[str rangeOfString:@"《业务委托书》"]];
    [attribute addAttribute:NSLinkAttributeName value:@"labelAction://type2" range:[str rangeOfString:@"《个人信息采集及征信查询授权书》"]];
    self.textView.attributedText = attribute;
    self.textView.delegate = self;
    
    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:30]};
    self.textView.editable = NO;
}

//拦截自定义scheme类型
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"%@",URL);
    return YES;
}

//2使用html
- (void)setupTextView2 {
    NSString *html = @"<body style=\"color: darkgray; font-size: 15px;\">本人确认阅读并同意签署<a href='labelAction://type1'>《业务委托书》</a>及<a href='labelAction://type2'>《个人信息采集及征信查询授权书》</a></body>";
    NSData *htmlData = [html dataUsingEncoding:NSUnicodeStringEncoding];
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithData:htmlData options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:NULL error:nil];
    self.textView.attributedText = attribute;
    self.textView.delegate = self;
    self.textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    self.textView.editable = NO;
}

//使用系统API，判断点击文字位置是否和文字重合
- (void)setupTextView3 {
    NSString *str = @"本人确认阅读并同意签署《业务委托书》及《个人信息采集及征信查询授权书》";
    self.textView.text = str;
    
    NSRange range = [str rangeOfString:@"《业务委托书》"];
    self.textView.selectedRange = range;
    UITextRange *textRange = self.textView.selectedTextRange;
    NSArray <UITextSelectionRect *>*rects = [self.textView selectionRectsForRange:textRange];
    for (UITextSelectionRect *selectionRect in rects) {
        NSLog(@"%@",NSStringFromCGRect(selectionRect.rect));
        UIView *view = [[UIView alloc] initWithFrame:selectionRect.rect];
        view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3];
        [self.textView insertSubview:view atIndex:0];
    }
}

@end
