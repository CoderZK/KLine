//
//  zkSearchVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@protocol zkSearchVCDelegate<NSObject>

- (void)didClickSearchStr:(NSString * )searchStr withType:(NSInteger)type;

@end

@interface zkSearchVC : BaseViewController

@property(nonatomic,assign)id<zkSearchVCDelegate> delegate;

@end
