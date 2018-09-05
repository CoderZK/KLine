//
//  zkBiZhongXinWenCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBtcNewsModel.h"
@class zkBiZhongXinWenCell;
@protocol zkBiZhongXinWenCellDelegate<NSObject>
- (void)didClickZhangOrDieWithCell:(zkBiZhongXinWenCell *)cell index:(NSInteger)index;
@end

@interface zkBiZhongXinWenCell : UITableViewCell
@property(nonatomic,assign)id<zkBiZhongXinWenCellDelegate>delegate;
@property(nonatomic,strong)UIButton * zhanKaiBt;
@property(nonatomic,strong)zkBtcNewsModel *model;

@end
