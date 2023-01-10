//
//  JKViewController.h
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKViewController : ViewController
@property (nonatomic, strong) NSMutableArray *bugs;
@property (weak) IBOutlet NSTableView *tableView;

@end

NS_ASSUME_NONNULL_END
