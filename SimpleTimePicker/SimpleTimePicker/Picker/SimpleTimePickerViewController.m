//
//  SimpleTimePickerViewController.m
//  SimpleTimePicker
//
//  Created by zhoufei on 2021/6/24.
//

#import "SimpleTimePickerViewController.h"

@interface SimpleTimePickerViewController ()<UIPickerViewDataSource, UIPickerViewDelegate> 
@property (strong, nonatomic) NSArray<NSString *> *dayArr;
@property (strong, nonatomic) NSMutableArray<NSString *> *hourArr;
@property (strong, nonatomic) NSMutableArray<NSString *> *minuteArr;
@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *dataSource;
@end

@implementation SimpleTimePickerViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.dataSource = @[].mutableCopy;
    
    //dayArr
    self.dayArr = @[@"今天", @"明天"];
    
    //hourArr
    self.hourArr = [self todayHourArr].mutableCopy;
    
    //minuteArr
    self.minuteArr = @[@"00", @"10", @"20", @"30", @"40", @"50"].mutableCopy;
    
    //dataSource
    self.dataSource = @[self.dayArr, self.hourArr, @[@":"], self.minuteArr];
    
    [self setupUI];
}

#pragma mark - Private Method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    [self.pickerView reloadAllComponents];
}

- (void)changePickerViewSeparaterLineColor {
    for (UIView *separatorLine in self.pickerView.subviews) {
        if (separatorLine.frame.size.height < 1) {
            separatorLine.backgroundColor = [UIColor blueColor];
        }
    }
}

- (NSArray<NSString *> *)todayHourArr {
    NSMutableArray *hourArr = @[].mutableCopy;
    for (NSInteger hour = 0; hour <= 59; hour++) {
        [hourArr addObject:[@(hour) stringValue]];
    }
    return hourArr.copy;
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event
- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)sureAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dataSource.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource[component].count;
    
}

/** 设置组件中每行的标题row:行 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[component][row];
}


- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    [self changePickerViewSeparaterLineColor];
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                 NSForegroundColorAttributeName:[UIColor redColor]};
    NSAttributedString *attrTitle = [[NSAttributedString alloc] initWithString:title
                                                                    attributes:attributes];
    return attrTitle;
}


/** 当选择某一个列中的某一行的时候会调用该方法 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    //在拖动第 0 列行的时候, 要及时的刷新第 1 列的数据
//    if (component == 0) {
//        //如果滑动的是第 0 列, 刷新第 1 列
//        //在执行完这句代码之后, 会重新计算第 1 列的行数, 重新加载第 1 列的标题内容
//        [pickerView reloadComponent:1];//重新加载指定列的数据
//        [pickerView selectRow:0 inComponent:1 animated:YES];
//        //
//
//        //重新加载数据
//        //[pickerView reloadAllComponents];
//    }
}

///** 设置组件的宽度 */
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    if (component == 0) {
//        return 100;
//    }else{
//        return 80;
//    }
//
//}
/** 设置组件中每行的高度 */
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}


#pragma mark - Getter, Setter

#pragma mark - NSCopying

#pragma mark - NSObject


@end
