//
//  zkNewsTwoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkMessageModel.h"
@class zkTimeContainRedView;
@interface zkNewsTwoCell : UITableViewCell

@property(nonatomic,assign)BOOL isShowRed;
@property(nonatomic,strong)UIButton *headBt;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)UILabel *replyLB;
@property(nonatomic,strong)zkTimeContainRedView *timeV;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)zkMessageModel *model;


@end

@interface zkTimeContainRedView:UIView
@property(nonatomic,strong)NSString *timeStr;
@property(nonatomic,assign)BOOL isShowRed;
@end
