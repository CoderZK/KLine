//
//  UIButton+Badge.m
//  测试
//
//  Created by 李炎 on 16/9/2.
//  Copyright © 2016年 李炎. All rights reserved.
//

#import "UIButton+Badge.h"

@interface UIButton ()

@end

@implementation UIButton (Badge)

- (void)setBadge:(NSString *)number andFont:(int)font{
    
    if ( [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        return;
    }

    UILabel * LB = (UILabel *)[self viewWithTag:100];
    [LB removeFromSuperview];
    CGFloat width = self.bounds.size.width;

    CGSize size = [@"1" getSizeWithMaxSize:CGSizeMake(900, 900) withFontSize:font];

    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width*7/10, -width/10, width/3+(number.length-1)*size.width, width/3)];
    badge.tag = 100;
    
    
    if (number.length > 2) {
        number =  [NSString stringWithFormat:@"%@+",@"99"];
        badge.x -= 5;
        badge.width =width/3+(3-1)*size.width;
    }
    
    badge.text = number;
    badge.textAlignment = NSTextAlignmentCenter;
    badge.font = [UIFont systemFontOfSize:font];
    badge.backgroundColor = [UIColor redColor];
    badge.textColor = [UIColor whiteColor];
    badge.layer.cornerRadius = width/6;
    badge.layer.masksToBounds = YES;
    
    if ([number isEqualToString:@"0"]  || [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        badge.hidden = YES;
    }else {
        badge.hidden = NO;
    }
    
    [self addSubview:badge];
}


- (void)setNumber:(NSString *)number andFont:(int )font {
    
    if ([number isEqualToString:@"0"]  || [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        return;
    }
    UILabel * LB = (UILabel *)[self viewWithTag:100];
    [LB removeFromSuperview];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGSize size = [@"1" getSizeWithMaxSize:CGSizeMake(900, 900) withFontSize:font];
    
    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width*4/5,-height / 5 , 12+(number.length-1)*size.width, 12)];
    badge.tag = 100;
    if (number.length > 2) {
        number =  [NSString stringWithFormat:@"%@+",@"99"];
        badge.x -= 5;
        badge.width =width/3+(3-1)*size.width;
    }
    
    badge.text = number;
    badge.textAlignment = NSTextAlignmentCenter;
    badge.font = [UIFont systemFontOfSize:font];
    badge.backgroundColor = [UIColor redColor];
    badge.textColor = [UIColor whiteColor];
    badge.layer.cornerRadius = 6;
    badge.layer.masksToBounds = YES;
    if ([number isEqualToString:@"0"]  || [number isEqualToString:@"(null)"] || [number isEqualToString:@"<null>"]) {
        badge.hidden = YES;
    }else {
        badge.hidden = NO;
    }
    [self addSubview:badge];
    
    
}


@end
