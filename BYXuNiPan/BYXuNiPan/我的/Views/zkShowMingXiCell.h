//
//  zkShowMingXiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOtherCenterModel.h"
@class zkShowMingXiCell;
@protocol zkShowMingXiCellDelegate<NSObject>
- (void)didSelectCell:(zkShowMingXiCell *)cell indexPath:(NSIndexPath*)indexPath;
- (void)didSelectCheDanWithIndex:(NSInteger)index WithModel:(zkBTCChiYouModel *)model;
@end

//此cell是用来展示持仓名字,未提交等的
@interface zkShowMingXiCell : UITableViewCell

@property(nonatomic,strong)zkOtherCenterModel *model;

/**  */
@property(nonatomic,strong)NSMutableArray *dataArr;


/** 内部cell的类型 0持仓明细   1.0未成交   2.0成交历史    3.0 历史委托 */
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)UIButton *moreBt;
@property(nonatomic,assign)id<zkShowMingXiCellDelegate>delegete;


@end
