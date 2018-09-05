//
//  zkShiDangTuView.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/6.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zkShiDangTuView : UIView
@property(nonatomic,strong)NSArray *shiDangArr;
@property(nonatomic,strong)NSString *nowPriceStr;//实时价格
@end


//式挡土内部的图
@interface zkShiDangTuNeiView : UIView
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)NSArray * arr;//五档数据
@property(nonatomic,strong)NSString *nowPriceStr;//实时价格
@property(nonatomic,strong)UILabel *leftLB;
@property(nonatomic,strong)UILabel *centerLB;
@property(nonatomic,strong)UILabel *rightLB;
@end
