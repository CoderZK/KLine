//
//  zkDingYueJieShaoTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueJieShaoTVC.h"
#import <IQTextView.h>
@interface zkDingYueJieShaoTVC ()
@property(nonatomic,strong)IQTextView *textV;
@end

@implementation zkDingYueJieShaoTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订阅介绍";
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"完成" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    view.backgroundColor = [UIColor whiteColor];

    
    self.textV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 10, ScreenW - 16, 180)];
    self.textV.font = [UIFont systemFontOfSize:14];
    self.textV.placeholder = @"请输入介绍";
    [view addSubview:self.textV];
    self.tableView.tableHeaderView = view;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
}

- (void)clickAction:(UIButton *)button {
    if(self.sendJieShaoBlock != nil ) {
        self.sendJieShaoBlock(self.textV.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
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
