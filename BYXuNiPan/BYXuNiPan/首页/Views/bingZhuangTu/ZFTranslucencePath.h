//
//  ZFTranslucencePath.h
//  饼状图
//
//  Created by kunzhang on 18/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ZFTranslucencePath : CAShapeLayer

+ (instancetype)layerWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

- (instancetype)initWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;

@end
