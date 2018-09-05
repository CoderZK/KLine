//
//  UIView+BSExtension.m
//  BBB
//
//  Created by lanou on 16/5/23.
//  Copyright © 2016年 lanou. All rights reserved.
//

#import "UIView+BSExtension.h"

@implementation UIView (BSExtension)

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x= x;
    self.frame = frame;
    
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
    
}

- (CGFloat)centerX {
    
    return self.center.x;
    
}


- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
    
}

- (CGFloat)centerY {
    return self.center.y;
}


- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y= y;
    self.frame = frame;
    
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    
}

- (CGSize)size {
    
    return self.frame.size;
    
}

- (CGFloat)width {
    
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}


- (CGFloat)x {
    return self.frame.origin.x;
    
}

- (CGFloat)y {
    return self.frame.origin.y;
}









@end
