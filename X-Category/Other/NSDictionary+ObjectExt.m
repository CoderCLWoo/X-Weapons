//
//  NSDictionary+ObjectExt.m
//  danpin
//
//  Created by chuangjia on 26/11/2015.
//  Copyright © 2015 chuangjia. All rights reserved.
//

#import "NSDictionary+ObjectExt.h"
#import "NSString+Extensions.h"
@implementation NSDictionary(ObjectExt)

/**
 
 *获取字典指定的NSDictionary的对象
 * @param aKey key
 * @return value值如果为nil或者null会返回空列表
 
 */

-(NSDictionary*)dictionaryObjectForKey:(id)aKey

{
    
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]]||![value isKindOfClass:[NSDictionary class]])
    {
        return nil;
        
    }
    
    return value;
    
}

/**
 
 *获取字典指定的array的对象
 * @param aKey key
 * @return value值如果为nil或者null会返回空列表
 
 */

-(NSArray*)arrayObjectForKey:(id)aKey

{
    
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]])
    {
        return nil;
        
    }
    
    return value;
    
}

/**
 
 *获取字典指定的array的对象
 * @param aKey key
 * @return value值如果为nil或者null会返回空列表
 
 */

-(NSMutableArray*)mutableArrayObjectForKey:(id)aKey

{
    
    id value = [self objectForKey:aKey];
    
    if (value == nil || [value isKindOfClass:[NSNull class]])
        
    {
        
        return nil;
        
    }
    
    return value;
    
}

/**
 * 获取字典指定的对象为空是返回默认对象
 * @param aKey key
 * @param defaultObject value值如果为nil或者null会返回默认对象
 * @return 对象
 
 */

-(id)objectExtForKey:(id)aKey defaultObject:(id)defaultObject

{
    
    id value = [self objectForKey:aKey];
    
    if (value == nil || [value isKindOfClass:[NSNull class]])
        
    {
        
        return defaultObject;
        
    }
    
    return value;
    
}

/**
 
 * @brief 如果akey找不到，返回@"" (防止出现nil，使程序崩溃)
 * @param aKey 字典key值
 * @return 字典value
 
 */

- (NSString*) stringForKey:(id)aKey
{
    
    return [self stringForKey:aKey withDefaultValue:@""];
    
}

/**
 
 *获取字典指定的key的数值字符
 * @param aKey key
 * @return value值如果为nil或者null会返回0字符串
 
 */

-(NSString*)numberStringForKey:(id)aKey

{
    
    return [self stringForKey:aKey withDefaultValue:@"0"];
    
}

/**
 
 * @brief @brief 如果akey找不到，返回默认值 (防止出现nil，使程序崩溃)
 * @param aKey 字典key值
 * @param defValue 为空时的默认值
 * @return 字典value
 
 */

- (NSString *)stringForKey:(id)aKey withDefaultValue:(NSString *)defValue

{
    
    NSString *value = [self objectForKey:aKey];
    
    if (value == nil || [value isKindOfClass:[NSNull class]])
        
    {
        
        value = defValue;
        
    }
    
    return [[NSString stringWithFormat:@"%@",value] replaceNullString];
    
}

/**
 
 * @brief 替换&nbsp;为空
 * @param aKey 字典key值
 * @return 字典value
 
 */

-(NSString*)replaceNBSPforKey:(id)aKey

{
    
    NSString *value = [self objectForKey:aKey];
    
    if (!value)
        
    {
        
        value = @"";
        
    }
    
    NSString* str = [value stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "] ;
    
    return [[NSString stringWithFormat:@"%@",str] replaceNullString];
    
}
@end
