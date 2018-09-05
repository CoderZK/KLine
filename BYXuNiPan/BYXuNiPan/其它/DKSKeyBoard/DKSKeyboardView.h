//
//  DKSKeyboardView.h
//  DKSChatKeyboard
//
//  Created by aDu on 2017/9/6.
//  Copyright © 2017年 DuKaiShun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKSTextView.h"
@protocol DKSKeyboardDelegate <NSObject>

@optional //非必实现的方法

/**
 点击发送时输入框内的文案

 @param textStr 文案
 */
- (void)textViewContentText:(NSString *)textStr;
- (void)didClickRightBt:(UIButton *)button;
/**
 键盘的frame改变
 */
- (void)keyboardChangeFrameWithMinY:(CGFloat)minY;

@end

@interface DKSKeyboardView : UIView <UITextViewDelegate>

@property (nonatomic, weak) id <DKSKeyboardDelegate>delegate;

/**  */
@property(nonatomic , strong)NSString *placehodleStr;
//是否带图片右侧的图片 0 不带 1 带图
@property(nonatomic,assign)NSInteger tyep;
@property(nonatomic,strong)UIImage *nomalImage;
@property(nonatomic,strong)UIImage *selectImage;
@property (nonatomic, strong) UIButton *moreBtn;
@property (nonatomic, strong) DKSTextView *textView;

@end
