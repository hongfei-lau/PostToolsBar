//
//  LQ_PostTextView.h
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/28.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQ_PostToolsDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQ_PostTextView : UITextView

/// 键盘类型 
@property (nonatomic, assign) PostBarType barType;
/// 弹幕开关
@property (nonatomic, assign) BOOL isOnSwitch;
/// @用户的数据
@property (nonatomic, copy) NSString *userNick;

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

NS_ASSUME_NONNULL_END
