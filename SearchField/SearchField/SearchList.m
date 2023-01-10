//
//  SearchList.m
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import "SearchList.h"

@interface SearchList ()<NSTableViewDelegate,NSTableViewDataSource>
@property (nonatomic,strong) NSTableView *tableView;
@end

@implementation SearchList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self tableViewSetting];
    

}

#pragma mark - NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return 15;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    //获取表格列的标识符
    NSString *columnID = tableColumn.identifier;
    NSLog(@"columnID : %@ ,row : %d",columnID,row);
    
    NSString *strIdt = @"123";
    NSTableCellView *cell = [tableView makeViewWithIdentifier:strIdt owner:self];
    if (!cell) {
        cell = [[NSTableCellView alloc]init];
        cell.identifier = strIdt;
    }
    
    cell.wantsLayer = YES;
    cell.layer.backgroundColor = [NSColor yellowColor].CGColor;
  
    cell.imageView.image = [NSImage imageNamed:@"swift"];
    cell.textField.stringValue = [NSString stringWithFormat:@"cell %ld",(long)row];
    
    return cell;
    
}

#pragma mark - 行高
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 44;
}

#pragma mark - 是否可以选中单元格
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    
    //设置cell选中高亮颜色
    NSTableRowView *myRowView = [self.tableView rowViewAtRow:row makeIfNecessary:NO];
    
    [myRowView setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleRegular];
    [myRowView setEmphasized:NO];
    
    NSLog(@"shouldSelect : %d",row);
    return YES;
}

//选中的响应
-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
    
    NSTableView* tableView = notification.object;
    
    NSLog(@"didSelect：%@",notification.userInfo);
}

#pragma mark - Getter

- (NSTableView *)tableView
{
    if(!_tableView){
        _tableView = [[NSTableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    return _tableView;
}


- (void)tableViewSetting{
    
    self.view.window.backgroundColor = [NSColor cyanColor];
    
    //第一列
    NSTableColumn *column1 = [[NSTableColumn alloc] initWithIdentifier:@"columnFrist"];
    column1.title = @"columnFrist";
    [column1 setWidth:100];
    [self.tableView addTableColumn:column1];
    
    //第二列
    NSTableColumn * column2 = [[NSTableColumn alloc] initWithIdentifier:@"columnSecond"];
    column2.title = @"columnSecond"; //如果为空，则默认显示‘Field’
    [column2 setWidth:70];
    [self.tableView addTableColumn:column2];
    
    //第三列
    NSTableColumn * column3 = [[NSTableColumn alloc] initWithIdentifier:@"column3"];
    column3.title = @"column3";
    [column3 setWidth:80];
    [self.tableView addTableColumn:column3];
    
    self.tableView.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
    
    self.tableView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
    
    self.tableView.backgroundColor = [NSColor orangeColor];
    
    self.tableView.usesAlternatingRowBackgroundColors = YES; //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.gridColor = [NSColor magentaColor];
    
    //实现tableview的滚动效果
    
    NSScrollView *tableContainerView = [[NSScrollView alloc] initWithFrame:CGRectMake(5, 5, 300, 300)];
    tableContainerView.backgroundColor = [NSColor redColor];
    
    [tableContainerView setDocumentView:self.tableView];
    
    [tableContainerView setDrawsBackground:NO];//不画背景（背景默认画成白色）
    
    [tableContainerView setHasVerticalScroller:YES];//有垂直滚动条
    
    //[_tableContainer setHasHorizontalScroller:YES];  //有水平滚动条
    
    tableContainerView.autohidesScrollers = YES;//自动隐藏滚动条（滚动的时候出现）
    
    
    [self.view.window.contentView addSubview:tableContainerView];
}


@end
