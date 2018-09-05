//
//  PopListView.m
//  带箭头的view
//
//  Created by lxm on 15/11/24.
//  Copyright © 2015年 lxm. All rights reserved.
//

#import "PopListView.h"


@interface PopListView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _titleArr;
    UIButton * _bgView;
}
@end

@implementation PopListView

-(void)showAtPoint:(CGPoint)point animation:(BOOL)animation
{
    if (animation)
    {
        CGRect rect = self.frame;
        rect.origin = CGPointMake(point.x , point.y);
        rect.size.height=10;
        self.frame = rect;
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:_bgView];
        _isShow=YES;
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect rect = self.frame;
            rect.size.height=_titleArr.count * 50 ;
            self.frame = rect;
            
        }];
    }
    else
    {
        CGRect rect = self.frame;
        rect.origin = CGPointMake(point.x-self.frame.size.width*0.5-30, point.y+15);
        rect.size.height=100;
        self.frame = rect;
        UIWindow * window = [UIApplication sharedApplication].delegate.window;
        [window addSubview:_bgView];
        _isShow=YES;
    }
}

-(void)disMissAnimation:(BOOL)animation;
{
    if (animation)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            CGRect rect = self.frame;
            rect.size.height=10;
            self.frame = rect;
            
        } completion:^(BOOL finished) {
            
            [_bgView removeFromSuperview];
            _isShow=NO;
            
        }];
    }
    else
    {
        [_bgView removeFromSuperview];
        _isShow=NO;
    }
    
    
}
-(void)bgBtnClick
{
    [self disMissAnimation:YES];
}
-(instancetype)initWithTitleArr:(NSArray *)titleArr
{
    CGRect frame = CGRectMake(0, 0, 80, titleArr.count * 50+20);
    if (self=[super initWithFrame:frame])
    {
        _bgView = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_bgView addTarget:self action:@selector(bgBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _titleArr=titleArr;
        self.backgroundColor=[UIColor clearColor];
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10,frame.size.width, frame.size.height-10) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.layer.cornerRadius=6;
        _tableView.layer.masksToBounds=YES;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_tableView];
        
        [_bgView addSubview:self];
        
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)])
        {
            _tableView.separatorInset=UIEdgeInsetsZero;
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])
        {
            _tableView.layoutMargins=UIEdgeInsetsZero;
        }

        
    }
    return self;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        cell.separatorInset=UIEdgeInsetsZero;
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        cell.layoutMargins=UIEdgeInsetsZero;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopListViewCellTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PopListViewCellTableViewCell"];
    if (!cell)
    {
        cell=[[PopListViewCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PopListViewCellTableViewCell"size:CGSizeMake(80, 50)];
    }
    cell.backgroundColor=tableView.backgroundColor;
    cell.titleLab.text = [_titleArr objectAtIndex:indexPath.row];
    if (indexPath.row+1 == _titleArr.count)
    {
        cell.lineView.hidden = YES;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self disMissAnimation:NO];
    if ([self.delegate respondsToSelector:@selector(PopListView:didSelectRowAtIndexPath:)])
    {
        [self.delegate PopListView:self didSelectRowAtIndexPath:indexPath];
    }
}


//一下方法就是设置这个view带箭头

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeZero;
}
- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 1.0);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    [self getDrawPath:context];
    CGContextFillPath(context);
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6;
    CGFloat minx = CGRectGetMinX(rrect),midx = CGRectGetMidX(rrect)+30-10,maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),maxy = CGRectGetMaxY(rrect);
    
    CGContextMoveToPoint(context, minx, miny+10);
    CGContextAddLineToPoint(context,midx-10, miny+10);
    CGContextAddLineToPoint(context,midx, miny);
    CGContextAddLineToPoint(context,midx+10, miny+10);

    CGContextAddArcToPoint(context, maxx, miny+10, maxx, maxy, radius);
    CGContextAddArcToPoint(context, maxx, maxy, minx, maxy, radius);
    CGContextAddArcToPoint(context, minx, maxy, minx, miny+10, radius);
    CGContextAddArcToPoint(context, minx, miny+10, midx, miny+10, radius);
    CGContextClosePath(context);
}
@end



@implementation PopListViewCellTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier size:(CGSize)size
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-0.5)];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:14];
        _titleLab.textAlignment = 1;
        [self addSubview:_titleLab];
        
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(5, size.height-0.5, size.width-10, 0.5)];
        _lineView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_lineView];
        
        
    }
    return self;
}

@end



