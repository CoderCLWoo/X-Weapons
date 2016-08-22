//
//  XMGInfiniteScrollView.h
//  06-03-分页
//
//  Created by MJ Lee on 15/5/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMGInfiniteScrollView : UIView
@property (strong, nonatomic) NSArray *images;
@property (weak, nonatomic, readonly) UIPageControl *pageControl;
@property (assign, nonatomic, getter=isScrollDirectionPortrait) BOOL scrollDirectionPortrait;
@end
