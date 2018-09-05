//
//  zkErWeiMaTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkErWeiMaTVC.h"
#import "zkSettingCell.h"
#import "zkSettingTwoCell.h"
#import "zkSettingThreeCell.h"
#import "zkDingYueSettingVC.h"
#import "zkErWeiMaModel.h"
@interface zkErWeiMaTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)NSInteger typeZhiFuBaoOrWeiXin;
@property(nonatomic,strong)NSString *zhiFuBaoNameStr,*zhiFuBaoAccountStr,*weiXinNameStr,*weiXinAccountStr,*zhiFuBaoQRID,*weiQRID,*zhiFuBaoImageStr,*weiXinImageStr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation zkErWeiMaTVC

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.zhiFuBaoQRID.length == 0 && self.weiQRID.length == 0) {
        self.dingYueTvc.model.qrCodeCount = @"0";
    }else {
         self.dingYueTvc.model.qrCodeCount = @"1";
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    self.titleArr = @[@"支付宝",@"姓名",@"账号",@"收款二维码"];
    self.navigationItem.title = @"设置收款二维码";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingTwoCell" bundle:nil] forCellReuseIdentifier:@"zkSettingTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingThreeCell" bundle:nil] forCellReuseIdentifier:@"zkSettingThreeCell"];
    
    [self getQrCodeList];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 150;
    }
    return 44;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    if (indexPath.row == 3) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    if (indexPath.row == 0) {
        zkSettingTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingTwoCell" forIndexPath:indexPath];
        cell.leftLB.text = self.titleArr[indexPath.row];
        cell.rightLB.hidden = NO;
        if (indexPath.section == 0) {
            if (self.zhiFuBaoQRID.length >0) {
                cell.rightLB.text = @"删除";
            }else {
               cell.rightLB.text = @"";
            }
            cell.leftLB.text = @"支付宝";
        }else {
            if (self.weiQRID.length >0) {
                cell.rightLB.text = @"删除";
            }else {
                cell.rightLB.text = @"";
            }
             cell.leftLB.text = @"微信";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) {
            cell.leftImageV.image = [UIImage imageNamed:@"zhifubao"];
        }else {
            cell.leftImageV.image = [UIImage imageNamed:@"weixin2"];
        }
        return cell;
    }else if (indexPath.row <= 3) {
        zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingCell" forIndexPath:indexPath];
       
        cell.leftLB.text = self.titleArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 3) {
            cell.rightLB.text = @"";
        }else if (indexPath.row == 1) {
            if (indexPath.section == 0) {
                cell.rightLB.text = self.zhiFuBaoNameStr;
            }else {
                cell.rightLB.text = self.weiXinNameStr;
            }
        }else if (indexPath.row == 2){
            if (indexPath.section == 0) {
                cell.rightLB.text = self.zhiFuBaoAccountStr;
            }else {
                cell.rightLB.text = self.weiXinAccountStr;
            }
        }
        return cell;
    }else {
      zkSettingThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingThreeCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.zhiFuBaoImageStr] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
        }else {
            [cell.imgV sd_setImageWithURL:[NSURL URLWithString:self.weiXinImageStr] placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        if (indexPath.section == 0) {
            self.typeZhiFuBaoOrWeiXin = 0;
            [self deleteErWeiMaWithID:self.zhiFuBaoQRID];
        }else {
            self.typeZhiFuBaoOrWeiXin = 1;
            [self deleteErWeiMaWithID:_weiQRID];
        }
        
        
        
    } else if (indexPath.row == 4 || indexPath.row == 3) {
        self.typeZhiFuBaoOrWeiXin = indexPath.section;
        [self addImg];
    }else if (indexPath.row == 1 || indexPath.row == 2) {
        
        zkDingYueSettingVC * vc =[[zkDingYueSettingVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.type = indexPath.row + 3;
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                vc.titleStr = self.zhiFuBaoNameStr;
            }else {
                vc.titleStr = self.zhiFuBaoAccountStr;
            }
        }else {
            if (indexPath.row == 1) {
                vc.titleStr = self.weiXinNameStr;
            }else {
                vc.titleStr = self.weiXinAccountStr;
            }
        }
        __weak typeof(self) weakSelf = self;
        vc.sendBlcok = ^(NSString *str) {
            
            if (indexPath.section == 0) {
                if (indexPath.row == 1) {
                    weakSelf.zhiFuBaoNameStr = str;
                }else {
                    weakSelf.zhiFuBaoAccountStr = str;
                }
                if ([weakSelf isZhifuBao]) {
                    [weakSelf addErWeiMa];
                }
            }else {
                if (indexPath.row == 1) {
                    weakSelf.weiXinNameStr = str;
                }else {
                    weakSelf.weiXinAccountStr = str;
                }
                if ([weakSelf isWeiXin]) {
                    [weakSelf addErWeiMa];
                }
            }
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}


- (void)addImg{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
        if ([self isCanUsePhotos]) {
            [self showMXPhotoCameraAndNeedToEdit:YES completion:^(UIImage *image, UIImage *originImage, CGRect cutRect) {
               
                [self updateImage:image];
                
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
                    [self updateImage:image];
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

//获取二维码列表
- (void)getQrCodeList {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getPayQrcodeListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.dataArr = [zkErWeiMaModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            if (self.dataArr.count == 1) {
                zkErWeiMaModel * model = [self.dataArr lastObject];
                if ([model.type integerValue]== 1) {
                    //支付宝
                    self.zhiFuBaoAccountStr = model.account;
                    self.zhiFuBaoImageStr = model.qrcode;
                    self.zhiFuBaoQRID = model.ID;
                    self.zhiFuBaoNameStr = model.realName;
                    
                }else {
                    self.weiXinAccountStr = model.account;
                    self.weiXinImageStr = model.qrcode;
                    self.weiQRID = model.ID;
                    self.weiXinNameStr = model.realName;
                }
            }else if (self.dataArr.count == 2){
                 zkErWeiMaModel * model = [self.dataArr firstObject];
                 zkErWeiMaModel *model2 = [self.dataArr lastObject];
                if ([model.type integerValue] == 1) {
                    
                    //支付宝
                    self.zhiFuBaoAccountStr = model.account;
                    self.zhiFuBaoImageStr = model.qrcode;
                    self.zhiFuBaoQRID = model.ID;
                    self.zhiFuBaoNameStr = model.realName;
                    
                    self.weiXinAccountStr = model2.account;
                    self.weiXinImageStr = model2.qrcode;
                    self.weiQRID = model2.ID;
                    self.weiXinNameStr = model2.realName;
                    
                }else {
                    //支付宝
                    self.zhiFuBaoAccountStr = model2.account;
                    self.zhiFuBaoImageStr = model2.qrcode;
                    self.zhiFuBaoQRID = model2.ID;
                    self.zhiFuBaoNameStr = model2.realName;
                    
                    self.weiXinAccountStr = model.account;
                    self.weiXinImageStr = model.qrcode;
                    self.weiQRID = model.ID;
                    self.weiXinNameStr = model.realName;
                    
                }
                
            }
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//增加二位码
- (void)addErWeiMa{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    
     NSString * url = [zkURL getAddPayQrcodeeURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    
    
    if (self.typeZhiFuBaoOrWeiXin == 0) {
        //支付宝
        dict[@"account"] = self.zhiFuBaoAccountStr;
        dict[@"realName"] = self.zhiFuBaoNameStr;
        dict[@"qrcode"] = self.zhiFuBaoImageStr;
        dict[@"type"] = @(self.typeZhiFuBaoOrWeiXin + 1);
        dict[@"id"]  = @"0";
        if (self.zhiFuBaoQRID.length > 0) {
            url = [zkURL getUpdatePayQrcodeURL];
            dict[@"id"] = self.zhiFuBaoQRID;
        }
    } else {
       //微信
        dict[@"account"] = self.weiXinAccountStr;
        dict[@"realName"] = self.weiXinNameStr;
        dict[@"qrcode"] = self.weiXinImageStr;
        dict[@"type"] = @(self.typeZhiFuBaoOrWeiXin + 1);
        dict[@"id"]  = @"0";
        if (self.weiQRID.length > 0) {
            url = [zkURL getUpdatePayQrcodeURL];
            dict[@"id"] = self.weiQRID;
        }
        
    }
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            if (self.typeZhiFuBaoOrWeiXin == 0) {
                if (self.zhiFuBaoQRID.length > 0) {
                    [SVProgressHUD showSuccessWithStatus:@"修改二维码成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"添加收款二维码成功"];
                   self.zhiFuBaoQRID= [NSString stringWithFormat:@"%@",responseObject[@"result"]];
                }
                
            }else {
                if (self.weiQRID.length > 0) {
                    [SVProgressHUD showSuccessWithStatus:@"修改二维码成功"];
                }else {
                    [SVProgressHUD showSuccessWithStatus:@"添加收款二维码成功"];
                    self.weiQRID = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
                }
                
            }
            [self.tableView reloadData];
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

    

}

- (void)updateImage:(UIImage *)image {
    
    [SVProgressHUD show];
    [zkRequestTool NetWorkingUpLoad:[zkURL getUploadFileURL] images:@[image] name:@"image" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            if (self.typeZhiFuBaoOrWeiXin == 0) {
                self.zhiFuBaoImageStr = responseObject[@"result"];
                if ([self isZhifuBao]) {
                    [self addErWeiMa];
                }
            }else {
                self.weiXinImageStr = responseObject[@"result"];
                if ([self isWeiXin]) {
                    [self addErWeiMa];
                }
               
            }
        
            [self.tableView reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)deleteErWeiMaWithID:(NSString *)ID {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getFDeletePayQrcodeURL] parameters:@{@"userFollowPayQrcodeId":ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            if (self.typeZhiFuBaoOrWeiXin == 0) {
                self.zhiFuBaoNameStr = @"";
                self.zhiFuBaoQRID = @"";
                self.zhiFuBaoImageStr = @"";
                self.zhiFuBaoAccountStr = @"";
            }else {
                self.weiXinNameStr = @"";
                self.weiQRID = @"";
                self.weiXinImageStr = @"";
                self.weiXinAccountStr = @"";
            }
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


//是否是支付宝信息填写完成
- (BOOL)isZhifuBao {
    
    if (self.zhiFuBaoImageStr.length != 0 && self.zhiFuBaoAccountStr.length != 0 && self.zhiFuBaoNameStr.length != 0) {
        return YES;
    }
    return NO;
}
//是否是微信信息填写完毕
- (BOOL)isWeiXin {
    if (self.weiXinNameStr.length != 0 && self.weiXinAccountStr.length != 0 && self.weiXinImageStr.length != 0) {
        return YES;
    }
     return NO;
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
