//
//  zkSearchView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSearchView.h"

@implementation zkSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        //搜索部分
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.layer.cornerRadius = 3;
        self.clipsToBounds = YES;
        UITextField * textTF =[[UITextField alloc] initWithFrame:self.bounds];
        UIImageView * leftImgV =[[UIImageView alloc] init];
//        textTF.backgroundColor =[UIColor gr];
        UIView * leftView = [[UIView alloc] init];
        leftView.size = CGSizeMake(30, self.frame.size.height);
        leftImgV.frame = CGRectMake(8, (self.frame.size.height - 20) / 2, 20, 20);
        [leftView addSubview:leftImgV];
        textTF.layer.cornerRadius = 3;
        textTF.clipsToBounds = YES;
        textTF.returnKeyType = UIReturnKeySearch;
        textTF.font =[UIFont systemFontOfSize:13];
        leftImgV.image =[UIImage imageNamed:@"search"];
        textTF.leftViewMode = UITextFieldViewModeAlways;
        textTF.leftView = leftView;
        textTF.placeholder = @"搜索活动,如:绘本";
        //    [self.view addSubview:textTF];
        self.textTF = textTF;
        [self addSubview:textTF];
    }
    return self;
}

@end
