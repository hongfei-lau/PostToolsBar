//
//  LQ_PostToolsDefines.h
//  LQ_PostToolsBar
//
//  Created by liuhongfei on 2019/11/28.
//  Copyright © 2019 BeiJing BoRuiSiYuan Network Technology Co., Ltd. All rights reserved.
//

#ifndef LQ_PostToolsDefines_h
#define LQ_PostToolsDefines_h

#import <Foundation/Foundation.h>
#import <Masonry.h>

#define LQScreenW ([UIScreen mainScreen].bounds.size.width)
#define LQScreenH ([UIScreen mainScreen].bounds.size.height)

#define IPhoneX                (CGSizeEqualToSize(CGSizeMake(375.f, 812.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(812.f, 375.f), [UIScreen mainScreen].bounds.size)) || (CGSizeEqualToSize(CGSizeMake(414.f, 896.f), [UIScreen mainScreen].bounds.size) || CGSizeEqualToSize(CGSizeMake(896.f, 414.f), [UIScreen mainScreen].bounds.size))

// 竖屏 直播公告额外的高度
#define ExternalH  50

/**
 *  键盘类型 
 */
typedef NS_ENUM(NSUInteger, PostBarType) {
    PostBarCurtain = 1,           // 弹幕
    PostBarAwaken = 2,            // @用户
    PostBarNotice = 3,            // 公告消息
};

/**
 *  横竖屏类型
 */
typedef NS_ENUM(NSUInteger, PostBuboType) {
    PostBuboV = 1,            // 竖屏
    PostBuboH = 2,            // 横屏
};

#endif /* LQ_PostToolsDefines_h */
