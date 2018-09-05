//
//  zkPingLunWaiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkHomelModel.h"
@class zkPingLunWaiCell;

@protocol zkPingLunWaiCellDelegate<NSObject>
- (void)didClickZanRenYuanView:(zkPingLunWaiCell *)cell zanBt:(UIButton *)button index:(NSInteger )index;
- (void)didClickPingLunView:(zkPingLunWaiCell *)cell indexPath:(NSIndexPath *)indexPath isFirstName:(BOOL)isFirstName;
- (void)didClickPingLunTableView:(zkPingLunWaiCell *)cell indexPath:(NSIndexPath *)indexPath;
- (void)didClickXiaDanTableView:(zkPingLunWaiCell *)cell;
@end

@interface zkPingLunWaiCell : UITableViewCell

@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,assign)NSInteger type; //cell 的类型 1 取热门回复 2 取最新回复
@property (nonatomic,assign)BOOL isNeiPingLun; //是否是某一个帖子的单个评论
@property(nonatomic,assign)id<zkPingLunWaiCellDelegate> delegate;
@property(nonatomic,strong)zkHomelModel *model;

@end
