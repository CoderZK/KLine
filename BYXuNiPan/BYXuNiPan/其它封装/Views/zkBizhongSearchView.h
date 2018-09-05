//
//  zkBizhongSearchView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol zkBizhongSearchViewDelegate<NSObject>
- (void)didClickBiZhongWithStr:(NSString *)searchStr;
@end


@interface zkBizhongSearchView : UIView

@property(nonatomic,assign)id<zkBizhongSearchViewDelegate>delegate;

@property(nonatomic,assign)CGFloat selfHight;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIButton *clearBt;

@end
