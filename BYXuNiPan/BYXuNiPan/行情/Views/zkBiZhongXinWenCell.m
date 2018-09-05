//
//  zkBiZhongXinWenCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongXinWenCell.h"

@interface zkBiZhongXinWenCell()
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UIView *lineV;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *contetnLB;

@property(nonatomic,strong)UIView *supportV;
@end


@implementation zkBiZhongXinWenCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.timeLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 50, 20)];
        self.timeLB.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.timeLB.textColor = BlueColor;
        self.timeLB.font = kFont(10);
        self.timeLB.textAlignment = 1;
        self.timeLB.text = @"23:10";
        self.timeLB.layer.cornerRadius = 10;
        self.timeLB.clipsToBounds = YES;
        [self addSubview:self.timeLB];
        
        self.lineV = [[UIView alloc] initWithFrame:CGRectMake(30, 20, 0.5, 10000)];
        self.lineV.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:self.lineV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, ScreenW - 55, 20)];
        self.titleLB.font = [UIFont boldSystemFontOfSize:14];
        self.titleLB.textColor = CharacterBlackColor30;
        self.titleLB.text = @"NEO 安师傅割肉";
        [self addSubview:self.titleLB];
        
        self.contetnLB =  [[UILabel alloc] initWithFrame:CGRectMake(40, 60, ScreenW - 55, 20)];
        self.contetnLB.textColor = CharacterColor50;
        self.contetnLB.text = @"阿斯蒂芬金额前加入反攻技巧二;减肥企鹅 ";
        self.contetnLB.font = kFont(13);
        self.contetnLB.numberOfLines = 0;
        [self addSubview:self.contetnLB];
        
        self.zhanKaiBt  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.zhanKaiBt.frame = CGRectMake(ScreenW - 15 - 50, 10, 50, 20);
        [self.zhanKaiBt setTitle:@"展开" forState:UIControlStateNormal];
        self.zhanKaiBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.zhanKaiBt setTitleColor:BlueColor forState:UIControlStateNormal];
        self.zhanKaiBt.hidden = YES;
        [self addSubview:self.zhanKaiBt];

        
        
        self.supportV =[[UIView alloc] initWithFrame:CGRectMake(40, 80, ScreenW - 55, 30)];
        
        UIButton * bt1 = [UIButton buttonWithType:UIButtonTypeCustom];
        bt1.frame = CGRectMake(0, 5, 60, 20);
        bt1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bt1.titleLabel.font = kFont(12);
        bt1.tag = 100;
        [bt1 addTarget:self action:@selector(clckAction:) forControlEvents:UIControlEventTouchUpInside];
        [bt1 setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [bt1 setImage:[UIImage imageNamed:@"kanduo"] forState:UIControlStateNormal];
        [bt1 setTitle:@"看涨 444" forState:UIControlStateNormal];
        [self.supportV addSubview:bt1];
        
        UIButton * bt2 = [UIButton buttonWithType:UIButtonTypeCustom];
        bt2.frame = CGRectMake(70, 5, 60, 20);
        bt2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bt2.titleLabel.font = kFont(12);
        [bt2 setImage:[UIImage imageNamed:@"kankong"] forState:UIControlStateNormal];
        bt2.tag = 101;
        [bt2 addTarget:self action:@selector(clckAction:) forControlEvents:UIControlEventTouchUpInside];
        [bt2 setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [bt2 setTitle:@"看跌 444" forState:UIControlStateNormal];
        [self.supportV addSubview:bt2];
        [self addSubview:self.supportV];
    }
    return self;
}


- (void)setModel:(zkBtcNewsModel *)model {
    _model = model;
    self.timeLB.text = [model.createDate substringWithRange:NSMakeRange(11, 5)];
    self.titleLB.text = model.title;
    CGFloat height = [@"获取字的高度" getHeightWithFontSize:13 Widht:9999];
    self.contetnLB.text = model.content;
    CGFloat contentH = [model.content getHeightWithFontSize:13 Widht:ScreenW - 55];
    if (contentH > 3*height) {
        self.zhanKaiBt.hidden = NO;
        if (model.isZhanKai) {
            self.contetnLB.mj_h = contentH;
            [self.zhanKaiBt setTitle:@"收起" forState:UIControlStateNormal];
        }else {
            self.contetnLB.mj_h = 3*height;
            [self.zhanKaiBt setTitle:@"更多" forState:UIControlStateNormal];
        }
        self.zhanKaiBt.mj_y = CGRectGetMaxY(self.contetnLB.frame);
        self.supportV.mj_y = CGRectGetMaxY(self.zhanKaiBt.frame);
    }else {
        self.zhanKaiBt.hidden = YES;
        self.contetnLB.mj_h = contentH;
        self.supportV.mj_y = CGRectGetMaxY(self.contetnLB.frame) + 5;
    }
    UIButton * kanduoBt = (UIButton *)[self.supportV viewWithTag:100];
    UIButton * kanKongBt =  (UIButton *)[self.supportV viewWithTag:101];
    [kanduoBt setTitle:[NSString stringWithFormat:@"看多 %@",model.supportNum] forState:UIControlStateNormal];
    [kanduoBt sizeToFit];
    kanduoBt.centerY = 15;
    
    [kanKongBt setTitle:[NSString stringWithFormat:@"看空 %@",model.opposeNum] forState:UIControlStateNormal];
    [kanKongBt sizeToFit];
    kanKongBt.centerY = 15;
    kanKongBt.mj_x = CGRectGetMaxX(kanduoBt.frame) + 15;
    model.cellHeight = CGRectGetMaxY(self.supportV.frame) + 5;
    
}



- (void)clckAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZhangOrDieWithCell:index:)]) {
        [self.delegate didClickZhangOrDieWithCell:self index:button.tag - 100];
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
