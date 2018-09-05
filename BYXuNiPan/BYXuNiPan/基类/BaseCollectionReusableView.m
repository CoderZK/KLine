//
//  BaseCollectionReusableView.m
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@implementation BaseCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _bgImageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgImageView];
        
    }
    return self;
}

@end
