//
//  zkPingLunWaiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPingLunWaiCell.h"
#import "zkAttributedLableCell.h"
@interface zkPingLunWaiCell ()<UITableViewDelegate,UITableViewDataSource,TYAttributedLabelDelegate>
@property(nonatomic,strong)UIButton *zanBt,*pingBt,*jieXiaoBt,*moreContentBt,*morePingLunBt;
@property(nonatomic,strong)UILabel *nameLB,*contentLB,*timeLB;
@property(nonatomic,strong)UIView *zanView ,* pingAndZanV,*picsView,*lineV;
@property(nonatomic,strong)UITableView *tabelView;
@property(nonatomic,strong)UIView *grayV,*xiaDanV;
@property(nonatomic,strong)NSArray *textContainers;
@end
@implementation zkPingLunWaiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        [self addSubview:self.headBt];
     
        self.nameLB =[[UILabel alloc] initWithFrame:CGRectMake(70, 20 , 120, 20)];
        self.nameLB.text = @"大牛666";
        self.nameLB.font =[UIFont systemFontOfSize:14];
        self.nameLB.textColor = OrangeColor;
        [self addSubview:self.nameLB];

        self.timeLB =[[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 120-15, 20 , 120, 20)];
        self.timeLB.text = @"19:07";
        self.timeLB.textAlignment = NSTextAlignmentRight;
        self.timeLB.font =[UIFont systemFontOfSize:13];
        self.timeLB.textColor = CharacterGrayColor102;
        [self addSubview:self.timeLB];
        
        
        //下单的view
        self.xiaDanV = [[UIView alloc] initWithFrame:CGRectMake(70, 50, ScreenW - 85 , 64)];
        UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
        right2.frame = CGRectMake(ScreenW - 85 - 60, 0, 60, 25);
        right2.backgroundColor = BlueColor;
        [right2 setTitle:@"下单" forState:UIControlStateNormal];
        right2.titleLabel.font = kFont(14);
        right2.layer.shadowOffset = CGSizeMake(1, 2);
        right2.layer.shadowColor = BlueColor.CGColor;
        right2.layer.shadowOpacity = 0.8;
        [right2 addTarget:self action:@selector(xianDan) forControlEvents:UIControlEventTouchUpInside];
        [self.xiaDanV addSubview:right2];
        right2.userInteractionEnabled = NO;
        for (int i = 0; i < 3; i++) {
            
            UILabel * lllb =[[UILabel alloc] initWithFrame:CGRectMake(0, i * (18 +5) , ScreenW - 85 - 60, 18)];
            lllb.font =[UIFont systemFontOfSize:14];
            lllb.text = @"";
            lllb.tag = 100+i;
            lllb.textColor = CharacterBlackColor30;
            [self.xiaDanV addSubview:lllb];

            
        }
        [self addSubview:self.xiaDanV];
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(70, 50, ScreenW - 85, 20)];
        self.contentLB.numberOfLines = 10;
        [self addSubview:self.contentLB];
        
        self.moreContentBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.moreContentBt.frame = CGRectMake(70, CGRectGetMaxY(self.contentLB.frame) , 60, 30);
        [self.moreContentBt setTitle:@"查看原文" forState:UIControlStateNormal];
        [self.moreContentBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.moreContentBt.titleLabel.font = kFont(14);
        self.moreContentBt.userInteractionEnabled = NO;
        [self.moreContentBt sizeToFit];
        [self addSubview:self.moreContentBt];
        
        self.picsView = [[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.moreContentBt.frame), ScreenW - 85, 20)];
        
        for (int i = 0 ; i < 9 ; i ++) {
            
            UIImageView * imageView= [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成N O表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.picsView addSubview:imageView];
        }
    
        [self addSubview:self.picsView];
        self.pingAndZanV = [[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.xiaDanV.frame)+5, ScreenW - 85, 25)];
        [self addSubview:self.pingAndZanV];
        
        self.zanBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.zanBt.frame = CGRectMake(0, 0 , 60, 25);
        [self.zanBt setImage:[UIImage imageNamed:@"praise_n"] forState:UIControlStateNormal];
        [self.zanBt setImage:[UIImage imageNamed:@"praise_p"] forState:UIControlStateSelected];
        [self.zanBt setTitle:@"785" forState:UIControlStateNormal];
        [self.zanBt setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [self.zanBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
        self.zanBt.tag = 999;
        [self.zanBt addTarget:self action:@selector(zanClickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.zanBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.zanBt.titleLabel.font = kFont(13);
        [self.zanBt sizeToFit];
        self.zanBt.height = 25;
        [self.pingAndZanV addSubview:self.zanBt];
        
        //评论和赞
        self.pingBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.pingBt.frame = CGRectMake(CGRectGetMaxX(self.zanBt.frame) + 15 , 0 , 60, 25);
        [self.pingBt setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
        [self.pingBt setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateSelected];
        [self.pingBt setTitle:@"453" forState:UIControlStateNormal];
        [self.pingBt setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [self.pingBt setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
        self.pingBt.titleLabel.font = kFont(13);
        self.pingBt.userInteractionEnabled = NO;
        [self.pingBt sizeToFit];
        self.pingBt.height = 25;
        [self.pingAndZanV addSubview:self.pingBt];
        
        self.jieXiaoBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.jieXiaoBt.frame = CGRectMake(ScreenW - 85 - 120 , 0 ,120, 25);
        [self.jieXiaoBt setImage:[UIImage imageNamed:@"jiexiao"] forState:UIControlStateNormal];
        [self.jieXiaoBt setImage:[UIImage imageNamed:@"jiexiao"] forState:UIControlStateSelected];
        [self.jieXiaoBt setTitle:@"363" forState:UIControlStateNormal];
        [self.jieXiaoBt setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [self.jieXiaoBt setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        self.jieXiaoBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.jieXiaoBt.titleLabel.font = kFont(13);
        [self.pingAndZanV addSubview:self.jieXiaoBt];
        
        //点赞的人群
        self.zanView =[[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.pingAndZanV.frame)+5, ScreenW - 85, 0)];
        [self addSubview:self.zanView];
        //评论的人群
        self.grayV = [[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.zanView.frame) + 10 , ScreenW - 85, 0.1)];
        self.grayV.backgroundColor = RGB(250, 250, 250);
        [self addSubview:self.grayV];
        self.tabelView = [[UITableView alloc] initWithFrame:CGRectMake(5, 5 , ScreenW - 95 , 0.1)];
        self.tabelView.dataSource = self;
        self.tabelView.delegate = self;
        [self.tabelView registerClass:[zkAttributedLableCell class] forCellReuseIdentifier:@"cell"];
        self.tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tabelView.backgroundColor = [UIColor clearColor];
        [self.grayV addSubview:self.tabelView];
        
        
        self.morePingLunBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.morePingLunBt.frame = CGRectMake(70, CGRectGetMaxY(self.grayV.frame) , ScreenW - 85 , 30);
        [self.morePingLunBt setTitle:@"查看更多>" forState:UIControlStateNormal];
        [self.morePingLunBt setTitleColor:OrangeColor forState:UIControlStateNormal];
        self.morePingLunBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.morePingLunBt.titleLabel.font = kFont(13);
        [self.morePingLunBt sizeToFit];
        self.morePingLunBt.userInteractionEnabled = NO;
        [self addSubview:self.morePingLunBt];
        
        self.lineV =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.morePingLunBt.frame), ScreenW - 30, 0.6)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];
        
    }
    return self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.textContainers.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TYTextContainer *textContaner = _textContainers[indexPath.row];
    return textContaner.textHeight + 3;// after createTextContainer, have value
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkAttributedLableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = RGB(250, 250, 250);
    cell.label.backgroundColor = RGB(250, 250, 250);
    // Configure the cell...
    cell.label.delegate = self;
    cell.label.textContainer = _textContainers[indexPath.row];
    if ([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row) {
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.tabelView.frame = CGRectMake(self.tabelView.frame.origin.x,self.tabelView.frame.origin.y,ScreenW - 95, tableView.contentSize.height);
//            self.grayV.mj_h = self.tabelView.contentSize.height + 7;
//            self.morePingLunBt.mj_y = CGRectGetMaxY(self.grayV.frame);
//            self.lineV.mj_y = CGRectGetMaxY(self.morePingLunBt.frame);
//            self.model.cellHeight = CGRectGetMaxY(self.lineV.frame);
            
        });
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate didClickPingLunTableView:self indexPath:indexPath];
    }
    
}


