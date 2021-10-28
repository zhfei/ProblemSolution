//
//  ViewController.m
//  CustomSearchViewController
//
//  Created by zhoufei on 2021/9/30.
//

#import "ViewController.h"
#import "CustomSearchBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CustomSearchBar *customBar = [[CustomSearchBar alloc] initWithFrame:CGRectMake(100, 100, 100, 50) font:[UIFont systemFontOfSize:20] textColor:[UIColor redColor]];
    [self.view addSubview:customBar];
}


@end
