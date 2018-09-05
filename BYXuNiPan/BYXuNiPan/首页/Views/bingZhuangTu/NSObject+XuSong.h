//
//  NSObject+XuSong.h
//  饼状图
//
//  Created by kunzhang on 18/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XuSong)
- (void)dispatch_after_withSeconds:(float)seconds actions:(void(^)(void))actions;
@end
