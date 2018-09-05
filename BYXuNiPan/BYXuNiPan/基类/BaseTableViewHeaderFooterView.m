//
//  BaseTableViewHeaderFooterView.m
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseTableViewHeaderFooterView.h"

@implementation BaseTableViewHeaderFooterView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
        _bgImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _bgImageView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:_bgImageView];
    }
    
    
    return self;
}
@end
