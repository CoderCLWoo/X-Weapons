//
//  GradientButton.m
//  渐变色
//
//  Created by WuChunlong on 16/8/20.
//  Copyright © 2016年 WuChunlong. All rights reserved.
//

#import "CAGradientButton.h"

@interface CAGradientButton ()

@property (strong, nonatomic) void (^action)(CAGradientButton *btn);

@end

@implementation CAGradientButton

+ (instancetype)buttonWithFrame:(CGRect)frame borderColors:(NSArray<UIColor *> *)colors borderWidth:(CGFloat)borderWidth addToParentView:(UIView *)parentView {
    
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(-borderWidth + frame.origin.x, -borderWidth + frame.origin.y, frame.size.width + borderWidth * 2, frame.size.height + borderWidth * 2);
    backView.backgroundColor = [UIColor clearColor];
    backView.layer.cornerRadius = backView.frame.size.height * 0.5;
    backView.layer.masksToBounds = YES;
//    backView.clipsToBounds = YES;
    
    [parentView addSubview:backView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backView.bounds;
    
    if (colors.count) {
        NSMutableArray *borderColors = [NSMutableArray arrayWithCapacity:colors.count];
        for (UIColor *color in colors) {
            [borderColors addObject:(id)[color CGColor]];
        }
        gradient.colors = borderColors;
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(1, 0);
    }
    
    
    [backView.layer insertSublayer:gradient atIndex:0];
    
    CAGradientButton *btn = [self buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(borderWidth, borderWidth, frame.size.width, frame.size.height);
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius = btn.frame.size.height * 0.5;
    [backView addSubview:btn];
    
    return btn;
}

+ (instancetype)buttonWithFrame:(CGRect)frame borderColors:(NSArray<UIColor *> *)colors borderWidth:(CGFloat)borderWidth addToParentView:(UIView *)parentView action:(void (^)(CAGradientButton *button))action {
    
    CAGradientButton *btn = [self buttonWithFrame:frame borderColors:colors borderWidth:borderWidth addToParentView:parentView];
    btn.action = action;
    [btn addTarget:btn action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

/**
 *  按钮点击回调事件
 *
 *  @param btn 点击的按钮
 */
- (void)onBtnClick:(CAGradientButton *)btn {
    self.action(btn);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
