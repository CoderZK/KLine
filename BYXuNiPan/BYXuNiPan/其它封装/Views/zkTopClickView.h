//
//  zkTopClickView.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zkTopNeiView;

@protocol zkTopClickViewDelegate<NSObject>

- (void)clickTopChooseIndex:(NSInteger )index times:(NSInteger)times;//index 代表点击的第几个 //times 代表点击哪一个的低多少次

@end

@interface zkTopClickView : UIView

- (instancetype)initWithFreame:(CGRect )frame alignmentArr:(NSArray *)alignmentArr titleArr:(NSArray *)titleArr;
@property(nonatomic,assign)id<zkTopClickViewDelegate> delegate;
@end





@protocol zkTopNeiViewDelegate<NSObject>

- (void)didSelectButton:(UIButton *)button view:(zkTopNeiView *)view times:(NSInteger)times;

@end


@interface zkTopNeiView:UIView

@property(nonatomic,strong)NSString *titleStr;
@property(nonatomic,assign)NSInteger AlignmentType; // 0左 1中 2右
@property(nonatomic,assign)id<zkTopNeiViewDelegate> delegate;
@property(nonatomic,assign)BOOL isSelect;

@end
