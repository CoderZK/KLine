//
//  zkPingLunDetailCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/27.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPingLunDetailCell.h"

@implementation zkPingLunDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
}



- (void)setParentId:(NSString *)parentId {
    _parentId = parentId;
}

- (void)setModel:(zkHomelModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.nameLB.text = model.createByNickName;
    self.timeLB.text = [NSString stringWithTime:model.createDate];
    self.zanLB.text = model.supportCount;
    if (model.supportFlag) {
        self.zanImgV.image = [UIImage imageNamed:@"praise_p"];
    }else {
        self.zanImgV.image = [UIImage imageNamed:@"praise_n"];
    }
    
    if ([self.parentId isEqualToString:model.parentId]) {
        //对主内容进行的回复
        self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor30];
    }else {
        NSString * text = [NSString stringWithFormat:@"回复%@: %@",model.replyToNickName,model.content];
        self.contentLB.attributedText = [text getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor30 textColorTwo:YellowColor nsrange:NSMakeRange(2, model.replyToNickName.length)];
        
    }
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
