//
//  zkContrainTitlesVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"
@class zkNavTitleView;

@protocol zkContrainTitlesVCDelegate<NSObject>

- (void)didSelectTopTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame;

@end


@interface zkContrainTitlesVC : BaseViewController
@property(nonatomic,assign)BOOL isCanScroll;//是否可以滚动

- (instancetype)initFrame:(CGRect)frame titleArr:(NSArray *)titleArr vcsArr:(NSArray *)vcsArr;

@property(nonatomic,assign)id<zkContrainTitlesVCDelegate>delegate;

@end




@protocol zkNavTitleViewDelegate<NSObject>
- (void)didSelectTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame;
@end

@interface zkNavTitleView : UIView
/** 标题数组*/
@property(nonatomic,strong)NSMutableArray *titleArr;
/** 选中的第几个 */
@property(nonatomic,assign)NSInteger selectIndex;

/** 注释 */
@property(nonatomic,assign)id<zkNavTitleViewDelegate> delegate;

@end
