//
//  LYScrollImgCell.h
//  ShareGoGo3
//
//  Created by 李炎 on 2017/7/13.
//  Copyright © 2017年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYDeleImgDelagate <NSObject>

- (void)deleImgAtIndex:(NSInteger)index;

@end

@interface LYScrollImgCell : UITableViewCell

@property (nonatomic)id <LYDeleImgDelagate>delegate;

/*type*/
@property (nonatomic , assign)NSInteger  type;
//
@property (nonatomic,strong)UILabel *upLab;
@property (nonatomic,strong)UILabel *downLab;

//
@property (nonatomic,strong)UIScrollView *SC;
@property (nonatomic,strong)UIButton *selectBtn;

@property (nonatomic,strong)NSMutableArray *imgs;

@property (nonatomic)BOOL isOne;

@end
