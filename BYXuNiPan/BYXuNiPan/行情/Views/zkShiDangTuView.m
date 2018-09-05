//
//  zkShiDangTuView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/6.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkShiDangTuView.h"

@interface zkShiDangTuView()
@property(nonatomic,strong)zkShiDangTuNeiView *tempV;
@end

@implementation zkShiDangTuView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    
    CGFloat sale = 1/11.0;
    
    if (self) {
        for (int i = 0 ; i < 11 ; i++) {

            zkShiDangTuNeiView * view = [[zkShiDangTuNeiView alloc] init];
            view.tag = 200+i;
            [self addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (self.tempV) {
                   make.top.equalTo(self.tempV.mas_bottom);
                }else {
                  make.top.equalTo(self);
                }
                make.right.equalTo(self).offset(-2);
                make.left.equalTo(self).offset(2);
                make.height.equalTo(self).multipliedBy(sale);
            }];
            self.tempV = view;
        }
    }
    return self;
}


- (void)setShiDangArr:(NSArray *)shiDangArr {
    _shiDangArr = shiDangArr;
    for (int i = 1 ; i < 11; i++) {
        zkShiDangTuNeiView * v = (zkShiDangTuNeiView *)[self viewWithTag:i+200];
        v.nowPriceStr = self.nowPriceStr;
        if (i>shiDangArr.count) {
            v.arr = nil;
        }else{
            v.arr = shiDangArr[i-1];
        }
    }
}

- (void)setNowPriceStr:(NSString *)nowPriceStr {
    _nowPriceStr = nowPriceStr;
}


@end






@implementation zkShiDangTuNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    
    CGFloat scale = (frame.size.width - 8)/ 8 / (frame.size.width);
    
    if (self) {
        self.leftLB = [self private_createLabel];
        self.centerLB = [self private_createLabel];
        self.rightLB = [self private_createLabel];
        _leftLB.textAlignment = 0;
        _leftLB.tag = 100;
        _centerLB.tag = 101;
        _rightLB.tag = 102;
        _centerLB.textAlignment = 1;
        _rightLB.textAlignment = 2;
        [_leftLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(2/8.0);
        }];
        
        [_centerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLB.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(3/8.0);
        }];
        [_rightLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerLB.mas_right);
            make.top.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(3/8.0);
        }];
        _leftLB.text = @"买卖";
        _centerLB.text = @"成交价格";
        _rightLB.text = @"成交量";
        
        
    }
    return self;
}

//买卖五档用
- (void)setArr:(NSArray *)arr {
    _arr = arr;
    UILabel * lb1 = (UILabel *)[self viewWithTag:100];
    UILabel * lb2 = (UILabel *)[self viewWithTag:101];
    UILabel * lb3 = (UILabel *)[self viewWithTag:102];
    if (self.tag <=205) {
        lb1.text = [NSString stringWithFormat:@"%@%ld",@"卖",self.tag - 200];
    }else {
        lb1.text = [NSString stringWithFormat:@"%@%ld",@"买",self.tag - 205];
    }
    NSString * str1 = @"";
    if (arr.count > 0) {
        str1 = [NSString stringWithFormat:@"%@",arr[0]];
        CGFloat price = [str1 floatValue];
        
//        if (self.nowPriceStr == nil || [self.nowPriceStr floatValue]  == price) {
//            lb2.textColor = CharacterGrayColor102;
//        }else if ([self.nowPriceStr floatValue] < price) {
//            lb2.textColor = GreenColor;
//        }else {
//            lb2.textColor = RedColor;
//        }
        if (price > 10000) {
            lb2.text = [NSString stringWithFormat:@"%0f",price];
        }else if (price>=1000) {
            lb2.text = [NSString stringWithFormat:@"%0.1f",price];
        }else if (price>=100) {
            lb2.text = [NSString stringWithFormat:@"%0.2f",price];
        }else if (price >= 0){
            lb2.text = [NSString stringWithFormat:@"%0.3f",price];
        }else {
            lb2.text = [NSString stringWithFormat:@"%0.4f",price];
        }
    }else {
        lb2.text = @"--";
//        lb2.textColor = CharacterGrayColor102;
    }
    if (arr.count > 1) {
        NSString * amountStr = [NSString stringWithFormat:@"%@",arr[1]];
        CGFloat amount = [amountStr floatValue];
        if (amount > 10000) {
            lb3.text = [NSString stringWithFormat:@"%0.1f万",amount/10000];
        }else if (amount>=1000) {
            lb3.text = [NSString stringWithFormat:@"%0.1f",amount];
        }else if (amount>=100) {
            lb3.text = [NSString stringWithFormat:@"%0.2f",amount];
        }else if (amount >= 0){
            lb3.text = [NSString stringWithFormat:@"%0.3f",amount];
        }else {
            lb3.text = [NSString stringWithFormat:@"%0.4f",amount];
        }
    }else {
        lb3.text = @"--";
    }
    
}

