//
//  zkPhotoShowCell.h
//  weekend
//
//  Created by kunzhang on 17/3/25.
//  Copyright © 2017年 kunZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkPhotoShowCellDelegate;

@interface zkPhotoShowCell : UICollectionViewCell
/**  */
@property(nonatomic , strong)UIImageView *imageView;
/**  */
@property(nonatomic , strong)UIScrollView *scrollView;
/** 代理 */
@property(nonatomic , assign)id<zkPhotoShowCellDelegate>delegate;

@end

@protocol zkPhotoShowCellDelegate <NSObject>

-(void)photoCellTap:(zkPhotoShowCell*)cell;

@end
