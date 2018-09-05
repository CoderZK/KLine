//
//  zkHomeOneCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHomeOneCell.h"

@implementation zkHomeOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.scrollView =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenW * Scale)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:self.scrollView];
        
    }
    return self;
}


- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat ww = ScreenW * Scale * ScalePicW;
    CGFloat hh = ScreenW * Scale;
    CGFloat space = 15;
    self.scrollView.contentSize = CGSizeMake((ww + 15) * dataArray.count, 0);
    
    for (int i = 0 ; i < dataArray.count; i++) {
        
        UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake(i * (ww + space), 0, ww, hh)];
        [imgV sd_setImageWithURL:[NSURL URLWithString:dataArray[i]]];
        imgV.userInteractionEnabled = YES;
        imgV.tag = 100 + i;
        [self.scrollView addSubview:imgV];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imgV addGestureRecognizer:tap];
        
    }
    
    
}

- (void)tap:(UITapGestureRecognizer*)tap {
    
    UIImageView * view  = (UIImageView *)tap.view;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectWithindex:)]) {
        
        [self.delegate didSelectWithindex:view.tag - 100];
        
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
