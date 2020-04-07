//
//  LQ_PostToolsView.h
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/27.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQ_PostToolsDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface LQ_PostToolsView : UIViewController

/// 键盘类型 非必传 默认为 弹幕消息
@property (nonatomic, assign) PostBarType barType;
/// 遮罩颜色(必须为带透明度的颜色值，否则不显示底部视图)
@property (nonatomic, strong) UIColor *BGColor;
/// 键盘上部ToolBar高度 默认为50
@property (nonatomic, assign) CGFloat toolBarHeight;
/// @用户的数据 @用户时为必传
@property (nonatomic, copy) NSString *userNick;

// 评论文本
@property (nonatomic, copy) void (^postTextBlock)(NSString *commentText);
// 删除公告
@property (nonatomic, copy) void (^deleteNoticeBlock)(void);

@end

NS_ASSUME_NONNULL_END
