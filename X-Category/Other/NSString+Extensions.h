//
//  NSString+Extensions.h
//  danpin
//
//  Created by chuangjia on 10/8/15.
//  Copyright (c) 2015 chuangjia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>

@interface NSString (Extensions)
- (NSString *)lowercaseFirstCharacter;
- (NSString *)uppercaseFirstCharacter;
- (BOOL)isEmpty;
- (NSString *)replaceNullString;
- (NSString *)trim;
- (NSString *)trimTheExtraSpaces;
- (NSString *)escapeHTML;
- (NSString *)stringByDecodingXMLEntities;
- (NSString *)md5;
- (NSString *)md5ForUTF16;
- (CGFloat)fontSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (NSMutableArray *)tokenizationStringByNSStringEnumerationOptions:(NSStringEnumerationOptions)opts;
- (NSString *)languageForString;
- (NSMutableArray *)analyseTextOfSentences;
//
// 获取Documents路径
+ (NSString *)documentPath;

// 获取缓存路径
+ (NSString *)cachePath;

+ (NSString *)imageCachePath;

// 本地购物车路径
+ (NSString *)localShoppingCartPath;

//! 是否是合法邮箱
- (BOOL)isValidEmail;
//! 是否是合法号码
- (BOOL)isValidPhoneNumber;
//! 是否是合法的18位身份证号码
- (BOOL)isValidPersonID;
/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code;

//! 根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName;
+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type;

// 根据秒数返回日期
+ (NSString *)dateWithSeconds:(NSUInteger)seconds;

@end
