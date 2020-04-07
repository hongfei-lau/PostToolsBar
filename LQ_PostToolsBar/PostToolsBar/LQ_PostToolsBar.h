//
//  LQ_PostToolsBar.h
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/27.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQ_PostToolsDefines.h"

typedef void(^inputToolBarSendBlock)(BOOL isNeedBulletScreen, NSString *text);

NS_ASSUME_NONNULL_BEGIN

@interface LQ_PostToolsBar : UIView

@property (nonatomic, strong) void (^changeStateBlock)(BOOL isOn);
@property (nonatomic, copy) void (^postTextBlock)(void);
@property (nonatomic, copy) void (^deleteNoticeBlock)(void);

@property (nonatomic, assign) PostBarType barType;
@property (nonatomic, assign) PostBuboType postBubo;

// 发送按钮
@property (nonatomic, strong) UIButton *sendButton;

@end

NS_ASSUME_NONNULL_END
