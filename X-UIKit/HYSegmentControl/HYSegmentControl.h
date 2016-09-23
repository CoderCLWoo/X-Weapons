/*
    说明：
        这个类是参考cocoaChina上其它开发者提供的源代码
    使用：
        1. 通过 titleSoure 属性可能传入您想显示的标题栏数组
        2.通过类方法可以指定一些参数的属性，属性在.m文件中有定义
        3.点击了某个按钮需要做哪些事情：你可以直接在这个尖的 属性:
            void (^finished)(UIButton *btn);
            写上准备要执行的代码就可以了
        4.如果想改变动画时间，指示线（底部的哪一条）可以直接在当前类
            的.m文件中的相关的宏定义 来修改参数 
 */

#import <UIKit/UIKit.h>

@interface HYSegmentControl : UIView

///  整个选项目卡的所有标题内容
@property (nonatomic, strong) NSMutableArray *titleSource;

///  点击要执行的闭包
@property (nonatomic, copy) void (^finished)(UIButton *btn);

///  创建一个选项卡
///
///  @param frame            指定的选项卡大小
///  @param titleSource      显示的标题数组
///  @param titleColor       标题文本颜色
///  @param selectTitleColor 当前选中的标题文本颜色
///  @param titleFont        所有的标题字体
///  @param selectTiteFont   选中的标题字体
///  @param backgroundColor  选项卡的背景颜色
///  @param bottomLingColor  底部指示器的颜色
///
///  @return 定制的选项卡
+ (instancetype)segmentColor:(CGRect)frame titleSource:(NSMutableArray *)titleSource titleColor:(UIColor *)titleColor selectTitleColor:(UIColor *)selectTitleColor titleFont:(UIFont *)titleFont selectTiteFont:(UIFont *)selectTiteFont backgroundColor:(UIColor *)backgroundColor bottomLingColor: (UIColor*) bottomLingColor;

@end
