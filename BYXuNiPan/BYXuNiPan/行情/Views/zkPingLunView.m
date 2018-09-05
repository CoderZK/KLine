//
//  zkPingLunView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPingLunView.h"

@interface zkPingLunView()<UITextViewDelegate>
@property(nonatomic,strong)UIView *whiteV;
@end

@implementation zkPingLunView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 , ScreenW, 150)];
        self.whiteV.backgroundColor = WhiteColor;
        self.TextV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 8, ScreenW - 16, 134)];
        self.TextV.font = kFont(14);
        self.TextV.placeholder = @"请输入评论";
        self.TextV.delegate = self;
        self.TextV.returnKeyType = UIReturnKeySend;
        [self.whiteV addSubview:self.TextV];
        [self addSubview:self.whiteV];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];

            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

//键盘将要出现
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    NSLog(@"键盘即将出现");
    NSValue *value = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];//使用UIKeyboardFrameBeginUserInfoKey,会出现切换输入法时获取的搜狗键盘不对.
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    NSLog(@"键盘高度:%f", keyboardH);
    CGFloat aa = keyboardH + 150;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.whiteV.mj_y = ScreenH - 150 - keyboardH;
    }];
    
//    self.whiteV.transform = CGAffineTransformMakeTranslation(0, -keyboardH);
}

//键盘将要隐藏
- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    [self diss];
}



#pragma mark ====== 点击发送按钮 ======
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //判断输入的字是否是回车，即按下return
    if ([text isEqualToString:@"\n"]){
        if (self.delegate && [self.delegate respondsToSelector:@selector(textViewContentText:)]) {
            [self.delegate textViewContentText:textView.text];
        }
        textView.text = @"";
        /*这里返回NO，就代表return键值失效，即页面上按下return，
         不会出现换行，如果为yes，则输入页面会换行*/
        return NO;
    }else {
       
    }
    return YES;
}

- (void)show {
 
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    } completion:^(BOOL finished) {
           [self.TextV becomeFirstResponder];
    }];
}



- (void)diss {
    [self.TextV resignFirstResponder];
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
        self.whiteV.mj_y = ScreenH;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    NSNotification * notification = [[NSNotification alloc] initWithName:@"kaishi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self];
    if (point.y < ScreenH - self.whiteV.mj_h) {
        [self diss];
    }
    
    
}
    



@end
