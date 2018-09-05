//
//  zkOtherCenterFootView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/31.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOtherCenterModel.h"

@protocol zkOtherCenterFootViewDelegate<NSObject>
- (void)didclickZanheadWithIndex:(NSInteger)index;
@end


@interface zkOtherCenterFootView : UIView
@property(nonatomic,assign)CGFloat footHeight;
@property(nonatomic,strong)zkOtherCenterModel *model;
@property(nonatomic,assign)id<zkOtherCenterFootViewDelegate>delegate;

@end
