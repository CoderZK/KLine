//
//  BaseCollectionViewController.m
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end
@implementation BaseCollectionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseCollectionView];
}
-(void)initBaseCollectionView
{
    _flowLayout=[[UICollectionViewFlowLayout alloc] init];
    
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:_flowLayout];
    _collectionView.autoresizingMask  =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=self.view.backgroundColor;
    _collectionView.alwaysBounceVertical=YES;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    return item;
}

@end
