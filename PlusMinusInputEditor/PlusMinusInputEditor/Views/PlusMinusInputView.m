//
//  AddSubtractInputView.m
//  PlusMinusInputEditor
//
//  Created by 周飞 on 2020/6/2.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "PlusMinusInputView.h"


static NSInteger kMax = 99;
static NSInteger kMin = 3;


#pragma mark - 分类：Filter
@implementation PlusMinusInputView (Filter)
//输入的字符为可以输入字符
- (BOOL)filter1_checkNumberRegex:(NSString *)targetStr {
    NSString *check = @"^[0-9]*$";
    NSPredicate *predice =[NSPredicate predicateWithFormat:@"self matches %@",check];
    BOOL result = [predice evaluateWithObject:targetStr];
    return result;
}

//输入的结果值在正确的范围内
- (BOOL)filter2_numberWithinTheScope:(NSString *)text {
    NSInteger res = [text integerValue];
    if (res > kMax) {
        return NO;
    } else if (res < kMin) {
        return NO;
    } else {
        return YES;
    }
}

@end


@interface PlusMinusInputView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (nonatomic, strong) NSString *inputText;

@end

@implementation PlusMinusInputView
#pragma mark - Life Cycle
+ (instancetype)plusMinusInputView {
    PlusMinusInputView *inputView = [[NSBundle mainBundle] loadNibNamed:@"PlusMinusInputView" owner:nil options:nil][0];
    return inputView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}

#pragma mark - Private Method
- (void)setupUI {
    self.inputTextField.delegate = self;
}

- (void)setInputText:(NSString *)inputText{
    self.inputTextField.text = inputText;
}

- (NSString *)inputText{
    return self.inputTextField.text;
}


#pragma mark - Public Method

#pragma mark - Event
- (IBAction)minusAction:(UIButton *)sender {
    if ([self filter2_numberWithinTheScope:self.inputText]) {
        ///!!!: 超出阀值❌
    } else {
        NSInteger num = [self.inputText integerValue];
        NSString *res = [NSString stringWithFormat:@"%ld",num-1];
        [self setInputText:res];
    }
}

- (IBAction)plusAction:(UIButton *)sender {
    if ([self filter2_numberWithinTheScope:self.inputText]) {
        ///!!!: 超出阀值❌
    } else {
        NSInteger num = [self.inputText integerValue];
        NSString *res = [NSString stringWithFormat:@"%ld",num+1];
        [self setInputText:res];
    }
}

#pragma mark - Delegate
//确认关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (![self filter2_numberWithinTheScope:textField.text]) {
        ///!!!: 输入错误❌
        return NO;
    } else {
        [textField resignFirstResponder];
        if (self.completeBlock) {
            self.completeBlock(textField.text);
        }
        return YES;
    }
}

//过滤输入字符
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (![self filter1_checkNumberRegex:string]) {
        ///!!!: 输入错误❌
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end