#pragma mark - TYAttributedLabelDelegate

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)TextRun atPoint:(CGPoint)point
{
    NSLog(@"textStorageClickedAtPoint");
    if ([TextRun isKindOfClass:[TYLinkTextStorage class]]) {
        
        id linkStr = ((TYLinkTextStorage*)TextRun).linkData;
        if (self.isNeiPingLun) {
            BOOL isFirestName = NO;
            if ([[NSString stringWithFormat:@"%@",linkStr] isEqualToString:self.model.createByNickName]) {
                isFirestName = YES;
            }else {
                isFirestName = NO;
            }
            zkAttributedLableCell * cell = (zkAttributedLableCell *)[attributedLabel superview];
            NSIndexPath *indexPath = [self.tabelView indexPathForCell:cell];
            if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickPingLunView:indexPath:isFirstName:)]) {
                [self.delegate didClickPingLunView:self indexPath:indexPath isFirstName:isFirestName];
            }
            
        }
        
        
        
//        if ([linkStr isKindOfClass:[NSString class]]) {
//            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:linkStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//            [alertView show];
//        }
    }else if ([TextRun isKindOfClass:[TYImageStorage class]]) {
        TYImageStorage *imageStorage = (TYImageStorage *)TextRun;
        
        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:[NSString stringWithFormat:@"你点击了%@图片",imageStorage.imageName] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//        [alertView show];
    }
}



