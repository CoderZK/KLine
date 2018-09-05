//
//  NSObject+XuSong.m
//  饼状图
//
//  Created by kunzhang on 18/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "NSObject+XuSong.h"

@implementation NSObject (XuSong)
- (void)dispatch_after_withSeconds:(float)seconds actions:(void(^)(void))actions{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        actions();
    });
}
@end
