//
//  zkHomeLeftNavV.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol zkHomeLeftNavVDelegate<NSObject>

- (void)didSelectLeftNavWithIndex:(NSInteger)index;

@end

@interface zkHomeLeftNavV : UIView

/** 注释 */
@property(nonatomic,assign)id<zkHomeLeftNavVDelegate>delegate;

@property(nonatomic,assign)NSInteger selectIndex;

@end
