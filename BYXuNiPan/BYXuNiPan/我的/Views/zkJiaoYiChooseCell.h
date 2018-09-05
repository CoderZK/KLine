//
//  zkJiaoYiChooseCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zkJiaoYiChooseCell;
@protocol zkJiaoYiChooseCellDelegate<NSObject>

- (void)didClickChooseView:(zkJiaoYiChooseCell *)cell headIndex:(NSInteger)index isSmaeClick:(BOOL)isSame;

@end

@interface zkJiaoYiChooseCell : UITableViewCell

@property(nonatomic,strong)NSMutableArray *dataArr;
/** 注释 */
@property(nonatomic,assign)id<zkJiaoYiChooseCellDelegate> delegate;

@property(nonatomic,assign)NSInteger sIndex;

@end
