//
//  LYScrollImgCell.m
//  ShareGoGo3
//
//  Created by 李炎 on 2017/7/13.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import "LYScrollImgCell.h"

@implementation LYScrollImgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _upLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, ScreenW-30, 30)];
        _upLab.text = @"请上传圈子头像";
        _upLab.textColor = CharacterBackColor153;
        _upLab.font = [UIFont systemFontOfSize:13];
        _upLab.hidden = YES;
        [self addSubview:_upLab];
        
        CGFloat height = (ScreenW-60)/3;
        _SC = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 15, ScreenW-30, height+12)];
        _SC.showsVerticalScrollIndicator = NO;
        _SC.showsHorizontalScrollIndicator = NO;
        _SC.userInteractionEnabled = YES;
        _SC.contentSize = CGSizeMake(ScreenW-30, height);
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(0, 12, height, height);
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"zk_addpic"] forState:UIControlStateNormal];
        [_SC addSubview:_selectBtn];
        
        [self addSubview:_SC];
        
        _downLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 30+height+12+5, ScreenW-30, 20)];
        _downLab.text = @"我们将在三个工作日内进行审核";
        _downLab.textColor = CharacterDarkColor;
        _downLab.font = [UIFont systemFontOfSize:12];
        _downLab.hidden = YES;
        [self addSubview:_downLab];
        
    }
    return self;
}

- (void)setImgs:(NSMutableArray *)imgs{
    _imgs = imgs;
    
    [_SC.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat height = (ScreenW-60)/3;
    
    if (_isOne) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(0, 12, height, height);
        if (imgs.count == 0) {
          [_selectBtn setBackgroundImage:[UIImage imageNamed:@"zk_addpic"] forState:UIControlStateNormal];
        }else {
         [_selectBtn setBackgroundImage:imgs.firstObject forState:UIControlStateNormal];
        }
        
        [_SC addSubview:_selectBtn];
        return;
    }
    
    if (imgs.count == 3) {
        _selectBtn.hidden = NO;
        
        _SC.contentSize = CGSizeMake(3*(height+15), height+12);
        for (int i = 0; i < imgs.count; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i*(height+15), 12, height, height)];
            if ([imgs[i] isKindOfClass:[UIImage class]]) {
                img.image = imgs[i];
            }else {
                [img sd_setImageWithURL:[NSURL URLWithString:imgs[i]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            }
            
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            img.userInteractionEnabled = YES;
            [_SC addSubview:img];
            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//            [btn setBackgroundImage:imgs[i] forState:UIControlStateNormal];
//            btn.frame = CGRectMake(i*(height+15), 12, height, height);
//            btn.contentMode = UIViewContentModeScaleAspectFill;
//            btn.clipsToBounds = YES;
//            [_SC addSubview:btn];
            
            UIButton *deBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deBtn.tag = 200+i;
            [deBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
            [deBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            deBtn.frame = CGRectMake(img.x+img.width-12, 0, 24, 24);
            [_SC addSubview:deBtn];
        }
    }else{
        _selectBtn.hidden = NO;
        _SC.contentSize = CGSizeMake((imgs.count+1)*(height+15)-15, height+12);
        if (imgs.count == 0) {
            _SC.contentSize = CGSizeMake(ScreenW-30, height);
        }else{
            _SC.contentSize = CGSizeMake((imgs.count+1)*(height+15)-15, height+12);
        }
        for (int i = 0; i < imgs.count; i++) {
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(i*(height+15), 12, height, height)];
            if ([imgs[i] isKindOfClass:[UIImage class]]) {
                img.image = imgs[i];
            }else {
                [img sd_setImageWithURL:[NSURL URLWithString:imgs[i]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
            }
            img.userInteractionEnabled = YES;
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            [_SC addSubview:img];
            
            UIButton *deBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            deBtn.tag = 200+i;
            [deBtn setBackgroundImage:[UIImage imageNamed:@"cha"] forState:UIControlStateNormal];
            [deBtn addTarget:self action:@selector(imgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            deBtn.frame = CGRectMake(img.x+img.width-12, 0, 24, 24);
            [_SC addSubview:deBtn];
        }
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(imgs.count*(height+15), 12, height, height);
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"zk_addpic"] forState:UIControlStateNormal];
        [_SC addSubview:_selectBtn];
//        _selectBtn.frame = CGRectMake(imgs.count*(height+15), 12, height, height);
    }
}

- (void)imgBtnClick:(UIButton *)sender{
    [self.delegate deleImgAtIndex:sender.tag-200];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
