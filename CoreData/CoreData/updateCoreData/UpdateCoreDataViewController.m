//
//  UpdateCoreDataViewController.m
//  CoreData
//
//  Created by zhoufei on 2020/8/23.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "UpdateCoreDataViewController.h"
#import "CDUser+goods.h"

@interface UpdateCoreDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;

@end

@implementation UpdateCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
      
    
    CDUser *user0 = [CDUser new];
    user0.goods = @"user0";
    CDUser *user1 = [CDUser new];
    user1.goods = @"user1";
    CDUser *user2 = [CDUser new];
    user2.goods = @"user2";
    
    self.nameTF.text = [self.coreModel valueForKey:@"name"];
    self.ageTF.text = [NSString stringWithFormat:@"%@",[self.coreModel valueForKey:@"age"]];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)submit:(UIButton *)sender {
    [self.coreModel setValue:self.nameTF.text forKey:@"name"];
    [self.coreModel setValue:@([self.ageTF.text integerValue]) forKey:@"age"];
    
    [self.coreModel.managedObjectContext save:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancle:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
