//
//  zkNiuRenBangCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNiuRenBangCell.h"
#import "ZFPieChart.h"

@interface zkNiuRenBangCell()
/** <#注释#> */
@property(nonatomic,strong)ZFPieChart *pChart;
@end


@implementation zkNiuRenBangCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    NSArray * titleArr = @[@"总收益率",@"日收益率",@"周收益率",@"日操作数",@"持仓币种",@"最新买卖"];
    CGFloat ww = 120;
    CGFloat xw = 15 + 60 + 5;
    if (self) {
        
        self.headBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
      
        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 40 + 15 , 25, 13)];
        [self addSubview:self.imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10 , 15, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15  , 20)];
        self.titleLB.font = [UIFont boldSystemFontOfSize:14];
        self.titleLB.text = @"牛的一比";
        [self addSubview:self.titleLB];
      
        
        self.signLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 40, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 , 16)];
        self.signLB.textColor = CharacterGrayColor102;
        self.signLB.font = kFont(13);
        self.signLB.text = @"善于中长线,稳居前三";
        [self addSubview:self.signLB];
        
        
        ZFPieChart *pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(ScreenW - 125 - 10, 80, 120, 120)];
        //    pieChart.valueArray = [NSMutableArray arrayWithArray:@"410", @"510", @"380", @"420", @"260",nil];
//        pieChart.backgroundColor =[UIColor greenColor];
        pieChart.valueArrayTwo = @[].mutableCopy;
        pieChart.valueArray = @[].mutableCopy;
        pieChart.title = @"币种\n配置";
        pieChart.isShowDetail = NO;
        pieChart.colorArray = [NSMutableArray arrayWithObjects:RGB(44, 151, 238),RGB(94, 178, 240) ,RGB(231, 83, 61),RGB(239, 103, 56) ,RGB(246, 141, 76),nil];
        self.pChart = pieChart;
        [self addSubview:pieChart];
      
        
        self.allEarningsLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80, ww , 25)];
        self.allEarningsLB.textColor = CharacterColor50;
        self.allEarningsLB.font = kFont(13);
        self.allEarningsLB.text = @"133333.58%";
        [self addSubview:self.allEarningsLB];
        
        self.dayEarningsLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80 + 25, ww , 25)];
        self.dayEarningsLB.textColor = CharacterColor50;
        self.dayEarningsLB.font = kFont(13);
        self.dayEarningsLB.text = @"133333.58%";
        [self addSubview:self.dayEarningsLB];
        
        
        self.weekEarningsLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80 + 50 , ww , 25)];
        self.weekEarningsLB.textColor = CharacterColor50;
        self.weekEarningsLB.font = kFont(13);
        self.weekEarningsLB.text = @"133333.58%";
        [self addSubview:self.weekEarningsLB];
        
        self.dayOperationLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80 + 75, ww , 25)];
        self.dayOperationLB.textColor = CharacterColor50;
        self.dayOperationLB.font = kFont(13);
        self.dayOperationLB.text = @"133333.58%";
        [self addSubview:self.dayOperationLB];
        
        self.allCurrencyLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80 + 100, ww , 25)];
        self.allCurrencyLB.textColor = CharacterColor50;
        self.allCurrencyLB.font = kFont(13);
        self.allCurrencyLB.text = @"133333.58%";
        [self addSubview:self.allCurrencyLB];
        
        self.newsBuyLB = [[UILabel alloc] initWithFrame:CGRectMake(xw, 80 + 125 , ScreenW - xw - 5 , 25)];
        self.newsBuyLB.textColor = OrangeColor;
        self.newsBuyLB.font = kFont(13);
        self.newsBuyLB.numberOfLines = 1;
        self.newsBuyLB.text = @"133333.58%";
        [self addSubview:self.newsBuyLB];
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 240, ScreenW, 0.6)];
        backV.backgroundColor = lineBackColor;
        [self addSubview:backV];
 
        
        [self  setViews:titleArr];
    }
    return self;
}


- (void)setViews:(NSArray *)titleArr {
    for (int i = 0 ; i < titleArr.count; i++) {
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 80+25*i, 60, 25)];
        lb.font = kFont(13);
        lb.textColor = CharacterColor50;
        lb.text = titleArr[i];
        [self addSubview:lb];
        if(i+1 == titleArr.count) {
            lb.textColor = OrangeColor;
        }
    }
    
}

- (void)setModel:(zkBtcRankModel *)model {
    _model = model;
    
    self.titleLB.text = model.username;
    self.signLB.text = model.remark;
    [self.headBt sd_setImageWithURL:[NSURL URLWithString:model.imge] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    
    self.allEarningsLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.totalProfitPercent floatValue]];
    self.dayEarningsLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.dayProfitPercent floatValue]];
    self.weekEarningsLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.weekProfitPercent floatValue]];
    self.dayOperationLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.operation floatValue]];
    self.allCurrencyLB.text = model.bitCount;
    
    if ([model.bitTrade.type integerValue] == 1 || [model.bitTrade.type integerValue] == 3) {
        self.newsBuyLB.text = [NSString stringWithFormat:@"%@USDT/个%@%@,仓位%0.2f%%",model.bitTrade.finalPrice,@"买入",[model.bitTrade.bitName uppercaseString],[model.position floatValue]];
    }else {
        self.newsBuyLB.text = [NSString stringWithFormat:@"%@USDT/个%@%@,仓位%0.2f%%",model.bitTrade.finalPrice,@"卖出",[model.bitTrade.bitName uppercaseString],[model.position floatValue]];
    }
    NSMutableArray<zkBtcRankModel *> * prentArr = [self paiXuWithArr:[model.bitBean mutableCopy]];
    NSMutableArray * btNameArr = @[].mutableCopy;
    NSMutableArray * btValueArray = @[].mutableCopy;
    if (model.bitBean.count <=5 ) {
        [prentArr enumerateObjectsUsingBlock:^(zkBtcRankModel * neiModel, NSUInteger idx, BOOL * _Nonnull stop) {
            [btNameArr addObject:[neiModel.bitName uppercaseString]];
            [btValueArray addObject:neiModel.bitPercent];
        }];
    }else {

        CGFloat other = 0;
        for (int i = 0 ; i < 4 ; i++) {
            zkBtcRankModel * neiModel = prentArr[i];
            [btNameArr addObject:[neiModel.bitName uppercaseString]];
            [btNameArr addObject:neiModel.bitPercent];
            other = other + [neiModel.bitPercent floatValue];
        }
        [btNameArr addObject:@"其它"];
        [btValueArray addObject:[NSString stringWithFormat:@"%f",(100 - other)]];
    }


    self.pChart.valueArrayTwo = btNameArr.mutableCopy;
    self.pChart.valueArray = btValueArray.mutableCopy;
    if (btNameArr.count == 0) {
        self.pChart.title = @"";
    }else {
        self.pChart.title =  @"币种\n配置";
    }
    [self.pChart strokePath];
    
    
}

- (NSMutableArray<zkBtcRankModel *> *)paiXuWithArr:(NSMutableArray<zkBtcRankModel *>*)arr {
    

    NSInteger n = arr.count;
    for (int i = 0 ; i < n; i++) {
        
        for (int j = 0; j < n - 1 -i ; j++) {
            if ([arr[j].bitPercent floatValue] < [arr[j+1].bitPercent floatValue]) {
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                
            }
        }
        
    }
    
    return arr;
    
}




//- (void)setModel:(zkNiuRenBangModel *)model {
//    _model = model;
//    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.userPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
//    self.titleLB.text = model.nickName;
//    self.signLB.text = model.sign;
//    
//    
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
