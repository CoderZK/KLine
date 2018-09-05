//
//  zkHeadHeadView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/6.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHeadHeadView.h"

@interface zkHeadHeadView()
@property(nonatomic,strong)UILabel *moneyLB,*zhangDieLB,*heightDescLB,*lowDescLB,*heightLB,*lowLB,*shiZhiDescLB;
@end


@implementation zkHeadHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        _moneyLB = [self private_createLabel];
        _moneyLB.text = @"";
        _zhangDieLB = [self private_createLabel];
        _zhangDieLB.text = @"";
        _heightDescLB = [self private_createLabel];
        _heightDescLB.text = @"最高";
        
        _heightLB = [self private_createLabel];
        _lowDescLB = [self private_createLabel];
        _lowDescLB.text = @"最低";
        _lowLB = [self private_createLabel];
        _shiZhiDescLB = [self private_createLabel];
        _shiZhiDescLB.text = @"市值";
        _shiZhiLB = [self private_createLabel];
        
        _moneyLB.font = [UIFont boldSystemFontOfSize:16];
        _moneyLB.textColor = CharacterBlackColor30;
    
        _zhangDieLB.textColor = RedColor;
        _lowLB.textColor = _heightLB.textColor = _shiZhiLB.textColor = BlueColor;
        _lowDescLB.textColor = _heightDescLB.textColor = _shiZhiDescLB.textColor = CharacterGrayColor102;
        
        _heightLB.text = @"";
        _lowLB.text = @"";
        _shiZhiLB.text = @"";
        
        
        [_moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(20);
            make.height.equalTo(@20);
            make.width.equalTo(self).multipliedBy(1/2.0);
        }];
        
        [_zhangDieLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.height.equalTo(@20);
            make.top.equalTo(self.moneyLB.mas_bottom);
            make.width.equalTo(self.moneyLB.mas_width);
            
        }];
        
        CGFloat space = 10;
        
        [_heightDescLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLB.mas_right);
            make.width.equalTo(@45);
            make.top.equalTo(self).offset(space);
            make.height.equalTo(@14);
        }];
        [_heightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.heightDescLB.mas_right);
            make.top.equalTo(self.heightDescLB.mas_top);
            make.bottom.equalTo(self.heightDescLB.mas_bottom);
            make.right.equalTo(self).offset(-15);
            
        }];
        
        [_lowDescLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLB.mas_right);
            make.width.equalTo(self.heightDescLB.mas_width);
            make.top.equalTo(self.heightDescLB.mas_bottom).offset(space);
            make.height.equalTo(self.heightDescLB.mas_height);
        }];
        [_lowLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.lowDescLB.mas_right);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self.heightDescLB.mas_bottom).offset(space);
            make.bottom.equalTo(self.lowDescLB.mas_bottom);

            
        }];
        
        [_shiZhiDescLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moneyLB.mas_right);
            make.width.equalTo(self.heightDescLB.mas_width);
            make.top.equalTo(self.lowDescLB.mas_bottom).offset(space);
            make.height.equalTo(self.heightDescLB.mas_height);
        }];
        [_shiZhiLB mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.shiZhiDescLB.mas_right);
            make.top.equalTo(self.lowDescLB.mas_bottom).offset(space);
            make.bottom.equalTo(self.shiZhiDescLB.mas_bottom);
            make.right.equalTo(self).offset(-15);
            
        }];
        
        
        
    }
    return self;
}

- (void)setHeadModel:(zkKLineModel *)headModel {
    _headModel = headModel;
    CGFloat price = [headModel.price floatValue];
    self.moneyLB.text = [NSString stringWithFormat:@"%0.4f",price];
    CGFloat increase = [headModel.increase floatValue];
    if (increase > 0) {
        self.zhangDieLB.text = [NSString stringWithFormat:@"+%0.2f%%",increase];
        self.zhangDieLB.textColor = GreenColor;
    }else if (increase == 0) {
        self.zhangDieLB.text = [NSString stringWithFormat:@"%0.2f%%",increase];
        self.zhangDieLB.textColor = CharacterGrayColor102;
    }else {
        self.zhangDieLB.text = [NSString stringWithFormat:@"%0.2f%%",increase];
        self.zhangDieLB.textColor = RedColor;
    }
    self.heightLB.text = headModel.kline.high;
    self.lowLB.text = headModel.kline.low;
    
}

- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    //    label.width = 40;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    return label;
}


@end
