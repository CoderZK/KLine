//
//  zkNewsOneCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zkNewsOneCell : UITableViewCell

/** <#注释#> */
@property(nonatomic,strong)NSString *numberStr;

@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end
