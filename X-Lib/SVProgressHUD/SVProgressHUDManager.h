//
//  SVProgressHUDManager.h
//  02-AFN01-简单使用
//
//  Created by danpin on 16/9/23.
//  Copyright © 2016年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVProgressHUDManager : NSObject

@property (nonatomic) BOOL hudIsHide; //hud是否隐藏了

+ (instancetype)manager;

- (void)showHud:(NSString*)msg;
- (void)hideHud;
- (void)showHudIsSuccess:(BOOL)isSuccess msg:(NSString*)msg duration:(CGFloat)duration;

@end
