//
//  SystemFittingSizeTableViewController.m
//  AutomaticTableViewCellHeight
//
//  Created by zhoufei on 2020/11/17.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "SystemFittingSizeTableViewController.h"
#import "SystemFittingSizeTableViewCell.h"

@interface SystemFittingSizeTableViewController ()

@property (strong, nonatomic) SystemFittingSizeTableViewCell *tmpCell;

@end

@implementation SystemFittingSizeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tmpCell = [self.tableView dequeueReusableCellWithIdentifier:@"SystemFittingSizeTableViewCell"];
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
    if (indexPath.row % 2) {
        self.tmpCell.title3.text = @"之前写过一篇它的文章了。不过那个是单纯的demo，这次有个页面又要高度自适应，就重新看了看，再次用它实现高度自适应。第三方的库就不用了。";
        self.tmpCell.title4.text = self.tmpCell.title3.text;
        self.tmpCell.title5.text = self.tmpCell.title3.text;
    } else {
        self.tmpCell.title3.text = @"今年尤其特殊，用张勇的话讲，十二年一个轮回，“双11”已经“从一个模型走向另一个模型”。除了外界已知，光棍节变身“双节棍”，总成交额4982亿元，阿里已经透过这场“双11”展开了对新商业模式的测试。";
        self.tmpCell.title4.text = self.tmpCell.title3.text;
        self.tmpCell.title5.text = self.tmpCell.title3.text;
    }
    
    CGFloat widthS = [UIScreen mainScreen].bounds.size.width;
    CGFloat maxWidth = widthS - 120;
    [self.tmpCell.title3 setPreferredMaxLayoutWidth:maxWidth];
    [self.tmpCell.title4 setPreferredMaxLayoutWidth:maxWidth];
    [self.tmpCell.title5 setPreferredMaxLayoutWidth:maxWidth];
    
    [self.tmpCell setNeedsLayout];
    [self.tmpCell layoutIfNeeded];
    
    CGSize cellSize = [self.tmpCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    return cellSize.height + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SystemFittingSizeTableViewCell *cell = (SystemFittingSizeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SystemFittingSizeTableViewCell" forIndexPath:indexPath];
    
      
    if (indexPath.row % 2) {
        cell.title3.text = @"之前写过一篇它的文章了。不过那个是单纯的demo，这次有个页面又要高度自适应，就重新看了看，再次用它实现高度自适应。第三方的库就不用了。";
        cell.title4.text = self.tmpCell.title3.text;
        cell.title5.text = self.tmpCell.title3.text;
    } else {
        cell.title3.text = @"今年尤其特殊，用张勇的话讲，十二年一个轮回，“双11”已经“从一个模型走向另一个模型”。除了外界已知，光棍节变身“双节棍”，总成交额4982亿元，阿里已经透过这场“双11”展开了对新商业模式的测试。";
        cell.title4.text = self.tmpCell.title3.text;
        cell.title5.text = self.tmpCell.title3.text;
    }
    
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
