//
//  zkLunBoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkLunBoCellDelegate<NSObject>

- (void)didSelectLunBoPic:(NSInteger )index;

@end


@interface zkLunBoCell : UITableViewCell
/** 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArr;

/** 注释 */
@property(nonatomic,assign)id<zkLunBoCellDelegate> delegate;

@end
