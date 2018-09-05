//
//  zkDingYueSettingVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueSettingVC.h"
#import <IQTextView.h>
@interface zkDingYueSettingVC ()
@property (weak, nonatomic) IBOutlet UITextField *leftTF;

@end

@implementation zkDingYueSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * titleArr = @[@"", @"人民币定价",@"",@"LXC定价",@"收款姓名", @"收款账号"];
    
    if (self.type == 1) {
        self.leftTF.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (self.type == 3) {
        self.leftTF.keyboardType = UIKeyboardTypeDecimalPad;
    }else if (self.type == 4) {
        self.leftTF.keyboardType = UIKeyboardTypeDefault;
    }else if (self.type == 5) {
        self.leftTF.keyboardType = UIKeyboardTypeDefault;
    }
    self.navigationItem.title = titleArr[self.type];
    self.leftTF.placeholder = titleArr[self.type];
    self.leftTF.text = self.titleStr;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"完成" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
   
}

- (void)clickAction:(UIButton *)button {
    if (self.sendBlcok != nil ) {
        self.sendBlcok(self.leftTF.text);
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
