//
//  zkMessageBt.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMessageBt.h"

@implementation zkMessageBt

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.size.width-8, 2, 6, 6)];
        _redView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin;
        _redView.backgroundColor = [UIColor redColor];
        _redView.layer.cornerRadius = 3;
        _redView.clipsToBounds = YES;
        _redView.hidden = YES;
        [self addSubview:_redView];
        
    }
    return self;
}


@end
