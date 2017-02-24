//
//  Cryptor.m
//  CryptorDemo
//
//  Created by apple on 15/9/8.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Cryptor.h"
#import "Cryptor.h"
#import <CommonCrypto/CommonCryptor.h>

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation Cryptor

/**
 *  AES对字符串加密 返回一个字符串
 *
 *  @param key <#key description#>
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)AES256EncryptWithKey:(NSString *)key
                         forString:(NSString *)string{
    if (string.length >0) {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *encodeData = [self AES256EncryptWithKey:key forData:data];
        
        return [self base64EncodedStringFrom:encodeData];
    }
    
    return @"";
    
    
}


/**
 *  对加密后的AES字符串解密  返回一个字符串
 *
 *  @param key <#key description#>
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)AES256DecryptWithKey:(NSString *)key
                         forString:(NSString *)string{
    if (string.length >0) {
       NSData *data = [self dataWithBase64EncodedString:string];
        
        NSData *decodeData = [self AES256DecryptWithKey:key forData:data];
        
        return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    }
    
    return @"";
}


//aes加密
+ (NSData *)AES256EncryptWithKey:(NSString *)key
                         forData:(NSData *)data//加密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    NSLog(@"加密失败");
    return nil;
}

//aes解密
+ (NSData *)AES256DecryptWithKey:(NSString *)key
                         forData:(NSData *)data//解密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    free(buffer);
    NSLog(@"解密失败");
    return nil;
}



/**
 *  加密 保存到路径
 *
 *  @param key  <#key description#>
 *  @param data <#data description#>
 *  @param path 存储路径（完整路径）
 */
+ (void)AES256EncryptWithKey:(NSString *)key
                     forData:(NSData *)data
                    savePata:(NSString *)path
                    complete:(void (^)(BOOL))completeBlock{
    
    
   NSData *encodeData = [Cryptor AES256EncryptWithKey:key forData:data];
    
    if (encodeData == nil) {
        NSLog(@"data为空，加密失败");
        return;
    }
   
    //异步写入
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
      BOOL success =  [encodeData writeToFile:path atomically:YES];
        if (success && completeBlock) {
            completeBlock(success);
        }
        
        
    });
    
}

/**
 *  解密保存到路径
 *
 *  @param key  <#key description#>
 *  @param data <#data description#>
 *  @param path 存储路径（完整路径）
 */
+ (void)AES256DecryptWithKey:(NSString *)key
                     forData:(NSData *)data
                    savePata:(NSString *)path
                    complete:(void (^)(BOOL))completeBlock{
    
    
    
    NSData *decodeData = [Cryptor AES256DecryptWithKey:key forData:data];
    
    if (decodeData == nil) {
        NSLog(@"data为空，加密失败");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL success =  [decodeData writeToFile:path atomically:YES];
        if (success && completeBlock) {
            completeBlock(success);
        }

    });

}



#pragma mark --DES加密



