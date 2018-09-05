//
//  zkMineHeadView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkMineHeadViewDelegate<NSObject>

- (void)didClickHead:(UIButton *)button index:(NSInteger)index;

@end


@interface zkMineHeadView : UIView

@property(nonatomic,assign)id<zkMineHeadViewDelegate>delegate;
@property(nonatomic,strong)zkUserInfoModel *model;
@end
