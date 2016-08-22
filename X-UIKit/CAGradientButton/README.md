# CAGradientButton
###一行代码实现创建一个边框颜色可以渐变的Button

- 创建方法



```   
#pragma mark - 静态初始化方法
/**
 *  创建一个可以边框颜色渐变的Button
 *
 *  @param frame       button的frame
 *  @param colors      边框需要渐变的颜色
 *  @param borderWidth 边框宽度
 *  @param parentView  父视图
 *
 *  @return 可以边框颜色渐变的Button
 */
+ (instancetype)buttonWithFrame:(CGRect)frame borderColors:(NSArray<UIColor *> *)colors borderWidth:(CGFloat)borderWidth addToParentView:(UIView *)parentView;



/**
 *  创建一个可以边框颜色渐变的Button
 *
 *  @param frame       button的frame
 *  @param colors      边框需要渐变的颜色
 *  @param borderWidth 边框宽度
 *  @param parentView  父视图
 *  @param action      button的回调事件
 *
 *  @return 可以边框颜色渐变的Button
 */
+ (instancetype)buttonWithFrame:(CGRect)frame borderColors:(NSArray<UIColor *> *)colors borderWidth:(CGFloat)borderWidth addToParentView:(UIView *)parentView action:(void(^)(CAGradientButton *button))action;
```