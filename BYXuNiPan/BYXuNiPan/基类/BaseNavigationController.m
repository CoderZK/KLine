//
//  BaseNavigationController.m
//  kunzhang_learnkunzhang海食汇
//
//  Created by kunzhang on 16/10/13.
//  Copyright © 2016年 cznuowang. All rights reserved.
//

#import "BaseNavigationController.h"
#import "BaseTableViewController.h"

@implementation BaseNavigationController
-(void)viewDidLoad
{
    [super viewDidLoad];
    //设置bar的背景颜色
    //self.navigationBar.barTintColor=Red;
    
    //设置背景色,并把黑线去掉
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"zk_nav"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //设置bar的title颜色
    self.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    //设置bar的左右按钮颜色
    self.navigationBar.tintColor = [UIColor whiteColor];
 
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //
    //    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.interactivePopGestureRecognizer.delegate =self;
    //        self.interactivePopGestureRecognizer.enabled = YES;
    //
    //    }
    
    if (self.childViewControllers.count > 0) {
        //把标签控制器隐藏
      //  self.tabBarController.tabBar.hidden = YES;
        
     // self.tabBarController.tabBar.alpha = 0;
        
        //自定义button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //为button设置文字
        //[button setTitle:@"" forState:(UIControlStateNormal)];
        // button.titleLabel.font = [UIFont systemFontOfSize:20];
        
        //为button设置image(和backgroudImage不一样)
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"nav_back"] forState:(UIControlStateHighlighted)];

        CGRect frame = CGRectMake(0, 0, 25, 25);
        
        button.frame = frame;
        
        //[button sizeToFit];使button的大小就是里面内容的大小
        //使button里面的内容进行偏移
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
        
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        //        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -15;  //偏移距离  -向左偏移, +向右偏移
        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:button]];
 
    }
    //此句话写在下面可以在外边修改按钮样式,如果系在上面,则会先执行调用viewdidload
    //则不能在外边修改.
    [super pushViewController:viewController animated:YES];
}


- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewWillAppear:animated];
}

- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController viewDidAppear:animated];
}


- (void)back {
    
    [self popViewControllerAnimated:YES];
    
}


@end
