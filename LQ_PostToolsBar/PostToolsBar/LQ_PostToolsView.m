//
//  LQ_PostToolsView.m
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/27.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import "LQ_PostToolsView.h"
#import "LQ_PostToolsBar.h"
#import "LQ_PostTextView.h"

@interface LQ_PostToolsView () <UITextViewDelegate>

@property (nonatomic, strong) LQ_PostToolsBar *toolsBar;
@property (nonatomic, strong) LQ_PostTextView *textView;

// 横竖屏 默认竖屏
@property (nonatomic, assign) PostBuboType postBubo;
// 键盘上部ToolBar 原始高度
@property (nonatomic, assign) CGFloat originH;

@end

@implementation LQ_PostToolsView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 外部配置
    [self setupConfigs];
    // 创建UI
    [self setupUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:self.textView];
    UITapGestureRecognizer *gestap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissToolbar)];
    [self.view addGestureRecognizer:gestap];
}

- (void)viewLayoutMarginsDidChange {
    [super viewLayoutMarginsDidChange];
    
    // 横竖屏 判断
    self.postBubo = (LQScreenW > LQScreenH) ? PostBuboH : PostBuboV;
    
    if (self.barType == PostBarNotice && self.postBubo == PostBuboV) {
        self.toolBarHeight = self.toolBarHeight == 0 ? 50 + ExternalH : self.originH + ExternalH;
    } else {
        self.toolBarHeight = self.originH;
        self.toolBarHeight = self.toolBarHeight == 0 ? 50 : self.toolBarHeight;
    }
    [self textViewLayout];
    
    self.toolsBar.postBubo = self.postBubo;
    self.toolsBar.barType = self.barType;
}

- (void)textViewLayout {
    if (self.postBubo == PostBuboV) { /// 竖屏
        if (self.barType == PostBarNotice) { // 公告消息
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.left.mas_offset(15);
                make.right.mas_offset(-80);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        } else if (self.barType == PostBarAwaken) { // @用户
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.left.mas_offset(15);
                make.right.mas_offset(-80);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        } else  { // 弹幕
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.left.mas_offset(70);
                make.right.mas_offset(-80);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        }
    } else { /// 横屏
        if (self.barType == PostBarNotice) { // 公告消息
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.right.mas_offset(-80);
                make.width.mas_offset(LQScreenW / 2 - 80);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        } else if (self.barType == PostBarAwaken) { // @用户
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.left.mas_offset((IPhoneX ? 30 : 0) + 15);
                make.width.mas_offset(LQScreenW - 80 - 50);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        } else { // 弹幕
            [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.toolsBar).offset(-6);
                make.left.mas_offset((IPhoneX ? 44 : 0) + 15 + 50);
                make.width.mas_offset(LQScreenW - 80 - 30 - 100);
                make.height.mas_offset(self.originH - 12 - 0.5);
            }];
        }
    }
}

#pragma mark - Configuration
- (void)setupConfigs {
    self.originH = self.toolBarHeight == 0 ? 50 : self.toolBarHeight;
    self.view.backgroundColor = self.BGColor;
    self.barType = self.barType == 0 ? PostBarCurtain : self.barType;
}

#pragma mark - Intial Methods
- (void)setupUI {
    self.toolsBar = [[LQ_PostToolsBar alloc] initWithFrame:CGRectMake(0, LQScreenH, LQScreenW, self.toolBarHeight)];
    
    __weak typeof(self)weakSelf = self;
    
    self.toolsBar.changeStateBlock = ^(BOOL isOn) {
        weakSelf.textView.isOnSwitch = isOn;
    };
    
    self.toolsBar.postTextBlock = ^{
        if (weakSelf.postTextBlock) {
            weakSelf.postTextBlock(weakSelf.textView.text);
        }
    };
    
    self.toolsBar.deleteNoticeBlock = ^{
        if (weakSelf.deleteNoticeBlock) {
            weakSelf.deleteNoticeBlock();
        }
    };
    
    [self.view addSubview:self.toolsBar];
    
    self.textView = [[LQ_PostTextView alloc] initWithFrame:CGRectMake(0, LQScreenH, LQScreenW, self.toolBarHeight)];
    self.textView.barType = self.barType;
    self.textView.userNick = self.userNick;
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

#pragma mark - UITextViewDelegate
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    NSDictionary *userInfo = [note userInfo];
    
    // 获取动画的执行时间
    CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationOptions options = ([[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16 ) | UIViewAnimationOptionBeginFromCurrentState;
    
    // 获取键盘最终Y值
    CGRect endFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 计算工具栏距离底部的间距
    CGFloat margin = 0;
    if (endFrame.origin.y == [[UIScreen mainScreen] bounds].size.height) {
        // 弹下
        margin = endFrame.origin.y;
    } else {
        margin = endFrame.origin.y - self.toolBarHeight;
    }

    // 执行动画
    [self.toolsBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(margin);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(self.toolBarHeight);
    }];
    [self textViewLayout];
    
    [UIView animateWithDuration:duration delay:0.0f options:options animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)textViewDidChange:(UITextView *)textView {
    // 动态计算键盘输入的高度 预留处理入口
    self.toolsBar.sendButton.userInteractionEnabled = self.textView.text.length > 0 ?YES : NO;
    // 删除到昵称时，清空@用户数据
    if (self.barType == PostBarAwaken) {
        if (![self.textView.text containsString:[NSString stringWithFormat:@"@%@：",self.userNick]]) {
            self.textView.text = [NSString stringWithFormat:@"@%@：",self.userNick];
        }
    }
    
    // 输入框有问题输入时，清空占位
    if (self.textView.text.length > 0) {
        self.textView.placeholderLabel.hidden = YES;
    } else {
        self.textView.placeholderLabel.hidden = NO;
    }
}

/// 收回键盘
- (void)dissmissToolbar {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView resignFirstResponder];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

@end
