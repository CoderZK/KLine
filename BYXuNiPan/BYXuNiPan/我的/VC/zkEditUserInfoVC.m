//
//  zkEditUserInfoVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkEditUserInfoVC.h"

@interface zkEditUserInfoVC ()

@property(nonatomic,strong)UIButton *comfirnBt;
@property (weak, nonatomic) IBOutlet UIImageView *headImgV;
@property (weak, nonatomic) IBOutlet UITextField *nickTF;
@property (weak, nonatomic) IBOutlet UITextField *siginTF;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *imageStr;

@end

@implementation zkEditUserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"编辑资料";
    
    self.headImgV.layer.cornerRadius = 22.5;
    self.headImgV.clipsToBounds = YES;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"完成" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    zkUserInfoModel * model = [zkSignleTool shareTool].userInfoModel;
    self.nickTF.text = model.nickName;
    self.siginTF.text = model.sign;
    self.imageStr = model.userPic;
    [self.headImgV sd_setImageWithURL:[NSURL URLWithString:model.userPic] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
}
- (IBAction)clickHeadAction:(id)sender {
    
    [self addImg];
    
}


- (void)addImg{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
      
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
                
                self.headImgV.image = image;
                self.image = image;
                [self updateHeadImage];
                
            }];
        }else{
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if ([self isCanUsePicture]) {
            [self showMXPickerWithMaximumPhotosAllow:1 completion:^(NSArray *assets) {
                
                for (int i = 0; i < assets.count; i++)
                {
                    ALAsset *asset = assets[i];
                    //全屏分辨率图片
                    UIImage *image = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
                    self.headImgV.image = image;
                    self.image = image;
                    [self updateHeadImage];
                }
             
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

//点击完成
- (void)clickAction:(UIButton *)button {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    if (self.nickTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入昵称"];
        return;
    }
    if (self.siginTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入个性签名"];
        return;
    }
    
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUpdateBaseDateURL] parameters:@{@"nickname":self.nickTF.text,@"personalSign":self.siginTF.text,@"userPic":self.imageStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"修改资料成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }    else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)updateHeadImage{
    
    //上传图片
    [SVProgressHUD show];
    [zkRequestTool NetWorkingUpLoad:[zkURL getUploadFileURL] images:@[self.image] name:@"headImage" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.imageStr = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
            
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
