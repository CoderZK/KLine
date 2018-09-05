//
//  zkPingLunView.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>
@protocol zkPingLunViewDelegate<NSObject>
- (void)textViewContentText:(NSString *)textStr;
@end


@interface zkPingLunView : UIView
@property(nonatomic,strong)IQTextView *TextV;
@property (nonatomic, weak) id <zkPingLunViewDelegate>delegate;
- (void)show;
- (void)diss;

@end
