//
//  AVPlayerCollectionViewController.m
//  AVAssetDemo
//
//  Created by zhoufei on 2020/9/17.
//  Copyright © 2020 zhf. All rights reserved.
//

#import "AVPlayerCollectionViewController.h"
#import "AVPlayerCollectionViewCell.h"
#import "AVPlayerWindow.h"
#import <Masonry/Masonry.h>

@interface AVPlayerCollectionViewController ()<AVPlayerCollectionViewCellDelegate>
@property (strong, nonatomic) NSMutableArray<NSString *> *dataSource;
@property (strong, nonatomic) UIView *originalContainer;

@property (strong, nonatomic) AVPlayerCollectionViewCell *originalPlayerCell;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTap;

@property (strong, nonatomic) AVPlayerViewController *playerViewController;


@end

@implementation AVPlayerCollectionViewController

static NSString * const reuseIdentifier = @"AVPlayerCollectionViewCell";
#pragma mark - Life Cycle
- (instancetype)initWithCollectionViewLayout:(UICollectionViewLayout *)layout {
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.itemSize = CGSizeMake(170, 170);
    flow.minimumLineSpacing = 20;
    flow.minimumInteritemSpacing = 10;
    flow.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    if (self = [super initWithCollectionViewLayout:flow]) {
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    
    
    self.dataSource = @[
        @"http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318231014076505.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/18/mp4/190318214226685784.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319104618910544.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/19/mp4/190319125415785691.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/17/mp4/190317150237409904.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314223540373995.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/14/mp4/190314102306987969.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/13/mp4/190313094901111138.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312143927981075.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/12/mp4/190312083533415853.mp4",
        @"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4",
        @"https://vfx.mtime.cn/Video/2019/01/15/mp4/190115161611510728_480.mp4",
        @"https://vfx.mtime.cn/Video/2019/08/24/mp4/190824113155647173.mp4",
        @"https://v-cdn.zjol.com.cn/280443.mp4",
        @"https://v-cdn.zjol.com.cn/276982.mp4",
        @"https://v-cdn.zjol.com.cn/276984.mp4",
        @"https://v-cdn.zjol.com.cn/276985.mp4",].mutableCopy;
    
    // Register cell classes
    [self.collectionView registerClass:[AVPlayerCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView reloadData];
    [self setupUI];
    // Do any additional setup after loading the view.
}



#pragma mark - Private Method
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView addGestureRecognizer:self.doubleTap];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清除缓存" style:UIBarButtonItemStylePlain target:self action:@selector(clearAll:)];
}


- (void)setupData {
    
}

// MARK: overwrite

#pragma mark - Public Method

#pragma mark - Event
- (void)tapGestureRecognizer:(UITapGestureRecognizer *)tapGesture {
    if (tapGesture.view == [AVPlayerWindow playerWindow]) {
        CGRect pointR = [self.collectionView convertRect:self.originalPlayerCell.bounds fromView:self.originalPlayerCell];
        [UIView animateWithDuration:1 animations:^{
            [self.originalContainer.layer.sublayers.firstObject setFrame:pointR];
            [tapGesture.view setBackgroundColor:[UIColor clearColor]];
        } completion:^(BOOL finished) {
            [self.originalPlayerCell safePause];
            [tapGesture.view setFrame:pointR];
            [[AVPlayerWindow playerWindow] removeGestureRecognizer:self.doubleTap];
            [[AVPlayerWindow playerWindow] setHidden:YES];
            [self.originalPlayerCell canclePlayCache];
            [self.collectionView addGestureRecognizer:self.doubleTap];
            [self.originalContainer removeFromSuperview];
        }];
    } else {
        CGPoint pointInCollectionView = [tapGesture locationInView:self.collectionView];
        NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pointInCollectionView];
        AVPlayerCollectionViewCell *cell = (AVPlayerCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        if (cell == nil) {
            return;
        }
        
        self.originalPlayerCell = cell;
        CGRect pointR = [self.collectionView convertRect:self.originalPlayerCell.bounds fromView:self.originalPlayerCell];
        
        [self.originalPlayerCell safePlay];
        self.originalContainer = [self.originalPlayerCell getPlayerContainer];
        [self.originalContainer removeFromSuperview];
        [[AVPlayerWindow playerWindow] addSubview:self.originalContainer];
        
        
        [[AVPlayerWindow playerWindow] setFrame:pointR];
        [self.originalContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        [[AVPlayerWindow playerWindow] setHidden:NO];
        
        [UIView animateWithDuration:1 animations:^{
            [[AVPlayerWindow playerWindow] setFrame:[UIScreen mainScreen].bounds];
            [self.originalContainer.layer.sublayers.firstObject setFrame:[UIScreen mainScreen].bounds];
        }completion:^(BOOL finished) {
            [self.collectionView removeGestureRecognizer:self.doubleTap];
            [[AVPlayerWindow playerWindow] addGestureRecognizer:self.doubleTap];
        }];
        
    }
    
}

- (void)clearAll:(id)sender {
    AVPlayerCollectionViewCell *playerCell = (AVPlayerCollectionViewCell *)[[self.collectionView visibleCells] firstObject];
    [playerCell clearCache];
}


#pragma mark - Delegate

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AVPlayerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    [cell configUrlString:self.dataSource[indexPath.row]];
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    AVPlayerCollectionViewCell *cell = (AVPlayerCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    self.originalContainer = [cell getPlayerContainer];
//    self.originalPlayerCell = cell;
    NSString *videoHttpPath = self.dataSource[indexPath.row];
    NSURL *vUrl = [NSURL URLWithString:videoHttpPath];
    AVPlayer *player = [AVPlayer playerWithURL:vUrl];
    
    self.playerViewController.player = player;
    [self presentViewController:self.playerViewController animated:YES completion:^{
        
    }];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


#pragma mark - AVPlayerCollectionViewCellDelegate
- (void)playerCollectionViewCellSetDataComplete:(AVPlayerCollectionViewCell *)cell {
    if ([[self.collectionView visibleCells] containsObject:cell]) {
        NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
        [self.collectionView reloadItemsAtIndexPaths:@[cellIndexPath]];
    }
    
}


#pragma mark - Getter, Setter

//- (UIView *)fullScreenPlayer {
//    if (!_fullScreenPlayer) {
//        _fullScreenPlayer = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _fullScreenPlayer.backgroundColor = [UIColor darkGrayColor];
//
//    }
//    return _fullScreenPlayer;
//}

- (UITapGestureRecognizer *)doubleTap {
    if (!_doubleTap) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer:)];
        _doubleTap.numberOfTapsRequired = 2;
        _doubleTap.numberOfTouchesRequired = 1;
    }
    return _doubleTap;
}

- (AVPlayerViewController *)playerViewController {
    if (!_playerViewController) {
        _playerViewController = [[AVPlayerViewController alloc] init];
        _playerViewController.showsPlaybackControls = YES;
        _playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
        
    }
    return _playerViewController;
}

#pragma mark - NSCopying

#pragma mark - NSObject


@end
