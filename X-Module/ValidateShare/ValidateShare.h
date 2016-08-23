//
//  ValidateShare.h
//  danpin
//
//  Created by chuangjia on 4/11/2015.
//  Copyright © 2015 chuangjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ValidateShare : NSObject
+ (instancetype)sharedInstance;
//邮箱
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
+ (BOOL) checkUserIDCardNumber:(NSString *)value;


@end
