//
//  zkAttributedLableCell.m
//  TYAttributedLabelDemo
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 tanyang. All rights reserved.
//

#import "zkAttributedLableCell.h"

@interface zkAttributedLableCell ()
@property (nonatomic, weak) TYAttributedLabel *label;
@end

@implementation zkAttributedLableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addAtrribuedLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self addAtrribuedLabel];
    }
    return self;
}

- (void)addAtrribuedLabel
{
    TYAttributedLabel *label = [[TYAttributedLabel alloc]init];
    label.highlightedLinkColor = [UIColor redColor];
    [self addSubview:label];
    _label = label;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [_label setFrameWithOrign:CGPointMake(0, 0) Width:CGRectGetWidth(self.frame)];
    
    // or this use
    //_label.frame = CGRectMake(0, 15, CGRectGetWidth(self.frame), 0);
    //[_label sizeToFit];
    
}
@end
