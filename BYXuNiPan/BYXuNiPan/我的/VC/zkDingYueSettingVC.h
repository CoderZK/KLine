//
//  zkDingYueSettingVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^sendDataBlock)(NSString * str );


@interface zkDingYueSettingVC : BaseViewController

//1 人民币定价 3.0 LXC 定价  4.0姓名 5.0账号 
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,copy)sendDataBlock sendBlcok;

@end
