//
//  ViewController.h
//  SearchField
//
//  Created by zhoufei on 2022/1/4.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSSearchField *searchField;
@property (weak) IBOutlet NSPopUpButton *searchBtn;
@property (weak) IBOutlet NSLayoutConstraint *btnHeight;

@property (nonatomic, strong) NSMutableArray *bugs;
@end