//是这评论
- (void)setDataArr:(NSArray *)dataArr {
    
    if (dataArr.count == 0) {
        self.grayV.mj_h = 0;
        self.morePingLunBt.hidden = YES;
        self.textContainers = @[];
        [self.tabelView reloadData];
        return;
    }
    
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0 ; i<dataArr.count; i++) {
        
      [tmp addObject: [self creatTextContainer:dataArr[i]]];
        
    }
    
    self.textContainers = [tmp copy];
    [self.tabelView reloadData];
    
}

- (TYTextContainer *)creatTextContainer:(zkHomelModel *)model
{
    NSString *text = @"";
    if (model.replyToNickName.length == 0 ) {
        text = [NSString stringWithFormat:@"%@: %@",model.createByNickName,model.content];
    }else {
       text = [NSString stringWithFormat:@"%@回复%@%@",model.createByNickName,model.replyToNickName,model.content];
    }
    
    // 属性文本生成器
    TYTextContainer *textContainer = [[TYTextContainer alloc]init];
    textContainer.text = text;
    textContainer.font = [UIFont systemFontOfSize:12];
    textContainer.numberOfLines = 0;
    textContainer.lineBreakMode = NSLineBreakByTruncatingTail;
//    NSMutableArray *tmpArray = [NSMutableArray array];
    
//    // 正则匹配图片信息
//    [text enumerateStringsMatchedByRegex:@"\\[(\\w+?),(\\d+?),(\\d+?)\\]" usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
//
//        if (captureCount > 3) {
//            // 图片信息储存
//            TYImageStorage *imageStorage = [[TYImageStorage alloc]init];
//            imageStorage.cacheImageOnMemory = YES;
//            imageStorage.imageName = capturedStrings[1];
//            imageStorage.range = capturedRanges[0];
//            imageStorage.size = CGSizeMake([capturedStrings[2]intValue], [capturedStrings[3]intValue]);
//
//            [tmpArray addObject:imageStorage];
//        }
//    }];
    
    // 添加图片信息数组到label
//    [textContainer addTextStorageArray:tmpArray];
    if ([model.createByNickName isEqualToString:self.model.createByNickName]) {
         [textContainer addLinkWithLinkData:model.createByNickName linkColor:OrangeColor underLineStyle:kCTUnderlineStyleNone range:[text rangeOfString:model.createByNickName]];
    }else {
         [textContainer addLinkWithLinkData:model.createByNickName linkColor:YellowColor underLineStyle:kCTUnderlineStyleNone range:[text rangeOfString:model.createByNickName]];
    }
   
    
    [textContainer addLinkWithLinkData:model.replyToNickName linkColor:YellowColor underLineStyle:kCTUnderlineStyleNone range:NSMakeRange(model.createByNickName.length + 2, model.replyToNickName.length)];
    
//    TYTextStorage *textStorage = [[TYTextStorage alloc]init];
//    textStorage.range = [text rangeOfString:model.createByNickName];
//    if ([self.model.createBy isEqualToString:model.createBy]) {
//        //是铁柱回复
//        textStorage.textColor = OrangeColor;
//    }else {
//        textStorage.textColor = YellowColor;
//    }
//    textStorage.font = [UIFont systemFontOfSize:12];
//    [textContainer addTextStorage:textStorage];
//
//
//    textStorage = [[TYTextStorage alloc]init];
//    textStorage.range = [text rangeOfString:model.replyToNickName];
//    textStorage.textColor = YellowColor;
//    textStorage.font = [UIFont systemFontOfSize:12];
//    [textContainer addTextStorage:textStorage];
    
    //    textStorage = [[TYTextStorage alloc]init];
    //    textStorage.range = [text rangeOfString:@"@青春励志"];
    //    textStorage.textColor = RGB(255, 155, 0, 1);
    //    textStorage.font = [UIFont systemFontOfSize:18];
    //    [textContainer addTextStorage:textStorage];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.layer.cornerRadius = 2;
//    [button setBackgroundColor:[UIColor redColor]];
//    button.titleLabel.font = [UIFont systemFontOfSize:12];
//    [button setTitle:@"UIButton" forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    button.frame = CGRectMake(0, 0, 60, 15);
//    [textContainer addView:button range:[text rangeOfString:@"[button]"]];
    textContainer.linesSpacing = 0;
    textContainer = [textContainer createTextContainerWithTextWidth:CGRectGetWidth(self.grayV.frame) - 10];
    return textContainer;
}


