//
//  UIColor+hexColor.h
//  ZFramework
//
//  Created by liuchengbin on 15/5/9.
//  Copyright (c) 2015年 liuchengbin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1.]

@interface UIColor (hexColor)

+ (UIColor *)hexFloatColor:(NSString *)hexStr;

@end
