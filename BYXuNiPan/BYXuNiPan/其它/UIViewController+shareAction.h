//
//  UIViewController+shareAction.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zkShareModel;
@interface UIViewController (shareAction)
- (void)shareWithSetPreDefinePlatforms:(NSArray *)platforms withUrl:(NSString *)url shareModel:(zkShareModel *)model;

- (NSDictionary *)getUseInfoWithToken:(NSString *)token;


@end
