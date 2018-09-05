//
//  zkBannerModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/30.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBannerModel : NSObject
@property(nonatomic,strong)NSString *ID;//帖子ID
@property(nonatomic,strong)NSString *createBy;
@property(nonatomic,strong)NSString *createDate;
@property(nonatomic,strong)NSString *createByNickName;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *linkUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *updateBy;
@property(nonatomic,strong)NSString *updateDate;
@property(nonatomic,strong)NSString *type;
@end
