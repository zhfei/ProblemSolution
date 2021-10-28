//
//  ViewController.m
//  PlusMinusInputEditor
//
//  Created by 周飞 on 2020/6/2.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "InsertCoreDataViewController.h"
#import "PlusMinusInputView.h"

@interface InsertCoreDataViewController ()
@property(nonatomic, strong) PlusMinusInputView *plusMinusInputView;
@end

@implementation InsertCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.plusMinusInputView.frame = CGRectMake(100, 200, 200, 50);
    self.plusMinusInputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.plusMinusInputView];
}


- (PlusMinusInputView *)plusMinusInputView{
    if (!_plusMinusInputView) {
        _plusMinusInputView = [PlusMinusInputView plusMinusInputView];
    }
    return _plusMinusInputView;
}


- (IBAction)leftSetting:(UIButton *)sender {
}
@end
