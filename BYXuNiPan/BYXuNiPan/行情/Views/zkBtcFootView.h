//
//  zkBtcFootView.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/10.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBTCDetailModel.h"

@protocol zkBtcFootViewDelegate<NSObject>
- (void)didClickLinkIndex:(NSInteger )index Link:(NSString *)linkStr;

@end


@interface zkBtcFootView : UIView
@property(nonatomic,assign)CGFloat footViewHeight;
@property(nonatomic,strong)zkBTCDetailModel *model;
@property(nonatomic,strong)UIButton *zhanKaiBt; // 展开

@property(nonatomic,assign)id<zkBtcFootViewDelegate>delegate;

@end


@interface zkBtcFootNeiView : UIView
@property(nonatomic,strong)UILabel *leftLB;
@property(nonatomic,strong)UILabel *rightLB;
@property(nonatomic,strong)UIView *lineV;

@end
