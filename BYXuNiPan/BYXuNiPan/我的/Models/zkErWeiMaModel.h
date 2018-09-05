//
//  zkErWeiMaModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkErWeiMaModel : NSObject
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *qrcode;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *type;


//设置订阅用
@property(nonatomic,assign)BOOL freeFlag;
@property(nonatomic,strong)NSString *lxcPrice;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *profile;
@property(nonatomic,strong)NSString *qrCodeCount;



@end
