//
//  zkTieZiSearchResultTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface zkTieZiSearchResultTVC : BaseTableViewController
@property(nonatomic,assign)NSInteger type; //0帖子 1交易 2用户
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSString *searchStr;
- (void)searchWithStr:(NSString *)searchStr type:(NSInteger )type BoolIsSearchOne:(BOOL)isOne;
@end
