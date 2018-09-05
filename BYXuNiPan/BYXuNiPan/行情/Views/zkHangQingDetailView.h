//
//  zkHangQingDetailView.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/4.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartView.h"
#import "zkKLineModel.h"
@protocol zkHangQingDetailViewDelgate<NSObject>
- (void)didDoubleClickView;
@end

@interface zkHangQingDetailView : UIView
@property(nonatomic,strong)Y_StockChartView *stockChartView;
@property(nonatomic,assign)id<zkHangQingDetailViewDelgate>delegate;

- (void)updateLayoutWithLandscape:(BOOL)isLandscape;

@property(nonatomic,strong)NSString *biZhongStr;

//实时交易数据
@property(nonatomic,strong)zkKLineModel *shiShiModel;
@property(nonatomic,strong)NSString *shiZhiStr;

@property(nonatomic,copy)void(^sendShiSHiModel)(zkKLineModel *model);

@end
