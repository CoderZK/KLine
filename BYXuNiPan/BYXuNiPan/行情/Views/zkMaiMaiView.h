//
//  zkMaiMaiView.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkMaiMaiViewDelegate<NSObject>

- (void)didClickBuyOrSellIndex:(NSInteger )index with:(UIButton *)button;

@end

@interface zkMaiMaiView : UIView
@property(nonatomic,strong)UIButton *buyBt;
@property(nonatomic,strong)UIButton *sellBt;
@property(nonatomic,strong)UIButton *pingLunBt;
@property(nonatomic,strong)UIButton *ziXunBt;

@property(nonatomic,strong)UIImageView *addV;
@property(nonatomic,strong)UILabel *addLB;

@property(nonatomic,assign)id<zkMaiMaiViewDelegate>delegate;


@end