#pragma mark - action

- (void)buttonClicked:(UIButton *)button
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"点击提示" message:@"我是UIButton哦" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
   
    
}

//图片的设定
- (void)setImgViews:(NSArray *)arr {
//    arr = @[@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png",@"http://img.zcool.cn/community/0117e2571b8b246ac72538120dd8a4.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = arr.count; i < 9; i++) {
            UIImageView * imgV = [self.picsView viewWithTag:100+i];
            imgV.hidden = YES;
        }
    });

    if (arr.count == 0 || self.isNeiPingLun) {
        self.picsView.mj_h = 0;
        return;
    }
  
    CGFloat space = 8;
    CGFloat ww = (ScreenW - 85 - 20) / 3;
    CGFloat hh = 0;
    for (int i = 0 ; i < arr.count; i++) {
        UIImageView * imgV = [self.picsView viewWithTag:100+i];
        imgV.hidden = NO;
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        if (arr.count == 1) {
            //一张图片的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = 0;
            imgV.mj_y = 0;
            hh = ww;
            
        }else if (arr.count == 4) {
            //四张的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 2);
            imgV.y = (ww + space) * (i / 2);
            hh = CGRectGetMaxY(imgV.frame);
            
        }else {
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 3);
            imgV.y = (ww + space) * (i / 3);
            hh = CGRectGetMaxY(imgV.frame);
        }
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    }
    self.picsView.mj_h = hh;

}

