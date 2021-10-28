//
//  MenuiOS13Controller.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/7.
//

#import "MenuiOS13Controller.h"


@interface MenuiOS13Controller ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@end


@implementation MenuiOS13Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLRequest *reqest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.webView loadRequest:reqest];
}



- (IBAction)alertBtnAction:(UIButton *)sender {
    UIMenuItem *item0 = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(responseAction:)];
    UIMenuItem *item1 = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(reportAction:)];
    
    [sender becomeFirstResponder];
    [UIMenuController sharedMenuController].menuItems = @[item0,item1];
//    [[UIMenuController sharedMenuController] setTargetRect:sender.frame inView:self.view];
//    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    [[UIMenuController sharedMenuController] showMenuFromView:self.view rect:sender.frame];
    
    [UIMenuController sharedMenuController].menuItems = nil;
}


- (void)responseAction:(UIMenuItem *)item {
    
}

- (void)reportAction:(UIMenuItem *)item {
    
}


@end
