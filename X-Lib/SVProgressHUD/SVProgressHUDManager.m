//
//  SVProgressHUDManager.m
//  02-AFN01-简单使用
//
//  Created by danpin on 16/9/23.
//  Copyright © 2016年 heima. All rights reserved.
//

#import "SVProgressHUDManager.h"
#import "SVProgressHUD.h"

@implementation SVProgressHUDManager

+ (instancetype)manager {
    return [[self alloc] init];
}


-(void)showHud:(NSString*)msg {
    [SVProgressHUD showWithStatus:msg maskType:SVProgressHUDMaskTypeClear];
    self.hudIsHide = NO;
}

-(void)hideHud {
    [SVProgressHUD dismiss];
    self.hudIsHide = YES;
}

- (void)showHudIsSuccess:(BOOL)isSuccess msg:(NSString*)msg duration:(CGFloat)duration {
    if (isSuccess) {
        [SVProgressHUD showSuccessWithStatus:msg duration:duration];
    }else{
        [SVProgressHUD showErrorWithStatus:msg duration:duration];
    }
}

@end
