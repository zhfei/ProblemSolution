//
//  GroupTableViewController.m
//  TableView_Group
//
//  Created by zhoufei on 2021/5/11.
//

#import "GroupTableViewController.h"

NSString *kUITableViewCell = @"UITableViewCell";

@interface GroupTableViewController ()

@end

@implementation GroupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUITableViewCell];
}

#pragma mark - Table view data source

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [UILabel new];
    label.text = @"组 头";
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    return label;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUITableViewCell forIndexPath:indexPath];
    
    if (indexPath.section % 2 == 0) {
        cell.contentView.backgroundColor = [UIColor purpleColor];
    } else {
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    cell.textLabel.text = @"textLabel";
    cell.detailTextLabel.text = @"detailTextLabel";
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self cardStyle:20 displayCell:cell indexPath:indexPath];
    
}

- (void)cardStyle:(CGFloat)radio displayCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    //1.判断圆角位置
    NSInteger rows = [self.tableView numberOfRowsInSection:indexPath.section];
    UIRectCorner corner = 0;
    if (rows == 1) {
        if (indexPath.row == 0) {
            corner = UIRectCornerAllCorners;
        }
    } else if (rows > 1) {
        if (indexPath.row == 0) {
            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
        
        if (indexPath.row == rows - 1) {
            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
    }

    //2.设置cell圆角位置
    CGRect contentBounds = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    UIBezierPath *bp = [UIBezierPath bezierPathWithRoundedRect:contentBounds byRoundingCorners:corner cornerRadii:CGSizeMake(radio, radio)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bp.CGPath;
    //由于push动画，会让图像变形
//    layer.position = CGPointMake(contentBounds.size.width/2, contentBounds.size.height/2);
    cell.layer.mask = layer;
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
