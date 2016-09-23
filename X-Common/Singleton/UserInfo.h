//
//  UserInfo.h
//  lianxi01
//
//  Created by 王勇 on 16/3/27.
//  Copyright © 2016年 Brave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
@interface UserInfo : NSObject
singleton_interface(UserInfo)
@property (nonatomic ,copy) NSString *nickName;
@property (nonatomic ,copy) NSString *yourName;
@property (nonatomic ,strong) NSData *imageData;

- (void)saveUserInofFromSanbox;

- (void)loadUserInofFromSanbox;
@end
