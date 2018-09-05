//
//  zkLoginV.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkTextV.h"
@protocol zkLoginVDelegate<NSObject>

- (void)didClickLoginBt:(UIButton *)button number:(NSString *)numbreStr mima:(NSString *)mimaStr;

@end


@interface zkLoginV : UIView
@property(nonatomic,strong)zkTextV *numberV;
@property(nonatomic,strong)zkTextV *mimaV;
/** 注释 */
@property(nonatomic,assign)id<zkLoginVDelegate> delegate;

@end
