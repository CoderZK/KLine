//
//  zkHomeOneCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol zkHomeOneCellDelegate <NSObject>

- (void)didSelectWithindex:(NSInteger )index;


@end
@interface zkHomeOneCell : UITableViewCell

/*数据数组*/
@property (nonatomic , strong)NSMutableArray * dataArray;
/*滚动的scrollveiw*/
@property (nonatomic , strong)UIScrollView * scrollView;
/*可以看到的注释*/
@property (nonatomic )id<zkHomeOneCellDelegate> delegate;

@end
