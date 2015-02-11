//
//  RHCommDef.h
//  VHReproductiveHealth
//
//  Created by lipeng on 15/2/1.
//  Copyright (c) 2015年 vichiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+CBFrameHelpers.h"
#import "ESDateHelper.h"
#import "NSDate+Helper.h"

@interface RHCommDef : NSObject

typedef void (^BlockVoid)();
typedef void (^BlockObject)(NSObject *obj);
typedef void (^BlockBool)(BOOL isBool);
typedef void (^BlockInteger)(NSInteger integer);
typedef void (^BlockString)(NSString *str);

#define WEAK_SELF __weak typeof(self) weakself = self;
#define WEAK_INSTANCE(instance) __weak typeof(instance) weak##instance = instance;

#define USER_DEFAULT_JINGQI @"rh_jingqi"
#define USER_DEFAULT_ZHOUQI @"rh_zhouqi"

/*****************************设备相关宏定义*********************************/

// 基本设备信息
#define STATUSBAR_HEIGHT        20.f
#define NAVIGATIONBAR_HEIGHT    44.f

#define DEVICE_WIDTH         ([[UIScreen mainScreen] bounds].size.width)
#define DEVICE_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_SCALE         ([UIScreen mainScreen].scale)

/*****************************使用到的字体颜色定义*****************************/

/*
 * 背景颜色
 */
#define COLOR_BG_DEF            (UIColorFromRGB(0xeeeeee))
#define COLOR_BG_DGREEN         (UIColorFromRGB(0x246E39))
#define COLOR_BG_LGREEN         (UIColorFromRGB(0xDFEDB2))
#define COLOR_BG_PINK           (UIColorFromRGB(0xFFD0De))
#define COLOR_BG_WHITE          ([UIColor whiteColor])
/*
 * 字体颜色
 */
#define COLOR_TEXT_MAIN         (UIColorFromRGB(0x5f646e))
#define COLOR_TEXT_ASSI         (UIColorFromRGB(0xaaaaaa))
#define COLOR_TEXT_DGREEN       (UIColorFromRGB(0x246E39))
#define COLOR_TEXT_LGREEN       (UIColorFromRGB(0xDFEDB2))
#define COLOR_TEXT_WHITE        ([UIColor whiteColor])
#define COLOR_TEXT_BLACK        ([UIColor blackColor])
#define COLOR_TEXT_PINK         (UIColorFromRGB(0xFF5B83))
#define COLOR_TEXT_BROWN        (UIColorFromRGB(0xA19996))

#define COLOR_DGREEN            (UIColorFromRGB(0x246E39))

#define UIColorFromRGB(rgbValue)    ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0])

/*
 * 字体
 * 18号字体：导航栏title
 * 16号字体：标题
 * 14号字体：正文
 * 12号字体：次要
 */
#define FONT_LIGHT(s)    {[UIFont systemFontOfSize:s];}
#define FONT_BOLD(s)     {[UIFont boldSystemFontOfSize:s];}

#define FONT_20             (FONT_LIGHT(20))
#define FONT_18             (FONT_LIGHT(18))
#define FONT_16             (FONT_LIGHT(16))
#define FONT_14             (FONT_LIGHT(14))
#define FONT_12             (FONT_LIGHT(12))
#define FONT_10             (FONT_LIGHT(10))

#define FONT_20B            (FONT_BOLD(20))
#define FONT_18B            (FONT_BOLD(18))
#define FONT_16B            (FONT_BOLD(16))
#define FONT_14B            (FONT_BOLD(14))
#define FONT_12B            (FONT_BOLD(12))
#define FONT_10B            (FONT_BOLD(10))


@end
