//
//  zkRegistV.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkTextV.h"
@protocol zkRegistVDelegate<NSObject>

- (void)didClickRegistBt:(UIButton *)button number:(NSString *)numberStr code:(NSString *)codeStr mima:(NSString *)mimaStr;

@end

@interface zkRegistV : UIView

@property(nonatomic,strong)zkTextV *phoneV;
@property(nonatomic,strong)zkTextV *miMaOneV;
@property(nonatomic,strong)zkTextV *codeV;
/** 注释 */
@property(nonatomic,assign)id<zkRegistVDelegate> delegate;

@end
