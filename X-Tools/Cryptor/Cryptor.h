//
//  Cryptor.h
//  CryptorDemo
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Cryptor : NSObject


#pragma mark -- base 64
/**
 *  data数据转成base64字符串
 *
 *  @param data data description
 *
 *  @return return value description
 */
+ (NSString *)base64EncodedStringFrom:(NSData *)data;
/**
 *  base64字符串转成data数据
 *
 *  @param string string description
 *
 *  @return return value description
 */
+ (NSData *)dataWithBase64EncodedString:(NSString *)string;
/**
 *  base64字符串转成字符串
 *
 *  @param base64String string description
 *
 *  @return return value description
 */
+ (NSString *)stringWithBase64EncodeString:(NSString *)base64String;
/**
 *  字符串转成base64字符串
 *
 *  @param string string description
 *
 *  @return return value description
 */
+ (NSString *)base64StringDecodeString:(NSString *)string;


#pragma mark --AES

/**
 *  AES对字符串加密 返回一个字符串
 *
 *  @param key <#key description#>
 *  @param string <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)AES256EncryptWithKey:(NSString *)key
                         forString:(NSString *)string;
/**
 *  对加密后的AES字符串解密  返回一个字符串
 *
 *  @param key <#key description#>
 *  @param string <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)AES256DecryptWithKey:(NSString *)key
                         forString:(NSString *)string;



/**
 *  AES加密
 *
 *  @param key  加密的key
 *  @param data 需要加密的数据
 *
 *  @return 加密后的数据
 */
+ (NSData *)AES256EncryptWithKey:(NSString *)key
                         forData:(NSData *)data;//加密
/**
 *  AES解密
 *
 *  @param key  解密的key
 *  @param data 加密过的数据
 *
 *  @return 解密完成的数据
 */
+ (NSData *)AES256DecryptWithKey:(NSString *)key
                         forData:(NSData *)data;//解密


/**
 *  AES加密 保存到路径
 *
 *  @param key  <#key description#>
 *  @param data <#data description#>
 *  @param path 存储路径（完整路径）
 */
+ (void)AES256EncryptWithKey:(NSString *)key
                     forData:(NSData *)data
                    savePata:(NSString *)path
                    complete:(void(^)(BOOL isSuccess))completeBlock;

/**
 *  AES解密保存到路径
 *
 *  @param key  <#key description#>
 *  @param data <#data description#>
 *  @param path 存储路径（完整路径）
 */
+ (void)AES256DecryptWithKey:(NSString *)key
                     forData:(NSData *)data
                    savePata:(NSString *)path
                    complete:(void(^)(BOOL isSuccess))completeBlock;




#pragma mark -- des


/**
 *  DES对字符串加密 返回一个字符串
 *
 *  @param key <#key description#>
 *  @param string <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)DESEncryptWithKey:(NSString *)key
                      forString:(NSString *)string;
/**
 *  对加密后的DES字符串解密  返回一个字符串
 *
 *  @param key <#key description#>
 *  @param string <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)DESDecryptWithKey:(NSString *)key
                      forString:(NSString *)string;


/**
 *  DES加密

 */
+ (NSData *)DESEncryptWithKey:(NSString *)key
               forData:(NSData *)data;
/**
 *  DES解密

 */
+ (NSData *)DESDecryptWithKey:(NSString *)key
                      forData:(NSData *)data;


/**
 *  DES加密保存到路径
 *
 *  @param key  key description
 *  @param data data description
 *  @param path 存储路径（完整路径）
 */
+ (void)DESEncrypt:(NSString *)key
           forData:(NSData *)data
          savePata:(NSString *)path
          complete:(void(^)(BOOL isSuccess))completeBlock;


/**
 *  DES解密保存到路径
 *
 *  @param key  key description
 *  @param data data description
 *  @param path 存储路径（完整路径）
 */
+ (void)DESDecrypt:(NSString *)key
           forData:(NSData *)data
          savePata:(NSString *)path
          complete:(void(^)(BOOL isSuccess))completeBlock;



@end