//设置点赞人数
- (void)setZanRenYuan:(NSArray *)arr {
    
    [self.zanView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (arr.count == 0 || self.isNeiPingLun) {
        self.zanView.mj_h = 0;
        return;
    }
    CGFloat ww = 0;
    CGFloat yy = 0;
    NSInteger lines = 1;
    for (int i = 0 ; i < arr.count; i++) {
        if (lines > 2) {
            break;
        }
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.mj_x = ww;
        button.mj_y = yy;
        button.tag = i+1000;
        [button addTarget:self action:@selector(zanClickAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i+1 == arr.count) {
            [button setTitle:[NSString stringWithFormat:@"%@",arr[i]] forState:UIControlStateNormal];
        }else {
          [button setTitle:[NSString stringWithFormat:@"%@、",arr[i]] forState:UIControlStateNormal];
        }
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:YellowColor forState:UIControlStateNormal];
        if (i == 0) {
            [button setImage:[UIImage imageNamed:@"praise_p"] forState:UIControlStateNormal];
        }
        [button sizeToFit];
        button.mj_h = 20;
        ww = ww + button.width;
        if (ww > ScreenW - 85 && lines == 2) {
            break;
        }else if (ww > ScreenW - 85 ){
            button.mj_x = 0;
            button.mj_y = 20;
            yy = 20;
            button.mj_h = button.mj_h ;
            ww = button.width;
            lines = lines + 1;
            
        }
        
        [self.zanView addSubview:button];
        self.zanView.mj_h = 20*lines;
    }

}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setModel:(zkHomelModel *)model {
    
    _model = model;
    if(self.isNeiPingLun) {
        self.pingBt.hidden = YES;
        self.tabelView.userInteractionEnabled = YES;
    }else {
        self.tabelView.userInteractionEnabled = NO;
        self.pingBt.hidden = NO;
    }
    
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.nameLB.text = model.createByNickName;
    self.timeLB.text = [NSString stringWithTime:model.createDate];
    
    NSString * str = model.content;
    //        self.contentLB.backgroundColor = [UIColor greenColor];
    CGFloat hh = [@"谁" getSizeWithMaxSize:CGSizeMake(100, 100) withFontSize:14].height;
    self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor30];
    CGFloat ch= [str getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 85];
    if (ch > hh * 10 + 3*9) {
        ch = hh * 10 + 3*9;
        self.contentLB.height = ch;
        self.moreContentBt.hidden = NO;
        self.moreContentBt.mj_h = 30;
        self.moreContentBt.mj_y = CGRectGetMaxY(self.contentLB.frame);
    }else {
        self.contentLB.height = ch;
        self.moreContentBt.hidden = YES;
        self.moreContentBt.mj_h = 0;
        self.moreContentBt.mj_y = CGRectGetMaxY(self.contentLB.frame);
    }

    if ([model.type intValue] == 1 || [model.type integerValue] == 3) {
        //帖子
        self.contentLB.hidden = NO;
        self.picsView.hidden = NO;
        self.xiaDanV.hidden = YES;
        if (model.imgList.count > 0) {
            self.picsView.hidden = NO;
            self.picsView.mj_y = CGRectGetMaxY(self.moreContentBt.frame) + 5;
            [self setImgViews:model.imgList];
            self.pingAndZanV.mj_y = CGRectGetMaxY(self.picsView.frame) + 5;
        }else {
            self.picsView.hidden = YES;
            self.pingAndZanV.mj_y = CGRectGetMaxY(self.moreContentBt.frame) + 5;
        }
        
    }else {
        //货币
        self.picsView.hidden = YES;
        self.xiaDanV.hidden  = NO;
        self.contentLB.hidden = YES;
        self.pingAndZanV.mj_y = CGRectGetMaxY(self.xiaDanV.frame);
        
    }
    NSString * strTwo = @"";
    if ([model.tradeType integerValue] == 0) {
        //卖出
         strTwo = [NSString stringWithFormat:@"卖出%@",model.coinName];
    }else {
        //买入
        strTwo = [NSString stringWithFormat:@"买入%@",model.coinName];
    }
    NSMutableAttributedString * att = [strTwo getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor30 textColorTwo:BlueColor nsrange:NSMakeRange(2, strTwo.length - 2)];
    UILabel * lb1 = (UILabel *)[self.xiaDanV viewWithTag:100];
    UILabel * lb12 = (UILabel *)[self.xiaDanV viewWithTag:101];
    UILabel * lb13 = (UILabel *)[self.xiaDanV viewWithTag:102];
    lb1.attributedText = att;
    lb12.text = [NSString stringWithFormat:@"成交价格 %@",model.tradePrice];
    lb13.text = [NSString stringWithFormat:@"成交价量 %@",model.tradeNum];
    
    
    [self.zanBt setTitle:model.supportCount forState:UIControlStateNormal];
    if (model.supportFlag) {
        [self.zanBt setImage:[UIImage imageNamed:@"praise_p"] forState:UIControlStateNormal];
    }else {
        [self.zanBt setImage:[UIImage imageNamed:@"praise_n"] forState:UIControlStateNormal];
    }
    [self.zanBt sizeToFit];
    self.zanBt.height = 25;
    self.pingBt.mj_x = CGRectGetMaxX(self.zanBt.frame) + 10;
    [self.pingBt setTitle:model.replyCount forState:UIControlStateNormal];
    self.zanView.mj_y = CGRectGetMaxY(self.pingAndZanV.frame);
    
    if (model.showAward) {
        CGFloat lcx = [model.lxcAward floatValue];
        NSString * str = @"";
        if (lcx > 10000) {
            str = [NSString stringWithFormat:@"%0.2f万",lcx/10000];
        }else {
            str = [NSString stringWithFormat:@"%0.3f",lcx];
        }
        [self.jieXiaoBt setTitle:str forState:UIControlStateNormal];
        
    }else {
        [self.jieXiaoBt setTitle:@"待开奖" forState:UIControlStateNormal];
    }
    
    if (model.supportNickNames.length == 0) {
         [self setZanRenYuan:@[]];
    }else {
        [self setZanRenYuan:[model.supportNickNames componentsSeparatedByString:@","]];
    }
   
    self.grayV.mj_y = CGRectGetMaxY(self.zanView.frame)+5;
    NSInteger count = 0;
//    if (self.type == 1) {
//        if (model.hotReplyList.count > 5) {
//            [self setDataArr:[model.hotReplyList subarrayWithRange:NSMakeRange(0, 5)]];
//        }else {
//            [self setDataArr:model.hotReplyList];
//        }
//        count= model.hotReplyList.count;
//    }else {
//        if (model.replyList.count > 5) {
//            [self setDataArr:[model.replyList subarrayWithRange:NSMakeRange(0, 5)]];
//        }else {
//            [self setDataArr:model.replyList];
//        }
//        count = model.replyList.count;
//    }


    if (model.replyList.count > 5) {
        [self setDataArr:[model.replyList subarrayWithRange:NSMakeRange(0, 5)]];
    }else {
        [self setDataArr:model.replyList];
    }
    count = model.replyList.count;
    
    CGFloat tableViewHieght = 0;
    for (int i = 0 ; i< self.textContainers.count; i++) {
        TYTextContainer *textContaner = _textContainers[i];
        tableViewHieght = tableViewHieght + textContaner.textHeight + 3 ;
    }
    self.tabelView.mj_h = tableViewHieght;
    self.grayV.mj_h = tableViewHieght + 7;
    if (self.textContainers.count == 0) {
        self.grayV.mj_h = 0;
        self.tabelView.mj_h = 0;
    }
    if (count > 5) {
        self.morePingLunBt.hidden = NO;
        self.morePingLunBt.mj_y = CGRectGetMaxY(self.grayV.frame);
        self.lineV.mj_y = CGRectGetMaxY(self.morePingLunBt.frame);
    }else {
        self.morePingLunBt.hidden = YES;
        self.lineV.mj_y = CGRectGetMaxY(self.grayV.frame) + 15;
    }
    model.cellHeight = CGRectGetMaxY(self.lineV.frame);
    
    NSLog(@"\n====%f=====", CGRectGetMaxY(self.lineV.frame));

    
    
}

- (void)xianDan{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickXiaDanTableView:)]) {
        [self.delegate didClickXiaDanTableView:self];
    }
    
    
}

- (void)zanClickAction :(UIButton *)button {
    
    NSLog(@"---\n%ld",button.tag);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZanRenYuanView:zanBt: index:)]) {
        
        [self.delegate didClickZanRenYuanView:self zanBt:button index:button.tag - 1000];
    }
   
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    [[zkPhotoShowVC alloc] initWithArray:self.model.imgList index:tag];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
