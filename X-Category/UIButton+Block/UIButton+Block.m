//
//  UIButton+Block.m
//  AVPlay
//
//  Created by danpin on 16/9/3.
//  Copyright © 2016年 danpin. All rights reserved.
//

#import "UIButton+Block.h"

#import <objc/runtime.h>

static const char btnKey;

@implementation UIButton (Block)

- (void)handleWithBlock:(btnBlock)block {
    
    if (block) {
        
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
        
    }
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction {
    
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}

/**
 *  tips: 使用objc_setAssociatedObject，需要引入头文件 #import <objc/runtime.h>
 *
 *  void objc_setAssociatedObject(id object, const void key, id value, objc_AssociationPolicy policy);
 *  id objc_getAssociatedObject(id object, const void key);
 *
 *  这两个方法可以让一个对象和另一个对象关联，就是说一个对象可以保持对另一个对象的引用，并获取那个对象。有了这些，就能实现属性功能了。 policy可以设置为以下这些值:
 *
 *  enum {
         OBJC_ASSOCIATION_ASSIGN = 0,
         OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,
         OBJC_ASSOCIATION_COPY_NONATOMIC = 3,
         OBJC_ASSOCIATION_RETAIN = 01
         OBJC_ASSOCIATION_COPY = 01403
     };
 *
 */

@end
