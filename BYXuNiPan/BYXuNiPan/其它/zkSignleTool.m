//
//  zkSignleTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSignleTool.h"
#import "zkRequestTool.h"
static zkSignleTool * tool = nil;


@implementation zkSignleTool

+ (zkSignleTool *)shareTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[zkSignleTool alloc] init];
    });
    return tool;
}

-(void)setIsLogin:(BOOL)isLogin
{
    [[NSUserDefaults standardUserDefaults] setBool:isLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(BOOL)isLogin
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
}

-(void)setSession_token:(NSString *)session_token
{
    
    [[NSUserDefaults standardUserDefaults] setObject:session_token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setUserInfoModel:(zkUserInfoModel *)userInfoModel {
    NSDictionary * dict = [self dicFromObject:userInfoModel];
    [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"userDict"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (zkUserInfoModel *)userInfoModel {
    
    NSDictionary * dict =  [[NSUserDefaults standardUserDefaults] objectForKey:@"userDict"];
    zkUserInfoModel * model =[[zkUserInfoModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

-(NSString *)session_token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}
-(void)setSession_uid:(NSString *)session_uid
{
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",session_uid] forKey:@"id"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(NSString *)session_uid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"id"];
}

-(void)uploadDeviceTokenWith:(NSString *)deviceToken
{
    if (self.isLogin&&self.deviceToken)
    {
        NSDictionary * dic = @{
                               @"token":deviceToken,
                               @"userId":[zkSignleTool shareTool].userInfoModel.ID,
                               @"type":@"1"
                               };
        [zkRequestTool networkingPOST:[zkURL getsaveUPushTokenURL] parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSLog(@"上传友盟推送成功\n%@",responseObject);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

- (void)setDeviceToken:(NSString *)deviceToken {
    
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"deviceToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (NSString *)deviceToken {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"] == nil) {
        return @"1";
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    
}

- (void)setSerachTiezi:(NSMutableArray *)serachTiezi {
    [[NSUserDefaults standardUserDefaults] setObject:serachTiezi forKey:@"serachTiezi"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)serachTiezi {
        return [[NSUserDefaults standardUserDefaults] objectForKey:@"serachTiezi"];
}

- (void)setSerachBiZhong:(NSMutableArray *)serachBiZhong {
    [[NSUserDefaults standardUserDefaults] setObject:serachBiZhong forKey:@"serachBiZhong"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSMutableArray *)serachBiZhong {
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"serachBiZhong"];
}


- (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if (value == nil) {
            //null
            //[dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
            
        } else {
            //model
            [dic setObject:value forKey:name];
        }
    }
    
    return [dic copy];
}


@end
