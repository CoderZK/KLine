//
//  zkHomeTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHomeTwoCell.h"
#define ww (ScreenW - 10*4)/3
#define hh (ww * scaleHomeW) + 40
@interface zkHomeTwoCell()



@end



@implementation zkHomeTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW - 73)/2, 12.5, 73, 25)];
        imageV.image = [UIImage imageNamed:@"txt"];
        [self addSubview:imageV];
        
        self.moreBt = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.moreBt setTitle:@"更多牛人>" forState:UIControlStateNormal];
        [self.moreBt setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        self.moreBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.moreBt.frame = CGRectMake(ScreenW - 70 -15, 15, 70, 25);
        self.moreBt.titleLabel.font = kFont(14);
        [self addSubview:self.moreBt];
        
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenW, hh)];
        self.whiteV.backgroundColor = [UIColor whiteColor];
        [self addSubview:_whiteV];
        
        
        
    }
    return self;
}


- (void)setDataArr:(NSMutableArray<zkBtcRankModel *> *)dataArr {
    _dataArr = dataArr;
    [self.whiteV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger a = dataArr.count > 3 ? 3:dataArr.count;
    
    for (int i = 0 ; i < a ; i++) {
        zkBtcRankModel * model = dataArr[i];
        
        zkHomeNiuRenView * v = [[zkHomeNiuRenView alloc] initWithFrame:CGRectMake(10 + (ww + 10)*i, 0, ww, hh )];
        [v.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.imge] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        v.nameLB.text = model.username;
        v.jinRiLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.dayProfitPercent floatValue]];
        v.leiJiLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.totalProfitPercent floatValue]];
        [self.whiteV addSubview:v];
        v.imageV.image = [UIImage imageNamed:[NSString stringWithFormat:@"red%d",i]];
        v.tag = 100+i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [v addGestureRecognizer:tap];
        
        
    }
    
    
    
    
    
}


- (void)tap:(UITapGestureRecognizer *)tap {
    zkHomeNiuRenView * v = (zkHomeNiuRenView *)[tap view];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickNiuRenWithIndex:)]) {
        [self.delegate didClickNiuRenWithIndex:v.tag - 100];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



//内部的view 
@implementation  zkHomeNiuRenView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width * scaleHomeW)];
        [self addSubview:self.imageV];
        
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.size = CGSizeMake(40, 40);
        self.headBt.layer.cornerRadius = 20;
        self.headBt.clipsToBounds = YES;
        [self.imageV addSubview:self.headBt];
        self.headBt.centerX = self.imageV.centerX;
        self.headBt.centerY = self.imageV.centerY - 10;
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headBt.frame) + 8 , frame.size.width, 15)];
        self.nameLB.textColor = WhiteColor;
        self.nameLB.font = kFont(13);
        self.nameLB.textAlignment = NSTextAlignmentCenter;
        self.nameLB.text = @"江左盟";
        [self.imageV addSubview:self.nameLB];
        
        UILabel * lb1 =[[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageV.frame) + 10 , 30, 15)];
        lb1.font =[UIFont systemFontOfSize:10];
        lb1.text = @"今日收益";
        lb1.textColor = CharacterBackColor153;
        [lb1 sizeToFit];
        [self addSubview:lb1];
        
        UILabel * lb2 =[[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(lb1.frame) +5  , 30, 15)];
        lb2.font =[UIFont systemFontOfSize:10];
        lb2.text = @"累计收益";
        lb2.textColor = CharacterBackColor153;
        [lb2 sizeToFit];
        [self addSubview:lb2];
        
        CGFloat xx = CGRectGetMaxX(lb1.frame);
        CGFloat xw = lb1.width;
        
        self.jinRiLB = [[UILabel alloc] initWithFrame:CGRectMake(xx + 4, CGRectGetMaxY(lb1.frame) + 5 , frame.size.width - 14 - xw  , 15)];
        self.jinRiLB.centerY = lb1.centerY;
        self.jinRiLB.font =[UIFont systemFontOfSize:10];
        self.jinRiLB.textColor = RedColor;
        self.jinRiLB.textAlignment = NSTextAlignmentRight;
        self.jinRiLB.text = @"5.32%";
        [self addSubview:self.jinRiLB];
        
        self.leiJiLB = [[UILabel alloc] initWithFrame:CGRectMake(xx + 4, CGRectGetMaxY(lb1.frame)+5  , frame.size.width - 14 - xw , 15)];
        self.leiJiLB.centerY = lb2.centerY;
        self.leiJiLB.font =[UIFont systemFontOfSize:10];
        self.leiJiLB.textColor = OrangeColor;
        self.leiJiLB.text = @"85.21%";
        self.leiJiLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.leiJiLB];
        
    }
    return self;
}


@end
