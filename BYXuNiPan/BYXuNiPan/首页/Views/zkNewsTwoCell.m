//
//  zkNewsTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNewsTwoCell.h"

@implementation zkNewsTwoCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.headBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self addSubview:self.headBt];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10 , 20, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 - 90  , 20)];
        [self addSubview:self.titleLB];
        self.titleLB.attributedText = [@"抓取牛人回复了我的评论" getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor30 textColorTwo:OrangeColor nsrange:NSMakeRange(0, 4)];
        
        
        self.timeV = [[zkTimeContainRedView alloc] initWithFrame:CGRectMake(ScreenW - 105, 20, 90, 20)];
        self.timeV.timeStr = @"19:07";
        [self addSubview:self.timeV];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 40, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 - 90 , 20)];
        self.contentLB.textColor = CharacterGrayColor102;
        self.contentLB.font = kFont(14);
        self.contentLB.text = @"\"我照你的操作赚了不少,好棒好棒\"";
        self.contentLB.lineBreakMode = NSLineBreakByTruncatingMiddle;
        [self addSubview:self.contentLB];
        
        self.replyLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 60, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 - 90 , 20)];
        self.replyLB.textColor = CharacterBlackColor30;
        self.replyLB.font = kFont(14);
        self.replyLB.text = @"赚了就好";
        [self addSubview:self.replyLB];
        
        
        self.lineV =[[UIView alloc] initWithFrame:CGRectMake(0, 94.4, ScreenW, 0.6)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];

    }
    return self;
}


- (void)setModel:(zkMessageModel *)model {
    _model = model;
 
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.fromUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:(SDWebImageRetryFailed)];
    self.titleLB.text = model.title;
    self.contentLB.text = model.profile;
    self.replyLB.text = model.content;
    self.timeV.timeStr = [NSString stringWithTime:model.createDate];
    self.isShowRed = !model.readFlag;
    
}

- (void)setIsShowRed:(BOOL)isShowRed {
    _isShowRed = isShowRed;
    self.timeV.isShowRed = isShowRed;
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


//内部包含红色的viewtime

@interface zkTimeContainRedView()
@property(nonatomic,strong)UILabel *timeLB;
@property(nonatomic,strong)UIView *redView;
@end

@implementation zkTimeContainRedView
- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.timeLB = [[UILabel alloc] initWithFrame:self.bounds];
        self.timeLB.textAlignment = NSTextAlignmentRight;
        self.timeLB.font = kFont(12);
        self.timeLB.textColor = CharacterGrayColor102;
        [self addSubview:self.timeLB];
        
        self.redView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - 4, 0, 4, 4)];
        self.redView.centerY = self.height/2 - 10;
        self.redView.backgroundColor = [UIColor redColor];
        self.redView.layer.cornerRadius = 2;
        self.redView.clipsToBounds = YES;
        [self addSubview:self.redView];

    }
    return self;
}

- (void)setTimeStr:(NSString *)timeStr {
    _timeStr = timeStr;
    self.timeLB.text = timeStr;
}

- (void)setIsShowRed:(BOOL)isShowRed {
    _isShowRed = isShowRed;
    self.redView.hidden = !isShowRed;
}

@end


