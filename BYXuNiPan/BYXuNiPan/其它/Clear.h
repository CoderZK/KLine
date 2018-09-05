//
//  Clear.h
//  古风圈
//
//  Created by qingyun on 16/7/4.
//  Copyright © 2016年 李炎. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^cleanCacheBlock)();
@interface Clear : NSObject
//清理缓存
+(void)cleanCache:(cleanCacheBlock)block;

//整个缓存目录的大小
+(float)folderSizeAtPath;
@end
