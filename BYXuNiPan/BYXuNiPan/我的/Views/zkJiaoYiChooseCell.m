//
//  zkJiaoYiChooseCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkJiaoYiChooseCell.h"

@interface zkJiaoYiChooseCell()

@property(nonatomic , strong)UIView *alertView;
@property(nonatomic , strong)UIView *buttonView;
/** 注释 */
@property(nonatomic,strong)UIButton * selectBt;

@property(nonatomic,assign)NSInteger selectIndex;

/** 注释 */
@property(nonatomic,assign)BOOL isSameClick;
@end

@implementation zkJiaoYiChooseCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {


    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;
    if (self.buttonView == nil ) {
         [self setupHeaderView];
    }
   
}

- (void)setupHeaderView {
    NSArray *array = self.dataArr;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 7.5, ScreenW, 35)];
    self.buttonView = view;
    self.buttonView.backgroundColor =[UIColor whiteColor];
    [self addSubview:self.buttonView];
    
    self.alertView =[[UIView alloc] init];
    self.alertView.backgroundColor = BlueColor;
    self.alertView.height = 2;
    self.alertView.y = 35 - 3;
    for (int i = 0 ; i < array.count; i ++ ) {
        UIButton * button =[UIButton new];
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        [button setTitleColor:BlueColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        button.tag =i + 100;
        
        button.width = ScreenW / array.count;
        button.height = 35;
        button.x = i * ScreenW / array.count;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [self.buttonView addSubview:button];
        [button addTarget:self action:@selector(clickbutton:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0 ) {
            [button layoutIfNeeded];
            [button.titleLabel sizeToFit];
            button.selected = YES;
            self.selectBt = button;
            self.selectIndex = button.tag;
            self.alertView.width = button.titleLabel.width;
            self.alertView.centerX = button.centerX;
        }
        
    }
    [self.buttonView addSubview:self.alertView];
    
}

//点击上面分类按钮
- (void)clickbutton:(UIButton *)button {
    //设置当前的button 的选中状态
    
//    if (button.tag == self.selectBt.tag) {
//        self.isSameClick = YES;
//    }else {
//        self.isSameClick = NO;
//        self.selectBt.selected = NO;
//    }
    button.selected = YES;
    if (self.selectIndex == button.tag) {
        self.isSameClick = YES;
    }else {
        self.isSameClick = NO;
        UIButton * bt = (UIButton*)[self.buttonView viewWithTag:self.selectIndex];
        bt.selected = NO;
    }
    
    self.selectIndex = button.tag;
    
    [UIView animateWithDuration:0.2 animations:^{
//        [self.buttonView bringSubviewToFront:self.alertView];
        self.alertView.width = button.titleLabel.width;
        self.alertView.centerX = button.centerX;
        NSLog(@"%@",self.alertView);
    } completion:nil];
//    self.selectBt = button;
  
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickChooseView:headIndex:isSmaeClick:)]) {
        [self.delegate didClickChooseView:self headIndex:button.tag-100 isSmaeClick:self.isSameClick];
    }
    
    [self layoutIfNeeded];
    
}

//- (void)setSIndex:(NSInteger)sIndex {
//    _sIndex = sIndex;
//    UIButton * button = [self.buttonView viewWithTag:(100+sIndex)];
//    button.selected = YES;
//    if (self.selectIndex == button.tag) {
//        self.isSameClick = YES;
//    }else {
//        self.isSameClick = NO;
//        UIButton * bt = (UIButton*)[self.buttonView viewWithTag:self.selectIndex];
//        bt.selected = NO;
//    }
////    [self.buttonView bringSubviewToFront:self.alertView];
//    self.selectIndex = button.tag;
//    self.alertView.width = button.titleLabel.width;
//    self.alertView.centerX = button.centerX;
//
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
