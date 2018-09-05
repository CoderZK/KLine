//
//  zkTieZiXiangQingHeadView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkTieZiXiangQingHeadViewDelegate<NSObject>
//点击点赞,下单,分享
- (void)didClickZanOrXiaDanOrShare:(NSInteger )index;
//点击点赞人时候
- (void)didClickZanPeopleWithID:(NSString *)ID andIsAll:(BOOL)isall;
@end

@interface zkTieZiXiangQingHeadView : UIView

@property(nonatomic,assign)CGFloat headHeight;
//头图的类型  分为下单和帖子两种 1 帖子 2.0 下单 
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)zkHomelModel *model;
@property(nonatomic,assign)id<zkTieZiXiangQingHeadViewDelegate>delegate;
@end