//实时交易用
- (void)setDict:(NSDictionary *)dict {
    _dict = dict;

    UILabel * lb1 = (UILabel *)[self viewWithTag:100];
    UILabel * lb2 = (UILabel *)[self viewWithTag:101];
    UILabel * lb3 = (UILabel *)[self viewWithTag:102];
    
    if (dict == nil ) {
        lb1.text = lb2.text = lb3.text = @"--";
    }
    if ([dict.allKeys containsObject:@"ts"]) {
        
        NSString * str = [NSString stringWithFormat:@"%@",dict[@"ts"]];
        long long beTime = [str longLongValue]/1000;//1000.0;
        NSString * distanceStr;
        NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
        NSDateFormatter * df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"HH:mm"];
        distanceStr = [df stringFromDate:beDate];
        lb1.text = distanceStr;
        NSString * priceStr = @"";
        if ([dict.allKeys containsObject:@"ts"]) {
          priceStr = [NSString stringWithFormat:@"%@",dict[@"price"]];
        }
        CGFloat price = [priceStr floatValue];
        if (price > 10000) {
            lb2.text = [NSString stringWithFormat:@"%0f",price];
        }else if (price>=1000) {
             lb2.text = [NSString stringWithFormat:@"%0.1f",price];
        }else if (price>=100) {
            lb2.text = [NSString stringWithFormat:@"%0.2f",price];
        }else if (price >= 0){
            lb2.text = [NSString stringWithFormat:@"%0.3f",price];
        }else {
            lb2.text = [NSString stringWithFormat:@"%0.4f",price];
        }
        
        NSString * amountStr = @"";
        if ([dict.allKeys containsObject:@"amount"]) {
            amountStr = [NSString stringWithFormat:@"%@",dict[@"amount"]];
        }
        CGFloat amount = [amountStr floatValue];
        
        if (amount > 10000) {
            lb3.text = [NSString stringWithFormat:@"%0.1f万",amount/10000];
        }else if (amount>=1000) {
            lb3.text = [NSString stringWithFormat:@"%0.1f",amount];
        }else if (amount>=100) {
            lb3.text = [NSString stringWithFormat:@"%0.2f",amount];
        }else if (amount >= 0){
            lb3.text = [NSString stringWithFormat:@"%0.3f",amount];
        }else {
            lb3.text = [NSString stringWithFormat:@"%0.4f",amount];
        }
        NSString * buyOsellStr = @"";
        if ([dict.allKeys containsObject:@"direction"]) {
            buyOsellStr = [NSString stringWithFormat:@"%@",dict[@"direction"]];
        }
        if ([buyOsellStr isEqualToString:@"sell"]) {
            lb3.textColor = [UIColor redColor];
        }else {
            lb3.textColor = [UIColor greenColor];
        }
    }else {
        lb1.text = @"--:--";
    }
    
    
 
}


- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
    //    label.width = 40;
    label.textColor = CharacterGrayColor102;
    [self addSubview:label];
    return label;
}



@end
