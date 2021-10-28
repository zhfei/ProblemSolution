//
//  SpotInfoViewController.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/6.
//

#import "SpotInfoViewController.h"

@interface SpotInfoViewController () <UIContextMenuInteractionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) UIContextMenuInteraction *menuInteraction;

@end

@implementation SpotInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.menuInteraction = [[UIContextMenuInteraction alloc] initWithDelegate:self];
    [self.btn addInteraction:self.menuInteraction];
    
    self.titleLabel.userInteractionEnabled = YES;
    [self.titleLabel addInteraction:self.menuInteraction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nullable UIContextMenuConfiguration *)contextMenuInteraction:(UIContextMenuInteraction *)interaction configurationForMenuAtLocation:(CGPoint)location {
    static NSString *configurationIdentifier = @"configurationIdentifier";
    
    UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:configurationIdentifier previewProvider:^UIViewController * _Nullable{
        return [self previewProvider];
        
    } actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        UIAction *saveSub1 = [UIAction actionWithTitle:@"保存子标题1" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        }];
        UIAction *saveSub2 = [UIAction actionWithTitle:@"保存子标题2" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
        }];
        UIMenu *save = [UIMenu menuWithTitle:@"保存" children:@[saveSub1,saveSub2]];

        UIAction *removeSub1 = [self makeRemoveRatingAction:@"撤回1"];
        UIAction *removeSub2 = [self makeRemoveRatingAction:@"撤回2"];
        UIMenu *remove = [UIMenu menuWithTitle:@"撤回" image:nil identifier:nil options:UIMenuOptionsDisplayInline children:@[removeSub1,removeSub2]];

        UIMenu *menu = [UIMenu menuWithTitle:@"标题" children:@[save,remove]];
        return menu;
    }];
    
    return config;
}

- (UIAction *)makeRemoveRatingAction:(NSString *)title {
    UIAction *remove = [UIAction actionWithTitle:title image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {
    }];
    return remove;
}

- (UIViewController *)previewProvider {
    UIViewController *vc = [UIViewController new];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cat"]];
    vc.view = imageV;
    vc.preferredContentSize = imageV.bounds.size;
    return vc;
}

@end
