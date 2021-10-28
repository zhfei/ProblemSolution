//
//  ViewController.m
//  SimpleTimePicker
//
//  Created by zhoufei on 2021/6/24.
//

#import "ViewController.h"
#import "SimpleTimePickerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)showPicker:(UIButton *)sender {
    SimpleTimePickerViewController *picker = [SimpleTimePickerViewController new];
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:picker animated:YES completion:nil];
}


@end
