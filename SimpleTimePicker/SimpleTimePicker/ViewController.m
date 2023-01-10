//
//  ViewController.m
//  SimpleTimePicker
//
//  Created by zhoufei on 2021/6/24.
//

#import "ViewController.h"
#import "SimpleTimePickerViewController.h"

@interface ViewController ()
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) UIView *footer;

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

- (NSArray *)commonSuperViews:(UIView *)aView other:(UIView *)otherView {
    NSMutableArray *aSupersView = [self superViewsArray:aView];
    NSMutableArray *othersView = [self superViewsArray:otherView];
    
    NSInteger total = MIN(aSupersView.count, othersView.count);
    NSMutableArray *commons = @[].mutableCopy;
    while (total >= 0) {
        if (aSupersView.lastObject == othersView.lastObject) {
            [commons addObject:aSupersView.lastObject];
            [aSupersView removeLastObject];
            [othersView removeLastObject];
            
            total--;
        } else {
            break;
        }
    }
    
    
    return nil;
}

- (NSMutableArray *)superViewsArray:(UIView *)aView {
    UIView *temp = aView.superview;
    NSMutableArray *arrayM = @[].mutableCopy;
    while (temp) {
        [arrayM addObject:temp];
        temp = temp.superview;
    }
    return arrayM;
}
@end
