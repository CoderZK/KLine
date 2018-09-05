//
//  NSString+XuSong.m
//  饼状图
//
//  Created by kunzhang on 18/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "NSString+XuSong.h"

@implementation NSString (XuSong)
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)font{
    NSDictionary * attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:font]};
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}
@end
