//
//  zkPingLunDetailHeadView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/27.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol zkPingLunDetailHeadViewDelegate<NSObject>

- (void)didClickheadBt:(UIButton *)button index:(NSInteger )index;

@end

@interface zkPingLunDetailHeadView : UIView
@property(nonatomic,strong)zkHomelModel *model;
@property(nonatomic,assign)CGFloat headHeight;

@property(nonatomic,assign)id<zkPingLunDetailHeadViewDelegate>delegate;

@end
