//
//  LYGuideViewController.m
//  buqiuren
//
//  Created by 李炎 on 16/10/11.
//  Copyright © 2016年 李晓满. All rights reserved.
//

#import "LYGuideViewController.h"
#import "AppDelegate.h"

#define sizePage 2

@interface LYGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIPageControl *pageControl;

@end

@implementation LYGuideViewController

- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((ScreenW-50)/2, ScreenH-30, 50, 30)];
        _pageControl.numberOfPages = 4;
//        _pageControl.currentPageIndicatorTintColor = BlueColor;
//        _pageControl.pageIndicatorTintColor = CellColor;
    }
    return _pageControl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
//    [self.view addSubview:self.pageControl];
    // Do any additional setup after loading the view.
}

- (void)config{
    CGFloat height = self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(ScreenW*sizePage, height);
    //不显示水平进度条
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    for (int i=0; i < sizePage; i++) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"gguide%d",i+1]];
        imgView.frame = CGRectMake(width*i, 0, width, height);
        if (i == (sizePage - 1)) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpHomeVc:)];
            imgView.userInteractionEnabled = YES;
            [imgView addGestureRecognizer:tap];
            
            UIButton *comeinBtn = [UIButton buttonWithType:UIButtonTypeCustom];//182.5 * 51.5
            CGFloat weith = ScreenW*165/375-10;//165 * 46
            CGFloat heigh = ScreenH*46/667;//110 * 30.5
            comeinBtn.frame = CGRectMake((ScreenW-weith)/2, ScreenH-heigh*2 + 10, weith, heigh);
//            [comeinBtn setBackgroundImage:[UIImage imageNamed:@"letwogo"] forState:UIControlStateNormal];
            [comeinBtn setTitle:@"进入APP" forState:0];
            comeinBtn.layer.cornerRadius = 5;
            comeinBtn.layer.borderColor = [UIColor whiteColor].CGColor;
            comeinBtn.layer.borderWidth = 1.5;
            comeinBtn.clipsToBounds = YES;
            comeinBtn.userInteractionEnabled = NO;
            [imgView addSubview:comeinBtn];
        }
        [_scrollView addSubview:imgView];
    }
    [self.view addSubview:_scrollView];
}

- (void)jumpHomeVc:(UITapGestureRecognizer *)tap{
//    CGPoint point = [tap locationInView:self.view];
//    CGRect rect = CGRectMake(0, ScreenH*3/4, ScreenW, ScreenH/4);
//    if (CGRectContainsPoint(rect, point)) {
        AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appdelegate showHomeVC];
//    }
}

#pragma mark - scroll view delegate

//停止拖拽，将要开始减速的方法
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {
        //停止拖拽，如果没有减速过程，则意味着滚动结束
        self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
    }
}

//停止减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //减速结束，意味着滚动结束
    self.pageControl.currentPage = self.scrollView.contentOffset.x/self.scrollView.bounds.size.width;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
