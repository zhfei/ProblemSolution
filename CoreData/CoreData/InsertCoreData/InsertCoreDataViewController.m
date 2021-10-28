//
//  ViewController.m
//  CoreData
//
//  Created by zhoufei on 2020/8/23.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "InsertCoreDataViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface InsertCoreDataViewController ()

@end

@implementation InsertCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    ///!!!:写数据
    NSManagedObjectContext *context = [[(AppDelegate *)[UIApplication sharedApplication].delegate persistentContainer] viewContext];
    
    //插入数据
    NSManagedObject *row = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    [row setValue:@"jack" forKey:@"name"];
    [row setValue:@(22) forKey:@"age"];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"数据保存失败：%@",error);
    }
}


@end
