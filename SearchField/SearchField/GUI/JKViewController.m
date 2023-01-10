//
//  JKViewController.m
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "JKViewController.h"
#import "ScaryBugDoc.h"

@interface JKViewController ()<NSTableViewDelegate,NSTableViewDataSource>

@end

@implementation JKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    ScaryBugDoc *bug1 = [[ScaryBugDoc alloc] initWithTitle:@"bug 1" rating:1 thumbImage:[NSImage imageNamed:@"icon_1_selected"] fullImage:[NSImage imageNamed:@"icon_1_selected"]];
    ScaryBugDoc *bug2 = [[ScaryBugDoc alloc] initWithTitle:@"bug 2" rating:2 thumbImage:[NSImage imageNamed:@"icon_2_selected"] fullImage:[NSImage imageNamed:@"icon_2_selected"]];
    ScaryBugDoc *bug3 = [[ScaryBugDoc alloc] initWithTitle:@"bug 3" rating:3 thumbImage:[NSImage imageNamed:@"icon_3_selected"] fullImage:[NSImage imageNamed:@"icon_3_selected"]];
    ScaryBugDoc *bug4 = [[ScaryBugDoc alloc] initWithTitle:@"bug 4" rating:4 thumbImage:[NSImage imageNamed:@"icon_4_selected"] fullImage:[NSImage imageNamed:@"icon_4_selected"]];
    NSMutableArray *bugs = @[bug1,bug2,bug3,bug4].mutableCopy;
    self.bugs = bugs;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return self.bugs.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    if ([tableColumn.identifier isEqualToString:@"BugCell"]) {
        ScaryBugDoc *bugDoc = [self.bugs objectAtIndex:row];
        cellView.imageView.image = bugDoc.thumbImage;
        cellView.textField.stringValue = bugDoc.data.title;
        return cellView;
    }
    return cellView;
}

@end
