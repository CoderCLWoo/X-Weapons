//
//  NSString+AvailableMobileNumber.m
//  checkPhoneNumber and checkEmail
//
//  Created by WuChunlong on 16/7/14.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "NSString+AvailableMobileNumber.h"

@implementation NSString (AvailableMobileNumber)

+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    if (mobileNum.length < 11) {
        NSLog(@"手机号长度只能是11位");
        return NO;
    } else {
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^(((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))[0-9]{8})|(1705)[0-9]{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^(((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))[0-9]{8})|(1709)[0-9]{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))[0-9]{8}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobileNum];
        
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobileNum];
        
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobileNum];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        } else {
            NSLog(@"请输入正确的电话号码");
            return NO;
        }
    }

}

- (BOOL)isMobileNumber {
    return [self isMatchedByPhoneRegex];
}

/**
 *  是否匹配正则表达式：phoneRegex 以上集合一起，并兼容14开头的
 */
- (BOOL)isMatchedByPhoneRegex {
    NSString * phoneRegex = @"^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

@end
