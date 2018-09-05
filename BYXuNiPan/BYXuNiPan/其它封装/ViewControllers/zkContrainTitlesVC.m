//
//  zkContrainTitlesVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkContrainTitlesVC.h"
@interface zkContrainTitlesVC ()<UIScrollViewDelegate,zkNavTitleViewDelegate>

/**  */
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)zkNavTitleView *navView;
@end

@implementation zkContrainTitlesVC


- (instancetype)initFrame:(CGRect)frame titleArr:(NSArray *)titleArr vcsArr:(NSArray<UIViewController *> *)vcsArr {
    self = [super init];
    if (self) {
        
          [self addChildVcs:vcsArr];

        self.navView = [[zkNavTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 120, 35)];
        self.navView.titleArr = titleArr.mutableCopy;
        self.navView.delegate = self;
        self.navigationItem.titleView = self.navView;

        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        
        _scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width*titleArr.count, 0);
        [self.view addSubview:_scrollView];
        [self scrollViewDidEndScrollingAnimation:_scrollView];
//        
//        self.view.backgroundColor = [UIColor redColor];
      
    }
    return  self;
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    _isCanScroll = isCanScroll;
    _scrollView.scrollEnabled = isCanScroll;
}

- (void)addChildVcs:(NSArray<UIViewController *> *)arr {
    
    for (UIViewController * vc in arr) {
        self.delegate = vc;
        [self addChildViewController:vc];
    }
    
}


- (void)didSelectTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame {
    
    CGPoint Offset = self.scrollView.contentOffset;
    Offset.x = index * self.scrollView.width;
    //设置偏移量,可以移动
    [self.scrollView setContentOffset:Offset animated:YES];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectTopTitleButton:index:isSame:)]) {
        [self.delegate didSelectTopTitleButton:button index:index isSame:isSame];
    }
    
    
}

//滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //调用动画结束时的方法.
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    self.navView.selectIndex = index;
    
}

//动画结束时的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController * vc = self.childViewControllers[index];
    //要设置fram 不然系统会自动去掉状态栏高度
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, _scrollView.width, _scrollView.height);
    // vc.view.x = scrollView.contentOffset.x;
    // vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [scrollView addSubview:vc.view];
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end















#pragma  mark -- 内部的view ------
// 内部导航栏的titleV
@interface zkNavTitleView()
/** 是否是第二次选 */
@property(nonatomic,assign)BOOL isSelectAgane;
@end

@implementation zkNavTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        
        
    }
    return self;
}

- (void)setTitleArr:(NSMutableArray *)titleArr {
    _titleArr = titleArr;
    [self setTitleV];
}

- (void)setTitleV {
    CGFloat ww = self.frame.size.width / self.titleArr.count;
    CGFloat hh = self.frame.size.height;
    for (int i = 0 ; i < _titleArr.count; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*(ww), 0, ww, hh);
        [button setBackgroundImage:[UIImage imageNamed:@"zk_gray"] forState:UIControlStateNormal];
         [button setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateSelected];
        [button setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        button.tag = i + 1000;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
            button.selected = YES;
            button.layer.shadowOffset=CGSizeMake(1, 1);
            button.layer.shadowColor = BlueColor.CGColor;
            button.layer.shadowOpacity = 0.8;
        }else {
            button.layer.shadowOffset=CGSizeMake(1, 1);
            button.layer.shadowColor = BlueColor.CGColor;
            button.layer.shadowOpacity = 0;
        }
        [self addSubview:button];
    }
}

- (void)clickAction:(UIButton *)button {
    
    for (int i = 0 ; i < _titleArr.count; i++) {
        UIButton * buttonNei = (UIButton *)[self viewWithTag:i+1000];
        if (button.tag == buttonNei.tag) {
            if (buttonNei.selected == YES) {
                self.isSelectAgane = YES;
            }else {
                self.isSelectAgane = NO;
            }
            buttonNei.selected = YES;
            buttonNei.layer.shadowOpacity = 0.8;
            
        }else{
            buttonNei.selected = NO;
            buttonNei.layer.shadowOpacity = 0;
        }
    }

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectTitleButton:index:isSame:)]) {
        [self.delegate didSelectTitleButton:button index:button.tag - 1000 isSame:self.isSelectAgane];
    }
    
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    for (int i = 0 ; i < _titleArr.count; i++) {
        UIButton * buttonNei = (UIButton *)[self viewWithTag:i+1000];
        if (selectIndex + 1000 == buttonNei.tag) {
            buttonNei.selected = YES;
        }else{
            buttonNei.selected = NO;
        }
    }
    
}


@end


