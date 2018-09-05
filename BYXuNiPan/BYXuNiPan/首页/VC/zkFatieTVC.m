//
//  zkFatieTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkFatieTVC.h"
#import "LYScrollImgCell.h"
#import <IQTextView.h>
@interface zkFatieTVC ()<LYDeleImgDelagate>
@property(nonatomic,strong)UIButton *fabuBt;
@property(nonatomic,strong)NSMutableArray *imgs;
@property(nonatomic,strong)IQTextView *TV;
@property(nonatomic,strong)NSString *imageStr;
@end

@implementation zkFatieTVC

- (NSMutableArray *)imgs {
    if (_imgs == nil) {
        _imgs = [NSMutableArray array];
    }
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发贴";
    
    
    UIView * whiteV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    whiteV.backgroundColor = WhiteColor;
    
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 8, ScreenW - 16, 150 - 21)];
    self.TV.placeholder = @"分享自己的观点";
    self.TV.font = kFont(14);
    [whiteV addSubview:self.TV];
    [self.view addSubview:whiteV];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 145, ScreenW, 5)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [whiteV addSubview:backV];
    

    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"发布" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    [self.tableView registerClass:[LYScrollImgCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableHeaderView = whiteV;
    
}

//点击发布
- (void)clickAction:(UIButton *)button {
    //上传图片
    if (self.imgs.count > 0) {
        [SVProgressHUD show];
    [zkRequestTool NetWorkingUpLoad:[zkURL getUploadFileURL] images:self.imgs name:@"image" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                [SVProgressHUD dismiss];
                self.imageStr = responseObject[@"result"];
                [self faTieAction:button];
            }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
            }else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }else {
        [self faTieAction:button];
    }
   

}

- (void)faTieAction:(UIButton *)button {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    if (self.TV.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入你的分享"];
        return;
    }
//    if (self.TV.text.length > 500) {
//        [SVProgressHUD showErrorWithStatus:@"请输入你的分享"];
//        return;
//    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"content"] = self.TV.text;
    dict[@"img"] = self.imageStr;
    dict[@"type"] = @"1";
    
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:[zkURL getFaTieURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"发帖成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.fatieBlcok != nil ){
                    self.fatieBlcok();
                }
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==80001){
            [SVProgressHUD showSuccessWithStatus:@"发帖成功,帖子进入后台审核中..."];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = (ScreenW-60)/3;
    return 30+height+12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYScrollImgCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSMutableArray * arr = @[].mutableCopy;
    if (self.imgs.count > 0) {
        [arr addObjectsFromArray:self.imgs];
    }
    
    cell.imgs = arr;
    [cell.selectBtn addTarget:self action:@selector(addImg) forControlEvents:UIControlEventTouchUpInside];
    cell.delegate = self;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)addImg{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (self.imgs.count ==9) {
            [SVProgressHUD showErrorWithStatus:@"图片最多选择3张"];
            return;
        }
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                [self.imgs addObject:image];
                [self.tableView reloadData];
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:9-  self.imgs.count completion:^(NSArray *assets) {
                
                for (int i = 0; i < assets.count; i++)
                {
                    if (self.imgs.count  <9)
                    {
                        ALAsset *asset = assets[i];
                        //全屏分辨率图片
                        UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                        [self.imgs addObject:image];
                    }
                }
                [self.tableView reloadData];
                
            }];
            
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action1];
    [ac addAction:action2];
    [ac addAction:action3];
    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
}


#pragma mark --- 删除哪一张照片时 ----
- (void)deleImgAtIndex:(NSInteger)index {
    
    [self.imgs removeObjectAtIndex:index];
    [self.tableView reloadData];
    
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
