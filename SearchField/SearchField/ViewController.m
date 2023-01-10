//
//  ViewController.m
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "ViewController.h"
#import "SearchList.h"
#import "ScaryBugDoc.h"
@interface ViewController() <NSSearchFieldDelegate, NSTextFieldDelegate, NSTableViewDelegate,NSTableViewDataSource>
@property (nonatomic, strong) SearchList *sList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    
    // 1.searchField
    self.searchField.delegate = self;
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"最近使用"];
    NSMenuItem *item0 = [[NSMenuItem alloc] initWithTitle:@"abc" action:nil keyEquivalent:@""];
    item0.tag = 0;
    [menu addItem:item0];
    
    NSMenuItem *item1 = [[NSMenuItem alloc] initWithTitle:@"789" action:nil keyEquivalent:@""];
    item0.tag = 1;
    [menu addItem:item1];
    
    NSMenuItem *item2 = [NSMenuItem separatorItem];
    item0.tag = 2;
    [menu addItem:item2];
    
    NSMenuItem *item3 = [[NSMenuItem alloc] initWithTitle:@"清空" action:nil keyEquivalent:@""];
    item0.tag = 3;
    [menu addItem:item3];
    
    self.searchField.searchMenuTemplate = menu;
    
    
    // 2.textField
    NSTextField *textField = [[NSTextField alloc] initWithFrame:CGRectMake(30, 100, 100, 22)];
    textField.stringValue = @"输入内容";
    textField.font = [NSFont systemFontOfSize:20];
    textField.backgroundColor = [NSColor clearColor];
    textField.editable = YES;//NO变成label, yes变成textfield
//    textField.bordered = YES;
//    NSTextFieldCell *cell = [[NSTextFieldCell alloc] initTextCell:@"这是cell"];
//    cell.scrollable = YES;
//    textField.cell = cell;
    
    textField.delegate = self;
    [self.view addSubview:textField];
    
    self.searchBtn.refusesFirstResponder = NO;
//    self.searchBtn.acceptsFirstResponder = YES;
//    self.searchBtn.canBecomeKeyView = YES;
    
    [self.searchBtn becomeFirstResponder];
    
    ScaryBugDoc *bug1 = [[ScaryBugDoc alloc] initWithTitle:@"bug 1" rating:1 thumbImage:[NSImage imageNamed:@"icon_1_selected"] fullImage:[NSImage imageNamed:@"icon_1_selected"]];
    ScaryBugDoc *bug2 = [[ScaryBugDoc alloc] initWithTitle:@"bug 2" rating:2 thumbImage:[NSImage imageNamed:@"icon_2_selected"] fullImage:[NSImage imageNamed:@"icon_2_selected"]];
    ScaryBugDoc *bug3 = [[ScaryBugDoc alloc] initWithTitle:@"bug 3" rating:3 thumbImage:[NSImage imageNamed:@"icon_3_selected"] fullImage:[NSImage imageNamed:@"icon_3_selected"]];
    ScaryBugDoc *bug4 = [[ScaryBugDoc alloc] initWithTitle:@"bug 4" rating:4 thumbImage:[NSImage imageNamed:@"icon_4_selected"] fullImage:[NSImage imageNamed:@"icon_4_selected"]];
    NSMutableArray *bugs = @[bug1,bug2,bug3,bug4].mutableCopy;
    self.bugs = bugs;

}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (void)textDidChange:(NSNotification *)notification {
    NSLog(@"%@",notification);
}

- (void)controlTextDidChange:(NSNotification *)obj {
    NSTextField *tf = obj.object;
    NSLog(@"%@",tf.stringValue);
}

- (IBAction)searchAction:(NSPopUpButton *)sender {
    NSLog(@"%@",sender);
    [self addChildViewController:self.sList];
    [self.view addSubview:self.sList.view];
}


- (SearchList *)sList {
    if (!_sList) {
        _sList = [[SearchList alloc] initWithNibName:@"SearchList" bundle:nil];
        _sList.view.frame = CGRectMake(50, 50, 60, 120);
    }
    return _sList;
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
