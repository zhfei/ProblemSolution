//
//  SizeThatFitsAndBoundingWithRectTableViewController.m
//  AutomaticTableViewCellHeight
//
//  Created by zhoufei on 2020/11/18.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SizeThatFitsAndBoundingWithRectTableViewController.h"
#import "SizeThatFitsAndBoundingWithRectTableViewCell.h"

@interface SizeThatFitsAndBoundingWithRectTableViewController ()
@property (strong, nonatomic) SizeThatFitsAndBoundingWithRectTableViewCell *tmpCell;

@end

@implementation SizeThatFitsAndBoundingWithRectTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tmpCell = [self.tableView dequeueReusableCellWithIdentifier:@"SizeThatFitsAndBoundingWithRectTableViewCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tmpCell.title6.text = @"之前谷歌CEO Sundar Pichai曾说过，谷歌正在向硬件投资，力度不小，有些硬件需要2-3年才能修成正果；2021年有些投资会开花结果。他所说的硬件到底是什么？会不会是芯片呢？当然有可能。";
    self.tmpCell.title7.text = self.tmpCell.title6.text;
    self.tmpCell.title8.text = self.tmpCell.title6.text;
    return [self.tmpCell sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX)].height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SizeThatFitsAndBoundingWithRectTableViewCell *cell = (SizeThatFitsAndBoundingWithRectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SizeThatFitsAndBoundingWithRectTableViewCell" forIndexPath:indexPath];
    
    cell.title6.text = @"之前谷歌CEO Sundar Pichai曾说过，谷歌正在向硬件投资，力度不小，有些硬件需要2-3年才能修成正果；2021年有些投资会开花结果。他所说的硬件到底是什么？会不会是芯片呢？当然有可能。";
    cell.title7.text = cell.title6.text;
    cell.title8.text = cell.title6.text;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

@end
