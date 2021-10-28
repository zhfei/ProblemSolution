//
//  SimpleTimePickerViewController.h
//  SimpleTimePicker
//
//  Created by zhoufei on 2021/6/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SimpleTimePickerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)sureAction:(id)sender;
- (IBAction)cancleAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
