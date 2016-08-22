//
//  NSString+AvailableEmail.m
//  checkPhoneNumber and checkEmail
//
//  Created by WuChunlong on 16/7/14.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "NSString+AvailableEmail.h"

@implementation NSString (AvailableEmail)

- (BOOL)isAvailableEmail {
    return [[self class] validateEmail:self];
}

+ (BOOL)isAvailableEmail:(NSString *)eMail {
    return [self validateEmail:eMail];
}

+ (BOOL)validateEmail:(NSString *)email
{
   
    NSString *emailRegex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
