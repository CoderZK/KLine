//
//  BaseCollectionViewController.h
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong,readonly)UICollectionView * collectionView;
@property(nonatomic,strong,readonly)UICollectionViewFlowLayout * flowLayout;

@end
