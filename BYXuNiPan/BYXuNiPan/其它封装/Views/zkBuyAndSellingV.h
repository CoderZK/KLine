//
//  zkBuyAndSellingV.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkBuyAndSellingVDelegate<NSObject>

- (void)didBuyOrSellV:(NSInteger )buyOrSell xianJiaOrShiJia:(NSInteger )xianOrShi number:(NSString *)number priceStr:(NSString *)priceStr;

@end

@interface zkBuyAndSellingV : UIView
- (void)diss;
- (void)show;
- (void)showWithMaiMai:(BOOL)isBuy;
@property(nonatomic,strong)NSString *moneyStr,*bitNumberStr,*pricStr;
@property(nonatomic,assign)id<zkBuyAndSellingVDelegate>delegate;

@end
