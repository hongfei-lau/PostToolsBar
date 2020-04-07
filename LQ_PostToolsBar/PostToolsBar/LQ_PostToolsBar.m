//
//  LQ_PostToolsBar.m
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/27.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import "LQ_PostToolsBar.h"
#import "XYSwitch.h"

@interface LQ_PostToolsBar ()

// 公告
@property (nonatomic, strong) UIView *noticeBaseView;
@property (nonatomic, strong) UILabel *noticeLabel;
@property (nonatomic, strong) UIButton *noticeR_Button;

// 弹幕
@property (nonatomic, strong) XYSwitch *mySwitch;

@end

@implementation LQ_PostToolsBar

/// 自定义构造方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    [self addSubview:lineView];
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(0.5);
    }];
    
    self.noticeBaseView = [[UIView alloc] init];
    self.noticeBaseView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.noticeBaseView];
    
    // 直播公告
    self.noticeR_Button = [[UIButton alloc] init];
    [self.noticeR_Button setTitle:@"删除直播公告" forState:UIControlStateNormal];
    [self.noticeR_Button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    self.noticeR_Button.titleLabel.font = [UIFont systemFontOfSize:13.f];
    self.noticeR_Button.layer.borderColor = [UIColor orangeColor].CGColor;
    self.noticeR_Button.layer.borderWidth = 0.3;
    self.noticeR_Button.layer.cornerRadius = 15;
    self.noticeR_Button.layer.masksToBounds = YES;
    [self.noticeR_Button addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.noticeBaseView addSubview:self.noticeR_Button];
    
    self.noticeLabel = [[UILabel alloc] init];
    self.noticeLabel.text = @"直播公告（每分钟循环显示1次）";
    self.noticeLabel.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:1];
    self.noticeLabel.font = [UIFont systemFontOfSize:12.f];
    self.noticeLabel.textAlignment = NSTextAlignmentLeft;
    [self.noticeBaseView addSubview:self.noticeLabel];
    
    // 弹幕
    self.mySwitch = [[XYSwitch alloc] initWithTextFont:[UIFont boldSystemFontOfSize:15] OnText:@"弹" offText:@"弹" onBackGroundColor:[UIColor orangeColor] offBackGroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] onButtonColor:nil offButtonColor:nil onTextColor:[UIColor orangeColor] andOffTextColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    
    __weak typeof(self)weakSelf = self;
    
    self.mySwitch.changeStateBlock = ^(BOOL isOn) {
        if (weakSelf.changeStateBlock) {
            weakSelf.changeStateBlock(isOn);
        }
    };
    
    [self addSubview:self.mySwitch];
    
    self.sendButton = [[UIButton alloc] init];
    self.sendButton.userInteractionEnabled = NO;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self.sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
    self.sendButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.sendButton.layer.borderWidth = 0.3;
    self.sendButton.layer.cornerRadius = 5;
    self.sendButton.layer.masksToBounds = YES;
    [self.sendButton addTarget:self action:@selector(sendButtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sendButton];
}

- (void)setPostBubo:(PostBuboType)postBubo {
    _postBubo = postBubo;
}

- (void)setBarType:(PostBarType)barType {
    _barType = barType;
    
    [self updateLayout];
}

- (void)updateLayout {
    if (self.postBubo == PostBuboH) {
        [self.noticeBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(IPhoneX ? 44 : 0);
            make.top.equalTo(self);
            make.width.mas_offset(IPhoneX ? LQScreenW / 2 - 44 : LQScreenW / 2);
            make.height.mas_offset(self.barType == PostBarNotice ? ExternalH : 0);
        }];
        
        if (_barType == PostBarCurtain) {
            [self.mySwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15 + (IPhoneX ? 30 : 0));
                make.centerY.equalTo(self);
                make.size.mas_offset(CGSizeMake(50, 30));
            }];
        }
    } else {
        [self.noticeBaseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_offset(self.barType == PostBarNotice ? ExternalH : 0);
        }];
        
        if (_barType == PostBarCurtain) {
            [self.mySwitch mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(15);
                make.centerY.equalTo(self);
                make.size.mas_offset(CGSizeMake(50, 30));
            }];
        }
    }
    
    [self.noticeR_Button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.equalTo(self.noticeBaseView);
        make.size.mas_offset(self.barType == PostBarNotice ? CGSizeMake(100, 30) : CGSizeMake(0, 0));
    }];
    
    [self.noticeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.bottom.equalTo(self.noticeBaseView);
        make.right.equalTo(self.noticeR_Button.mas_left).offset(-10);
    }];
    
    [self.sendButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.postBubo == PostBuboV ? self.noticeBaseView.mas_bottom : self).offset(10);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
}

- (void)sendButtnClick {
    if (self.postTextBlock) {
        self.postTextBlock();
    }
}

- (void)deleteButtonClick {
    if (self.deleteNoticeBlock) {
        self.deleteNoticeBlock();
    }
}

@end
