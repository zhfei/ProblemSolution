//
//  ViewController.m
//  CollectionViewMenu
//
//  Created by zhoufei on 2020/11/4.
//

#import "ViewController.h"
#import "CMCollectionViewCell.h"
#import "SpotInfoViewController.h"
#import "MenuiOS13Controller.h"

static NSString *KCMCollectionViewCell = @"CMCollectionViewCell";
static CGFloat kEdgeMargin = 10;

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;


@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.collectionView addGestureRecognizer:longPress];
}

#pragma mark - Private Method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:KCMCollectionViewCell bundle:nil] forCellWithReuseIdentifier:KCMCollectionViewCell];
}


// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event
- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    CGPoint location = [longPressGestureRecognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    
    NSLog(@"长按了collectionView: %@",indexPath);
}

#pragma mark - Delegate
// MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KCMCollectionViewCell forIndexPath:indexPath];
    return cell;
}


// MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (0 == [indexPath row] % 2) {
//        SpotInfoViewController *sivc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SpotInfoViewController"];
//        [self presentViewController:sivc animated:YES completion:nil];
//    } else {
//        MenuiOS13Controller *menu13 = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MenuiOS13Controller"];
//        [self presentViewController:menu13 animated:YES completion:nil];
//    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


//ios13 menu 代理
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender{
    [UIMenuController sharedMenuController];
}


//ios14 新menu 代理
- (nullable UIContextMenuConfiguration *)collectionView:(UICollectionView *)collectionView contextMenuConfigurationForItemAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point API_AVAILABLE(ios(13.0)) {
    NSString *idIndex = [NSString stringWithFormat:@"%d",[indexPath row]];

    CMCollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect imageVR = [cell convertRect:cell.imageV.frame toView:collectionView];
    if (CGRectContainsPoint(imageVR, point)) {
        NSLog(@"长按头像单独处理");
        return nil;
    }

    UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:idIndex previewProvider:nil actionProvider:^UIMenu * _Nullable(NSArray<UIMenuElement *> * _Nonnull suggestedActions) {
        UIAction *save = [UIAction actionWithTitle:@"save" image:nil identifier:nil handler:^(__kindof UIAction * _Nonnull action) {

        }];

        UIMenu *menu = [UIMenu menuWithTitle:@"menu" children:@[save]];
        return menu;
    }];

    return config;
}

- (nullable UITargetedPreview *)collectionView:(UICollectionView *)collectionView previewForHighlightingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    CMCollectionViewCell *cmCell = [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[(NSString *)configuration.identifier integerValue] inSection:0]];

    //提供预览开始时View
    UITargetedPreview *tp = [[UITargetedPreview alloc] initWithView:[cmCell imageV]];
    return tp;
}

- (nullable UITargetedPreview *)collectionView:(UICollectionView *)collectionView previewForDismissingContextMenuWithConfiguration:(UIContextMenuConfiguration *)configuration {
    //提供预览结束时View
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView willPerformPreviewActionForMenuWithConfiguration:(UIContextMenuConfiguration *)configuration animator:(id<UIContextMenuInteractionCommitAnimating>)animator API_AVAILABLE(ios(13.0)){
    //点击预览View，预览view消失时执行的操作
}


#pragma mark - Getter, Setter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
        _flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 2*kEdgeMargin, 200);
        _flowLayout.sectionInset = UIEdgeInsetsMake(kEdgeMargin, kEdgeMargin, kEdgeMargin, kEdgeMargin);
    }
    return _flowLayout;
}

#pragma mark - NSCopying

#pragma mark - NSObject


- (IBAction)showAlert:(UIButton *)sender {
}
@end
