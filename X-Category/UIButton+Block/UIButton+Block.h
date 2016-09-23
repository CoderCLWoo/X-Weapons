//
//  UIButton+Block.h
//  AVPlay
//
//  Created by danpin on 16/9/3.
//  Copyright © 2016年 danpin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^btnBlock)();

@interface UIButton (Block)

/**
 *  处理回调事件
 *
 *  @param block 回调block
 */
- (void)handleWithBlock:(btnBlock)block;

@end
