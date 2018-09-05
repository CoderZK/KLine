//
//  PopListView.h
//  带箭头的view
//
//  Created by lxm on 15/11/24.
//  Copyright © 2015年 lxm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopListViewDelegate;
@interface PopListView : UIView


-(instancetype)initWithTitleArr:(NSArray *)titleArr;

@property(nonatomic,assign)id<PopListViewDelegate> delegate;
@property(nonatomic,assign,readonly)BOOL isShow;

-(void)showAtPoint:(CGPoint)point animation:(BOOL)animation;
-(void)disMissAnimation:(BOOL)animation;

@end


@protocol PopListViewDelegate <NSObject>

-(void)PopListView:(PopListView *)view  didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface PopListViewCellTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UIView * lineView;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size;

@end

