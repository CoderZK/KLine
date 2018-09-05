//
//  zkContrainTitlesFatherVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@protocol zkContrainTitlesFatherVCDelegate<NSObject>

- (void)didSelectTopTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame;

@end

@interface zkContrainTitlesFatherVC : BaseViewController
- (instancetype)initFrame:(CGRect)frame titleArr:(NSArray *)titleArr vcsArr:(NSArray *)vcsArr;
@property(nonatomic,assign)BOOL isCanScroll;//是否可以滚动
@property(nonatomic,assign)id<zkContrainTitlesFatherVCDelegate>delegate;
@end
