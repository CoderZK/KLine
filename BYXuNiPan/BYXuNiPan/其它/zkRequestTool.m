//
//  zkRequestTool.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/5.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkRequestTool.h"

@implementation zkRequestTool

+(void)networkingPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    manager.securityPolicy.allowInvalidCertificates=YES;
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            [manager.requestSerializer setValue:[zkSignleTool shareTool].session_token forHTTPHeaderField:@"Authorization"];
        }else {
            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
        }
    }else {
       [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        if (failure)
        {
            failure(task,error);
             [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
    }];
    
}

+(void)networkingJsonPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    NSString * jsonStr = [NSString convertToJsonDataWithDict:parameters];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlStr parameters:nil error:nil];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
           req.allHTTPHeaderFields = @{@"Authorization":[zkSignleTool shareTool].session_token};
        }else {
            req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
        }
    }else {
       req.allHTTPHeaderFields = @{@"Authorization":@"Bearer "};
    }
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[manager dataTaskWithRequest:req uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            success(nil,responseObject);
        } else {
            failure(nil,error);
            [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
        
    }] resume];
    
//    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        if (!error) {
//            success(nil,responseObject);
//        } else {
//            failure(nil,error);
//            [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
//        }
//    }] resume];

    
}

//+(void)networkingTwoPOST:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
//
////    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript",@"text/x-chdr", nil];
//    if ([zkSignleTool shareTool].session_token != nil) {
//        [manager.requestSerializer setValue:[zkSignleTool shareTool].session_token forHTTPHeaderField:@"Authorization"];
//    }
//    // manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    //  [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//
//    //    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
//
////    NSDictionary * dict = parameters;
////    //获取josnzi字符串
////    NSString * josnStr = [NSString convertToJsonData:dict];
////    //获取MD5字符串
////    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
////    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
//    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        if (success)
//        {
//            success(task,responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//
//        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
//            return ;
//        }
//
//        if (failure)
//        {
//            failure(task,error);
//             [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
//        }
//    }];
//
//
//}





+(NSURLSessionDataTask *)networkingGET:(NSString *)urlStr parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    

//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
      [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            [manager.requestSerializer setValue:[zkSignleTool shareTool].session_token forHTTPHeaderField:@"Authorization"];
        }else {
            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
        }
    }else {
        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    NSURLSessionDataTask * task =  [manager GET:urlStr parameters:mDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
            return ;
        }
        [SVProgressHUD showErrorWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
            [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
    }];
 
    return task;
}

//+(NSURLSessionDataTask *)GET:(NSString *)urlStr NSArray:(NSArray *)arr success:(SuccessBlock)success failure:(FailureBlock)failure {
//    
//
//    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    //    [mDict setValue:device forKey:@"deviceId"];
//    //    [mDict setValue:@1 forKey:@"channel"];
//    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    //    [mDict setValue:version forKey:@"version"];
//    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
//    
//    NSString * str = @"";
//    NSString * url = urlStr;
//    if (arr.count <= 0 || arr == nil) {
//        
//    }else if (arr.count == 1) {
//        url = [urlStr stringByAppendingString:[NSString stringWithFormat:@"/%@",arr[0]]];
//    }
//    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSURLSessionDataTask * task =  [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if (success)
//        {
//            success(task,responseObject);
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        if ( [[NSString stringWithFormat:@"%@",error.userInfo[@"NSLocalizedDescription"]] isEqualToString:@"cancelled"]) {
//            return ;
//        }
//        [SVProgressHUD showErrorWithStatus:@"网络异常"];
//        if (failure)
//        {
//            failure(task,error);
//            [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
//        }
//    }];
//    
//    return task;
//    
//}




/**
 上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr image:(UIImage *)image andName:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];

//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            [manager.requestSerializer setValue:[zkSignleTool shareTool].session_token forHTTPHeaderField:@"Authorization"];
        }else {
            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
        }
    }else {
        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSDictionary * dict = parameters;
    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (image) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.3) name:name  fileName:@"195926458462659.png" mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (failure)
        {
            failure(task,error);
             [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
    }];
}
/**
 多张上传图片
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images name:(NSString *)name parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
   
    
    //    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
    //    [mDict setValue:device forKey:@"deviceId"];
    //    [mDict setValue:@1 forKey:@"channel"];
    //    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //    [mDict setValue:version forKey:@"version"];
    //    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
    //    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    if ([zkSignleTool shareTool].session_token != nil) {
        if ([zkSignleTool shareTool].isLogin) {
            [manager.requestSerializer setValue:[zkSignleTool shareTool].session_token forHTTPHeaderField:@"Authorization"];
        }else {
            [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
        }
    }else {
        [manager.requestSerializer setValue:@"Bearer " forHTTPHeaderField:@"Authorization"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    //    //获取josnzi字符串
    //    NSString * josnStr = [NSString convertToJsonData:dict];
    //    //获取MD5字符串
    //    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
    //    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
//        for (UIImage * image in images)
//        {
//            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
//            
//        }
        
        for (int i = 0 ; i < images.count; i++) {
             UIImage *image = images[i];
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:[NSString stringWithFormat:@"%@%d",@"image",i] fileName:[NSString stringWithFormat:@"%@%d.jpg",@"image",i] mimeType:@"image/jpeg"];
        }
        
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
             [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
    }];
}

/**
 上传视频或者视频
 */
+(void)NetWorkingUpLoad:(NSString *)urlStr images:(NSArray<UIImage *> *)images imgName:(NSString *)name fileData:(NSData *)fileData andFileName:(NSString *)fileName parameters:(id)parameters success:(SuccessBlock)success failure:(FailureBlock)failure
{
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
//    NSString *device = [NSString stringWithFormat:@"%@",[[UIDevice currentDevice] identifierForVendor]];
//    [mDict setValue:device forKey:@"deviceId"];
//    [mDict setValue:@1 forKey:@"channel"];
//    NSString *version = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
//    [mDict setValue:version forKey:@"version"];
//    NSString *mdSignature = [NSString stringToMD5:[NSString stringWithFormat:@"%@%@%@%@",device,@1,version,[device substringFromIndex:device.length-5]]];
//    [mDict setValue:[NSString stringWithFormat:@"%@1",mdSignature] forKey:@"signature"];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/plain", @"text/html",@"text/json",@"text/javascript", nil];
    [manager.requestSerializer setValue:@"http://iosapi.jkcsoft.com/public/index.html" forHTTPHeaderField:@"Referer"];
    
    
//    NSDictionary * dict = parameters;
//    //获取josnzi字符串
//    NSString * josnStr = [NSString convertToJsonData:dict];
//    //获取MD5字符串
//    NSString * MD5Str = [NSString stringToMD5:[josnStr stringByAppendingString:@"1375d7ac2b2a8e25"]];
//    NSDictionary * paraDict = @{@"authCode":MD5Str,@"jsonObj":josnStr};
    
    [manager POST:urlStr parameters:mDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (UIImage * image in images)
        {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5) name:name fileName:@"teswwt1.jpg" mimeType:@"image/jpeg"];
            
        }
        if (fileData) {
            [formData appendPartWithFileData:fileData name:fileName fileName:@"369369.mp4" mimeType:@"video/quicktime"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success)
        {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showSuccessWithStatus:@"网络异常"];
        if (failure)
        {
            failure(task,error);
             [SVProgressHUD showErrorWithStatus:@"网路异常!!!!"];
        }
    }];
}


@end
