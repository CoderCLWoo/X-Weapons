//
//  XTool.h
//  mgpyh
//
//  Created by x on 13-10-27.
//  Copyright (c) 2013年 x. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>

@interface XTool : NSObject
+(void)openWebBrowser:(NSString *)url Controller:(UIViewController *)controller type:(NSString *)type;

//获取当前viewcontroller
+ (UIViewController *)getCurrentRootViewController;

+(void)openWebBrowser:(NSString *)url Controller:(UIViewController *)controller;

+ (NSString *)appVersion;

+ (NSString *)flattenHTML:(NSString *)html;

+ (NSString *)htmlToText:(NSString *)urlString;

//手机机型
+ (NSString *)deviceModel;

+ (NSString *)md5String:(NSString *)string;

+ (BOOL)createDirectoriesAtPath:(NSString *)inPath
                     attributes:(NSDictionary *)inAttributes;

+ (NSString *)pathWithDocuments;

+ (UIImage *)createImage:(UIColor *)color;

+ (CGSize)textSizeWith:(NSString *)text Font:(UIFont *)font ShowWidth:(CGFloat)width;

+ (NSString *)switchTime:(NSString*)dataTime DataFormat:(NSString *)format;

+ (NSString *)timeFormat:(NSString *)strTime;

+ (NSString *)stringWith:(NSDate *)time;

+ (NSString *)nowTime;

+ (NSString *)cachePath;

+ (CGFloat)covertiPhone6SizeFromOldSize:(CGFloat)size;

//设置扩展属性
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

@end
