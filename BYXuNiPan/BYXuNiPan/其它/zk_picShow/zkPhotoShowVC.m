//
//  zkPhotoShowVC.m
//  weekend
//
//  Created by kunzhang on 17/3/25.
//  Copyright © 2017年 kunZhang. All rights reserved.
//

#import "zkPhotoShowVC.h"
#import "zkPhotoShowCell.h"
#import <UIImageView+WebCache.h>
@interface zkPhotoShowVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,zkPhotoShowCellDelegate>
{
    UICollectionView * _collectionView;
    UILabel * _numLabel;
}
@property(nonatomic,assign)NSInteger currentIndex;
/** 数组 */
@property(nonatomic , strong)NSMutableArray *dataArray;
/*展示的wind*/
@property (nonatomic , strong)UIWindow * window;

@end

@implementation zkPhotoShowVC

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _window;
}

-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    self.view.backgroundColor = [UIColor clearColor];

    self.view.transform = CGAffineTransformMakeScale(0.5, 0.5);
    
   // self.view.center = [UIApplication sharedApplication].keyWindow.rootViewController.view.center;
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    visualEffectView.frame = self.view.bounds;
    visualEffectView.alpha = 1.0;
    [self.view insertSubview:visualEffectView atIndex:0];
    self.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
   
}

- (void)initWithArray:(NSArray *)array index:(NSInteger)index {

    [super viewDidLoad];

     // [self.window setHidden:YES];
    
    // self.window.rootViewController = self;

    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:self];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
    
    [self setCollection];
    
    self.dataArray = array.mutableCopy;
    self.currentIndex = index;
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    [_collectionView reloadData];

}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    NSInteger count = self.dataArray.count;
    if (count>currentIndex)
    {
        _currentIndex = currentIndex;
        [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0] animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        
        _numLabel.text=[NSString stringWithFormat:@"%ld / %ld",(long)_currentIndex+1,(long)count];
    }
}
- (void)setCollection {
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing=20;
    layout.minimumLineSpacing=20;
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, -10, self.view.bounds.size.width+20, self.view.bounds.size.height+20) collectionViewLayout:layout];
    _collectionView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.pagingEnabled=YES;
    _collectionView.backgroundColor = self.view.backgroundColor;
    [_collectionView registerClass:[zkPhotoShowCell class] forCellWithReuseIdentifier:@"zkPhotoShowCell"];
    [self.view addSubview:_collectionView];

    _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-50, self.view.bounds.size.width, 50)];
    _numLabel.font=[UIFont boldSystemFontOfSize:17];
    _numLabel.textColor=[UIColor whiteColor];
    _numLabel.textAlignment=NSTextAlignmentCenter;
    _numLabel.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_numLabel];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.bounds.size.width;
    self.currentIndex = index;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake(collectionView.bounds.size.width-20, collectionView.bounds.size.height-20);
    return size;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    zkPhotoShowCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zkPhotoShowCell" forIndexPath:indexPath];
    if ([self.dataArray[indexPath.row] isKindOfClass:[UIImage class]]) {
        cell.imageView.image = self.dataArray[indexPath.row];
    }else{
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]]] placeholderImage:[UIImage imageNamed:@"zk_morenfang"]];
        
    }

    cell.delegate=self;
    return cell;
}

-(void)photoCellTap:(zkPhotoShowCell*)cell{
    
   // [self.window setHidden:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
  
  
    
}

- (void)tap {
    
    [UIView animateWithDuration:0.2 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
   
}

@end
