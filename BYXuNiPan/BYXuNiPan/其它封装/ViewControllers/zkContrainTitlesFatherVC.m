//
//  zkContrainTitlesFatherVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkContrainTitlesFatherVC.h"

@interface zkContrainTitlesFatherVC ()<UIScrollViewDelegate>
/** 三个按钮的View buttonView */
@property(nonatomic , strong)UIView *buttonView;
@property(nonatomic , strong)UIView *alertView;
@property(nonatomic , strong)UIScrollView *scrollView;
@property(nonatomic , assign)NSInteger selectIndex;//记录选中的
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)BOOL isSelectAgane;//是否选中的为同一个
@end

@implementation zkContrainTitlesFatherVC

- (instancetype)initFrame:(CGRect)frame titleArr:(NSArray *)titleArr vcsArr:(NSArray *)vcsArr {
    self = [super init];
    if (self) {
        self.view.frame = frame;
        self.titleArr = titleArr;
        self.navigationItem.title = titleArr.firstObject;
        [self addChildVcs:vcsArr];
        //添加滚动视图
        [self addScrollview];
        [self setTopV:titleArr];

    }
    return  self;
}


//添加滚动视图
- (void)addScrollview {
    //不需要调整inset
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView =[[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 40 , ScreenW, ScreenH  - 40 );
    
    self.scrollView.backgroundColor =[UIColor whiteColor];
    
    self.scrollView.contentSize = CGSizeMake(self.childViewControllers.count * ScreenW, 0);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.view insertSubview:_scrollView atIndex:1];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.scrollEnabled = YES;
    //调用动画结束时,使第一个界面有数据.
    [self scrollViewDidEndScrollingAnimation:_scrollView];
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    _scrollView.scrollEnabled = isCanScroll;
}

- (void)setTopV:(NSArray *)array {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , ScreenW, 40)];
    
    self.buttonView = view;
    self.buttonView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:self.buttonView];
    
    self.alertView =[[UIView alloc] init];
    self.alertView.backgroundColor = BlueColor;
    self.alertView.height = 2;
    self.alertView.y = 40 - 3;
    
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * button =[UIButton new];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        //不可以点击时时红色
        [button setTitleColor:BlueColor forState:UIControlStateSelected];
        button.tag = i + 1000;
        
        button.width = ScreenW / array.count;
        button.height = 40;
        button.x = i * ScreenW / array.count;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.buttonView addSubview:button];
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0 ) {
            [button layoutIfNeeded];
            [button.titleLabel sizeToFit];
            button.selected = YES;
            self.selectIndex = button.tag;
            self.alertView.width = button.titleLabel.width;
            self.alertView.centerX = button.centerX;
        }
        
    }
    [self.buttonView addSubview:self.alertView];
}

//点击上面分类按钮
- (void)clickbutton:(UIButton *)button {
    for (int i = 0 ; i < _titleArr.count; i++) {
        UIButton * buttonNei = (UIButton *)[self.buttonView viewWithTag:i+1000];
        if (button.tag == buttonNei.tag) {
            if (buttonNei.selected == YES) {
                self.isSelectAgane = YES;
            }else {
                self.isSelectAgane = NO;
            }
            buttonNei.selected = YES;
        }else{
            buttonNei.selected = NO;
        }
    }
    [UIView animateWithDuration:0.1 animations:^{
        
        self.alertView.width = button.titleLabel.width;
        self.alertView.centerX = button.centerX;
        
    }];
    
    CGPoint Offset = self.scrollView.contentOffset;
    Offset.x = (button.tag - 1000) * self.scrollView.width;
    //设置偏移量,可以移动
    [self.scrollView setContentOffset:Offset animated:YES];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectTopTitleButton:index:isSame:)]) {
        [self.delegate didSelectTopTitleButton:button index:button.tag - 1000 isSame:self.isSelectAgane];
    }
    self.navigationItem.title = self.titleArr[button.tag - 1000];
 
  
}


//添加字控制器
- (void)addChildVcs:(NSArray<UIViewController *> *)arr {
    
    for (UIViewController * vc in arr) {
        self.delegate = vc;
        [self addChildViewController:vc];
    }
    
}


//滚动停止时
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //调用动画结束时的方法.
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index =scrollView.contentOffset.x / scrollView.width;
    [self clickbutton:self.buttonView.subviews[index]];
    
}

//动画结束时的方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    BaseTableViewController * vc = self.childViewControllers[index];
    //要设置fram 不然系统会自动去掉状态栏高度
    vc.view.frame = CGRectMake(scrollView.contentOffset.x, 0, _scrollView.width, _scrollView.height);
    // vc.view.x = scrollView.contentOffset.x;
    // vc.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