/**
 *  DES对字符串加密 返回一个字符串
 *
 *  @param key <#key description#>
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)DESEncryptWithKey:(NSString *)key
                      forString:(NSString *)string{
    if (string.length >0) {
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
        
        NSData *encodeData = [self DESEncryptWithKey:key forData:data];
        
        return [self base64EncodedStringFrom:encodeData];
    }
    
    return @"";

}
/**
 *  对加密后的DES字符串解密  返回一个字符串
 *
 *  @param key <#key description#>
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)DESDecryptWithKey:(NSString *)key
                      forString:(NSString *)string{
    if (string.length >0) {
        NSData *data = [self dataWithBase64EncodedString:string];
        
        NSData *decodeData = [self DESDecryptWithKey:key forData:data];
        
        return [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    }
    
    return @"";

}


+ (NSData *)DESEncryptWithKey:(NSString *)key
                      forData:(NSData *)data
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer);
    return nil;
}

#pragma mark --DES解密
//
+ (NSData *)DESDecryptWithKey:(NSString *)key
                      forData:(NSData *)data
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeDES,
                                          NULL,
                                          [data bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer);
    return nil;
}




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
          complete:(void(^)(BOOL isSuccess))completeBlock{
    
    
    
    NSData *encodeData = [Cryptor DESEncryptWithKey:key forData:data];
    
    
    if (encodeData == nil) {
        NSLog(@"data为空，加密失败");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL success =  [encodeData writeToFile:path atomically:YES];
        if (success && completeBlock) {
            completeBlock(success);
        }
        
    });
    
}

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
          complete:(void(^)(BOOL isSuccess))completeBlock
{
    
    NSData *decodeDtat = [Cryptor DESDecryptWithKey:key forData:data];
    
    
    if (decodeDtat == nil) {
        NSLog(@"data为空，加密失败");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL success =  [decodeDtat writeToFile:path atomically:YES];
        if (success && completeBlock) {
            completeBlock(success);
        }
        
    });
    

    
    
}


#pragma mark -- base64

//data转String
+ (NSString *)base64EncodedStringFrom:(NSData *)data
{
    if ([data length] == 0)
        return @"";
    
    char *characters = malloc((([data length] + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (i < [data length])
    {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < [data length])
            buffer[bufferLength++] = ((char *)[data bytes])[i++];
        
        //  Encode the bytes in the buffer to four characters, including padding "=" characters if necessary.
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}



//String转data
+ (NSData *)dataWithBase64EncodedString:(NSString *)string
{
    if (string == nil)
        [NSException raise:NSInvalidArgumentException format:@""];
    if ([string length] == 0)
        return [NSData data];
    
    static char *decodingTable = NULL;
    if (decodingTable == NULL)
    {
        decodingTable = malloc(256);
        if (decodingTable == NULL)
            return nil;
        memset(decodingTable, CHAR_MAX, 256);
        NSUInteger i;
        for (i = 0; i < 64; i++)
            decodingTable[(short)encodingTable[i]] = i;
    }
    
    const char *characters = [string cStringUsingEncoding:NSASCIIStringEncoding];
    if (characters == NULL)     //  Not an ASCII string!
        return nil;
    char *bytes = malloc((([string length] + 3) / 4) * 3);
    if (bytes == NULL)
        return nil;
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    while (YES)
    {
        char buffer[4];
        short bufferLength;
        for (bufferLength = 0; bufferLength < 4; i++)
        {
            if (characters[i] == '\0')
                break;
            if (isspace(characters[i]) || characters[i] == '=')
                continue;
            buffer[bufferLength] = decodingTable[(short)characters[i]];
            if (buffer[bufferLength++] == CHAR_MAX)      //  Illegal character!
            {
                free(bytes);
                return nil;
            }
        }
        
        if (bufferLength == 0)
            break;
        if (bufferLength == 1)      //  At least two characters are needed to produce one byte!
        {
            free(bytes);
            return nil;
        }
        
        //  Decode the characters in the buffer to bytes.
        bytes[length++] = (buffer[0] << 2) | (buffer[1] >> 4);
        if (bufferLength > 2)
            bytes[length++] = (buffer[1] << 4) | (buffer[2] >> 2);
        if (bufferLength > 3)
            bytes[length++] = (buffer[2] << 6) | buffer[3];
    }
    
    bytes = realloc(bytes, length);
    return [NSData dataWithBytesNoCopy:bytes length:length];
}
/**
 *  base64字符串转成字符串
 *
 *  @param string string description
 *
 *  @return return value description
 */
+ (NSString *)stringWithBase64EncodeString:(NSString *)base64String{
    
    NSData *data = [self dataWithBase64EncodedString:base64String];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
}
/**
 *  字符串转成base64字符串
 *
 *  @param string string description
 *
 *  @return return value description
 */
+ (NSString *)base64StringDecodeString:(NSString *)string{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self base64EncodedStringFrom:data];
    
    
}

@end
