//
//  FetchCoreDataTableViewController.m
//  CoreData
//
//  Created by zhoufei on 2020/8/23.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "FetchCoreDataTableViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "UpdateCoreDataViewController.h"

@interface FetchCoreDataTableViewController ()
@property (strong, nonatomic) NSMutableArray<NSManagedObject *> *dataSource;

@end

@implementation FetchCoreDataTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIButton *add = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.tableView.tableFooterView = add;
    [add addTarget:self action:@selector(addCoreDataModel) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate persistentContainer].viewContext;
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Users"];
    
    NSArray *results = [context executeFetchRequest:fr error:nil];
    
    NSLog(@"results:%@",results);
    
    self.dataSource = results.mutableCopy;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    NSString *name = [self.dataSource[indexPath.row] valueForKey:@"name"];
    NSNumber *age = [self.dataSource[indexPath.row] valueForKey:@"age"];
    
    NSString *labelText = [NSString stringWithFormat:@"%@ - %@",name,age];
    
    UILabel *label = [cell viewWithTag:10];
    label.text = labelText;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UpdateCoreDataViewController *updataVC = [[UIStoryboard storyboardWithName:@"Fetch" bundle:nil] instantiateViewControllerWithIdentifier:@"UpdateCoreData"];
    
    updataVC.coreModel = self.dataSource[indexPath.row] ;
    
    [self.navigationController pushViewController:updataVC animated:YES];
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self deleteCoreData:indexPath];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)deleteCoreData:(NSIndexPath *)indexPath {
    NSManagedObject *moj = self.dataSource[indexPath.row];
    
    NSManagedObjectContext *context = [(AppDelegate *)[UIApplication sharedApplication].delegate persistentContainer].viewContext;
    [context deleteObject:moj];
    
    [self.dataSource removeObject:moj];
}

- (void)addCoreDataModel {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"添加数据到CoreData" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"点击添加" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"name";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"age";
    }];
    
    [alert addAction:sure];
    [alert addAction:cancle];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
