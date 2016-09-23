//
//  UserInfo.m
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import "UserInfo.h"
#define nicKEY @"nickname"
#define youKEY @"yourname"
#define headKEY @"image"

@implementation UserInfo
singleton_implementation(UserInfo)


- (void)saveUserInofFromSanbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.nickName forKey:nicKEY];
    [defaults setValue:self.yourName forKey:youKEY];
    [defaults setObject:self.imageData forKey:headKEY];
    [defaults synchronize];
}

- (void)loadUserInofFromSanbox{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   self.nickName = [defaults objectForKey:nicKEY];
   self.yourName = [defaults objectForKey:youKEY];
    self.imageData = [defaults objectForKey:headKEY];
}

@end
