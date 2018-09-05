//
//  zkKeFuVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkKeFuVC.h"

@interface zkKeFuVC ()
@property(nonatomic,assign)BOOL isWhite;
@end

@implementation zkKeFuVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isWhite = YES;
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = [self preferredStatusBarStyle];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.isWhite = NO;
    [UIApplication sharedApplication].statusBarStyle = [self preferredStatusBarStyle];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.isWhite) {
        return UIStatusBarStyleLightContent;
    }else {
        return UIStatusBarStyleDefault;
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:WhiteColor forState:UIControlStateNormal];
    [right setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [right addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    UILabel  * lb =[[UILabel alloc] initWithFrame:CGRectMake(50, sstatusHeight + 5.5 , ScreenW - 100, 35)];
    lb.font =[UIFont boldSystemFontOfSize:18];
    lb.textColor = WhiteColor;
    lb.text = @"客服";
    lb.textAlignment = 1;
    [self.view addSubview:lb];

    
    
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
