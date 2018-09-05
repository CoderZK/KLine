//
//  Y_KLineMAView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineMAView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"
#import "Y_KLineModel.h"
@interface Y_KLineMAView ()

@property (strong, nonatomic) UILabel *MA7Label;

@property (strong, nonatomic) UILabel *MA30Label;

@property (strong, nonatomic) UILabel *dateDescLabel;

@property (strong, nonatomic) UILabel *openDescLabel;

@property (strong, nonatomic) UILabel *closeDescLabel;

@property (strong, nonatomic) UILabel *highDescLabel;

@property (strong, nonatomic) UILabel *lowDescLabel;

@property (strong, nonatomic) UILabel *openLabel;

@property (strong, nonatomic) UILabel *closeLabel;

@property (strong, nonatomic) UILabel *highLabel;

@property (strong, nonatomic) UILabel *lowLabel;

@property (strong, nonatomic) UILabel *zhangDieDescLabel;
@property (strong, nonatomic) UILabel *zhangDieLabel;

@end

@implementation Y_KLineMAView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _MA7Label = [self private_createLabel];
        _MA30Label = [self private_createLabel];
        _dateDescLabel = [self private_createLabel];
        
        
        _openDescLabel = [self private_createLabel];
        _openDescLabel.text = @" 开:";

        _closeDescLabel = [self private_createLabel];
        _closeDescLabel.text = @" 收:";

        _highDescLabel = [self private_createLabel];
        _highDescLabel.text = @" 高:";

        _lowDescLabel = [self private_createLabel];
        _lowDescLabel.text = @" 低:";
        
        _zhangDieDescLabel = [self private_createLabel];
        _zhangDieDescLabel.text = @"涨跌:";

         _zhangDieLabel = [self private_createLabel];
        _zhangDieLabel.text = @"5.2%";
        _openLabel = [self private_createLabel];
        _closeLabel = [self private_createLabel];
        _highLabel = [self private_createLabel];
        _lowLabel = [self private_createLabel];
        
        
        _MA7Label.textColor = [UIColor ma7Color];
        _MA30Label.textColor = [UIColor ma30Color];
        _openLabel.textColor = [UIColor whiteColor];
        _highLabel.textColor = [UIColor whiteColor];
        _lowLabel.textColor = [UIColor whiteColor];
        _closeLabel.textColor = [UIColor whiteColor];
        
        _MA7Label.hidden  = _MA30Label.hidden = YES;
        

//        _MA7Label.hidden  = _MA30Label.hidden = _openDescLabel.hidden = _closeDescLabel.hidden = _highDescLabel.hidden = _lowDescLabel.hidden = _openLabel.hidden = _closeLabel.hidden = _lowLabel.hidden = _closeLabel.hidden = _highLabel.hidden =YES;
        
        
        NSNumber *labelWidth = [NSNumber numberWithInt:47];
        //时间
        [_dateDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom);
            make.height.equalTo(@15);
            make.width.equalTo(@100);

        }];
        //开
        [_openDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_dateDescLabel.mas_right);
//            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom);
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.dateDescLabel.mas_bottom);
            make.height.equalTo(self.dateDescLabel.mas_height);
            make.width.equalTo(@25);
      
        }];
        
        [_openLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_openDescLabel.mas_right);
//            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom);
//            make.width.equalTo(labelWidth);
            
            make.left.equalTo(self.openDescLabel.mas_right);
            make.top.equalTo(self.openDescLabel.mas_top);
            make.bottom.equalTo(self.openDescLabel.mas_bottom);
            make.right.equalTo(self.mas_right);
 
        }];
        
        //最高
        [_highDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.openLabel.mas_bottom);
            make.height.equalTo(self.dateDescLabel.mas_height);
            make.width.equalTo(self.openDescLabel.mas_width);
            
        }];
        
        [_highLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.highDescLabel.mas_right);
            make.top.equalTo(self.highDescLabel.mas_top);
            make.bottom.equalTo(self.highDescLabel.mas_bottom);
            make.right.equalTo(self.mas_right);

        }];
        
        [_lowDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.highLabel.mas_bottom);
            make.height.equalTo(self.dateDescLabel.mas_height);
            make.width.equalTo(self.openDescLabel.mas_width);
        }];
        
        [_lowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lowDescLabel.mas_right);
            make.top.equalTo(self.lowDescLabel.mas_top);
            make.bottom.equalTo(self.lowDescLabel.mas_bottom);
            make.right.equalTo(self.mas_right);
            

        }];
        
        [_closeDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.lowDescLabel.mas_bottom);
            make.height.equalTo(self.dateDescLabel.mas_height);
            make.width.equalTo(self.openDescLabel.mas_width);
        }];
        
        [_closeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.closeDescLabel.mas_right);
            make.top.equalTo(self.closeDescLabel.mas_top);
            make.bottom.equalTo(self.closeDescLabel.mas_bottom);
            make.right.equalTo(self.mas_right);

        }];
        
        
        [_zhangDieDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.closeLabel.mas_bottom);
            make.height.equalTo(self.dateDescLabel.mas_height);
            make.width.equalTo(self.openDescLabel.mas_width);
        }];
        
        [_zhangDieLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.zhangDieDescLabel.mas_right);
            make.top.equalTo(self.zhangDieDescLabel.mas_top);
            make.bottom.equalTo(self.zhangDieDescLabel.mas_bottom);
            make.right.equalTo(self.mas_right);
        }];
        
//        [_MA7Label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_closeLabel.mas_right);
//            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom);
//
//        }];
//
//        [_MA30Label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_MA7Label.mas_right);
//            make.top.equalTo(self.mas_top);
//            make.bottom.equalTo(self.mas_bottom);
//        }];
        
    }
    return self;
}

+(instancetype)view
{
    Y_KLineMAView *MAView = [[Y_KLineMAView alloc]init];

    return MAView;
}
-(void)maProfileWithModel:(Y_KLineModel *)model
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.Date.doubleValue/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [formatter stringFromDate:date];
    _dateDescLabel.text = [@" " stringByAppendingString: dateStr];
    
    _openLabel.text = [NSString stringWithFormat:@"%.2f",model.Open.floatValue];
    _highLabel.text = [NSString stringWithFormat:@"%.2f",model.High.floatValue];
    _lowLabel.text = [NSString stringWithFormat:@"%.2f",model.Low.floatValue];
    _closeLabel.text = [NSString stringWithFormat:@"%.2f",model.Close.floatValue];
    if (model.increase > 0) {
       _zhangDieLabel.text = [NSString stringWithFormat:@"+%0.2f%%",model.increase];
    }else if(model.increase == 0) {
        _zhangDieLabel.text = [NSString stringWithFormat:@"%0.2f%%",model.increase];
    }else {
       _zhangDieLabel.text = [NSString stringWithFormat:@"%0.2f%%",model.increase];
    }
    
    
//    _MA7Label.text = [NSString stringWithFormat:@" MA7：%.2f ",model.MA7.floatValue];
//    _MA30Label.text = [NSString stringWithFormat:@" MA30：%.2f",model.MA30.floatValue];
}
- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:10];
//    label.width = 40;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    return label;
}
@end
