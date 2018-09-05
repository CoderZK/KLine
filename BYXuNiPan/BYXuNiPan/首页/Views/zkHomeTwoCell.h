//
//  zkHomeTwoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBtcRankModel.h"
#define scaleHomeW (90/105.0)


@protocol zkHomeTwoCellDelegate<NSObject>
- (void)didClickNiuRenWithIndex:(NSInteger)index;
@end

@interface zkHomeTwoCell : UITableViewCell
@property(nonatomic,strong)UIButton *moreBt;
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)NSMutableArray<zkBtcRankModel *> *dataArr;
@property(nonatomic,assign)id<zkHomeTwoCellDelegate>delegate;
@end


//内部的Vi
@interface zkHomeNiuRenView:UIView
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *nameLB,*jinRiLB,*leiJiLB;
@end



