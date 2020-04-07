//
//  LQ_PostTextView.m
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/28.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import "LQ_PostTextView.h"

@implementation LQ_PostTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 行间距
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5;
        // attributes
        NSDictionary *textAttributes = @{
                                         NSParagraphStyleAttributeName:style,
                                         NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                         };
        
        self.backgroundColor = [UIColor whiteColor];
        // self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.textColor = [UIColor blackColor];
        self.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8);
        self.typingAttributes = textAttributes;
        
        self.placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel.textColor = [UIColor colorWithRed:102/255 green:102/255 blue:102/255 alpha:0.5];
        self.placeholderLabel.font = [UIFont systemFontOfSize:15.f];
        self.placeholderLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.placeholderLabel];
        
        [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(8);
            make.left.mas_offset(13);
        }];
    }
    return self;
}

- (void)setBarType:(PostBarType)barType {
    _barType = barType;
    
    if (_barType == PostBarCurtain) {
        self.placeholderLabel.text = @"说点什么";
    } else {
        self.layer.borderColor = [UIColor colorWithRed:240/255 green:240/255 blue:240/255 alpha:0.1].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
}

- (void)setIsOnSwitch:(BOOL)isOnSwitch {
    NSString *offStr = @"说点什么";
    NSString *onStr = @"已开启弹幕评论";
    self.placeholderLabel.text = isOnSwitch == YES ? onStr : offStr;
}

- (void)setUserNick:(NSString *)userNick {
    _userNick = userNick;
    
    if (_barType == PostBarAwaken) {
        self.text = [NSString stringWithFormat:@"@%@：",_userNick];
    }
}

@end
