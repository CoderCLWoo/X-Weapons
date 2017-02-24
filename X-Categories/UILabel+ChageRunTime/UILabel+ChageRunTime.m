//
//  UILabel+ChageRunTime.m
//  文思面试
//
//  Created by mac on 16/5/19.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "UILabel+ChageRunTime.h"
#import <objc/runtime.h>
@implementation UILabel (ChageRunTime)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        Class labClass = [self class];
        //替换三个方法
        //原始方法
        SEL selectInit = @selector(init);
        SEL selectInitFrame = @selector(initWithFrame:);
        SEL selectAwake = @selector(awakeFromNib);
        //自定义方法
        SEL ZYselectInit = @selector(ZYinit);
        SEL ZYselectInitFrame = @selector(ZYinitWithFrame:);
        SEL ZYselectAwake = @selector(ZYawakeFromNib);
        //加入method
        //原始类method
        Method initMethod = class_getInstanceMethod(labClass, selectInit);
        Method initFrameMethod = class_getInstanceMethod(labClass, selectInitFrame);
        Method awakeMethod = class_getInstanceMethod(labClass, selectAwake);
        //自定义类method
        Method zyInitMethod = class_getInstanceMethod(labClass, ZYselectInit);
        Method zyInitFrameMethod = class_getInstanceMethod(labClass, ZYselectInitFrame);
        Method zyAwakeMethod = class_getInstanceMethod(labClass, ZYselectAwake);
    //是否改变方法
        BOOL didAddMethodInit = class_addMethod(labClass, selectInit, method_getImplementation(zyInitMethod), method_getTypeEncoding(zyInitMethod));
        BOOL didAddMethodInitFrame = class_addMethod(labClass, selectInitFrame, method_getImplementation(zyInitFrameMethod), method_getTypeEncoding(zyInitFrameMethod));
         BOOL didAddMethodAwake = class_addMethod(labClass, selectAwake, method_getImplementation(zyAwakeMethod), method_getTypeEncoding(zyAwakeMethod));
        //替换方法
        if (didAddMethodInit) {
            class_replaceMethod(labClass, ZYselectInit,method_getImplementation(initMethod), method_getTypeEncoding(initMethod));
        }else{
            method_exchangeImplementations(initMethod, zyInitMethod);
        }
        
        if (didAddMethodInitFrame) {
            class_replaceMethod(labClass, ZYselectInitFrame,method_getImplementation(initFrameMethod), method_getTypeEncoding(initFrameMethod));
        }else{
            method_exchangeImplementations(initFrameMethod, zyInitFrameMethod);
        }
        
        if (didAddMethodAwake) {
            class_replaceMethod(labClass, ZYselectAwake,method_getImplementation(awakeMethod), method_getTypeEncoding(awakeMethod));
        }else{
            method_exchangeImplementations(awakeMethod, zyAwakeMethod);
        }
        
    });

}


#pragma mark 自定义初始化方法
- (instancetype)ZYinit{
    id __self = [self ZYinit];
    UIFont *font = [UIFont systemFontOfSize:14];
    if (font) {
        self.font = font;
    }
    UIColor *color = [UIColor orangeColor];
    if (color) {
        
        self.textColor = color;
    }
    return __self;
}
- (instancetype)ZYinitWithFrame:(CGRect)frame{
    id __self = [self ZYinitWithFrame:frame];
    UIFont *font = [UIFont systemFontOfSize:14];
    if (font) {
        self.font = font;
    }
    UIColor *color = [UIColor orangeColor];
    if (color) {
        
        self.textColor = color;
    }
    return __self;
}

- (void)ZYawakeFromNib{
    [self ZYawakeFromNib];

    UIFont *font = [UIFont systemFontOfSize:14];
    if (font) {
        self.font = font;
    }
    UIColor *color = [UIColor orangeColor];
    if (color) {
        
        self.textColor = color;
    }

}


@end
