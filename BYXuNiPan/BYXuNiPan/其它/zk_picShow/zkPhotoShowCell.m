//
//  zkPhotoShowCell.m
//  weekend
//
//  Created by kunzhang on 17/3/25.
//  Copyright © 2017年 kunZhang. All rights reserved.
//

#import "zkPhotoShowCell.h"
#import <UIImageView+WebCache.h>
@interface zkPhotoShowCell()<UIScrollViewDelegate>

@end

@implementation zkPhotoShowCell
-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self resetState];
}
-(void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self resetState];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame])
    {
        
        _scrollView=[[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate=self;
        _scrollView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.maximumZoomScale = 4;
        _scrollView.minimumZoomScale = 1;
        [self addSubview:_scrollView];
        
        _imageView=[[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode=UIViewContentModeScaleAspectFit;
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _imageView.userInteractionEnabled=YES;
        [_scrollView addSubview:_imageView];
        
        UITapGestureRecognizer * tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1GestureRecognizer:)];
        tap1.numberOfTouchesRequired=1;
        [self addGestureRecognizer:tap1];
        
        UITapGestureRecognizer * tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2GestureRecognizer:)];
        tap2.numberOfTapsRequired=2;
        [self addGestureRecognizer:tap2];
        [tap1 requireGestureRecognizerToFail:tap2];
        
    }
    return self;
}

-(void)tap1GestureRecognizer:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(photoCellTap:)])
    {
        [self.delegate photoCellTap:self];
    }
}

-(void)tap2GestureRecognizer:(UITapGestureRecognizer *)tap
{
    if (_scrollView.zoomScale>1.0)
    {
        [_scrollView setZoomScale:1.0 animated:YES];
    }
    else
    {
        CGPoint point = [tap locationInView:self];
        [UIView animateWithDuration:0.3 animations:^{
            _scrollView.zoomScale=4.0;
            _scrollView.contentOffset=CGPointMake(point.x*_scrollView.zoomScale-point.x, point.y*_scrollView.zoomScale-point.y);
        }];
        
        
    }
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageView;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    [self resetState];
}
-(void)resetState
{
    _scrollView.zoomScale=1;
}

@end
