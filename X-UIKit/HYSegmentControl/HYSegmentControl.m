/// 动画执行的时间
#define ANIMATIONDURATION 0.2

/// 底部指示线的高度
#define BOTTOMLIINEHEIGHT 2

/// 更大的字体，以便给计算宽度时留有空间
#define MAXFONTSIZE (self.selectTiteFont)

#import "HYSegmentControl.h"
#import "viewconfig.h"
@interface HYSegmentControl()
///  每个标题的颜色
@property (nonatomic, strong) UIColor *titleColor;

///  当前选中标题的颜色
@property (nonatomic, strong) UIColor *selectTitleColor;

///  所有标题的字体
@property (nonatomic, strong) UIFont *titleFont;

///  选中标题的字体
@property (nonatomic, strong) UIFont *selectTiteFont;

///  底部指示线和颜色
@property (nonatomic, strong) UIColor *bottomLineColor;


///  底部导航条的宽度
@property (nonatomic, assign) CGFloat bottomLineWidth;

///  当前选中的按钮记录
@property (nonatomic, assign) NSUInteger currentSelectSegment;

///  询问导航条
@property (nonatomic, strong) UIView *bottomLine;

///  宽度数组-用于设置按钮的位置
@property (nonatomic, strong) NSMutableDictionary *btnFrames;

@end

@implementation HYSegmentControl


-(void)dealloc{
    if (_titleColor) {
        _titleColor  = nil ;
    }
    if (_selectTitleColor) {
        _selectTitleColor = nil ;
    }
    if (_titleFont) {
        _titleFont = nil ;
    }
    if (_selectTiteFont) {
        _selectTiteFont = nil ;
    }
    if (_bottomLineColor) {
        _bottomLineColor = nil ;
    }
    if (_bottomLine) {
        [_bottomLine removeFromSuperview];
        _bottomLine = nil ;
    }
    if (_btnFrames) {
        [_btnFrames removeAllObjects];
        _btnFrames = nil ;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 设置数据源
        self.titleSource = [NSMutableArray array];
        // 当前选中第一个
        self.currentSelectSegment = -1;
    }
    return self;
}

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
+ (instancetype)segmentColor:(CGRect)frame titleSource:(NSMutableArray *)titleSource titleColor:(UIColor *)titleColor selectTitleColor:(UIColor *)selectTitleColor titleFont:(UIFont *)titleFont selectTiteFont:(UIFont *)selectTiteFont backgroundColor:(UIColor *)backgroundColor bottomLingColor: (UIColor*) bottomLingColor{
    
    // 实现化对象 - 指定大小
    HYSegmentControl *segmentControl = [[self alloc] initWithFrame:frame];
    
    // 设置背景颜色
    segmentControl.backgroundColor = backgroundColor;
    
    // 字体颜色
    segmentControl.titleColor = titleColor;
    segmentControl.selectTitleColor = selectTitleColor;
    
    // 字体及大小
    segmentControl.titleFont = titleFont;
    segmentControl.selectTiteFont = selectTiteFont;
    
    // 设置数据源
    [segmentControl addTitleSource:titleSource bottomLineColor:bottomLingColor];
    
    // 返回
    return segmentControl;
}

// MARK: - 显示内容的数据源
- (void) addTitleSource:(NSMutableArray *)titleSource bottomLineColor:(UIColor*)bottomLineColor{
    
    // 1.获得所有标题内容
    NSMutableString *str = [NSMutableString string];
    for (NSString *obj in titleSource) {
        str = (NSMutableString *)[str stringByAppendingString:obj];
    }
    
    // 2. 计算字体的宽度
    CGFloat fontWith = [str boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: MAXFONTSIZE} context:nil].size.width;
    
    fontWith = fontWith <= self.bounds.size.width ? fontWith : self.bounds.size.width;
    
    // 按钮的个数
    NSInteger seugemtCount = titleSource.count;
    
    // 计算按钮的间距
    CGFloat padding = (self.bounds.size.width - fontWith) / (seugemtCount + 1); // 30
    
    // 3.创建按钮
    NSMutableString *frongString = [NSMutableString string];
    for (NSInteger i = 0; i < seugemtCount; i++) {
        
        // 获得按钮宽度(也是标题的宽度)
        CGFloat currentBtnLenth = [titleSource[i] boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: MAXFONTSIZE} context:nil].size.width;
        
        CGFloat frontBtnLength = 0;
        if (i) {
            // 当前按钮的前面的所有按钮标题
            frongString = (NSMutableString *)[frongString stringByAppendingString:titleSource[i - 1]];
            
            // 前面按钮的宽度
            frontBtnLength = [frongString boundingRectWithSize:CGSizeMake(self.bounds.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: MAXFONTSIZE} context:nil].size.width;
        }       
        
        CGFloat btnX = (i + 1) * padding + frontBtnLength;
        
        // 按钮的frame存储在frame中
        [self.btnFrames setValue:[NSValue valueWithCGRect:CGRectMake(btnX, 0, currentBtnLenth, self.bounds.size.height - BOTTOMLIINEHEIGHT)] forKey:[NSString stringWithFormat:@"%zd", i]];
        NSLog(@"%@", NSStringFromCGRect([[self.btnFrames valueForKey:[NSString stringWithFormat:@"%zd", i]] CGRectValue]));
        
        UIButton * btn = [[UIButton alloc] initWithFrame: [[self.btnFrames valueForKey:[NSString stringWithFormat:@"%zd", i]] CGRectValue]];
        [btn setTitle: titleSource[i] forState:UIControlStateNormal];
        
        [btn.titleLabel setFont:self.titleFont];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [btn setTitleColor:self.titleColor forState:UIControlStateNormal];
        
        [btn setTitleColor:self.selectTitleColor forState:UIControlStateSelected];
        
        btn.tag = i;
        if (i == 0) {
            [self segmentControlSelected:btn];
        }
        
        [btn addTarget:self action:@selector(segmentControlSelected:) forControlEvents:UIControlEventTouchUpInside];
        
       
        [self addSubview:btn];
        
        [self.titleSource addObject:btn];
    }
    
    // 创建指示器
    self.bottomLine =[[UIView alloc]initWithFrame:CGRectMake(68*DEVICE_WIDTH/375, self.bounds.size.height - BOTTOMLIINEHEIGHT, [[self.btnFrames valueForKey:@"0"] CGRectValue].size.width, BOTTOMLIINEHEIGHT)];
    self.bottomLineWidth = [[self.btnFrames valueForKey:@"0"] CGRectValue].size.width;

    [self.bottomLine setBackgroundColor:bottomLineColor];

    [self addSubview:self.bottomLine];
    
    [[self.titleSource firstObject] setSelected:YES];
}

// MARK: - 选项卡选中
- (void)segmentControlSelected:(UIButton *)btn {
    
    // 如果选中的是和当前选中的是同一个，什么都不做
    if (btn.tag == self.currentSelectSegment) {
        return;
    }
    
    // 动画执行
    [UIView animateWithDuration:ANIMATIONDURATION animations:^{
        // 取消原来的内容
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            // 找到原来选中的按钮
            if (obj.tag == self.currentSelectSegment) {
                // 取消设置
                obj.selected = NO;
                obj.titleLabel.font = self.titleFont;
                *stop = YES;
            }
        }];
        
        // 设置当前选择标记
        self.currentSelectSegment = btn.tag;
        
        // 修改指示条的位置
        CGRect frame = self.bottomLine.frame;
        // 获得当前按钮的frame
        CGRect btnFrame = [[self.btnFrames valueForKey:[NSString stringWithFormat:@"%zd", btn.tag]] CGRectValue];
        // 修正 X 和 宽度就可以了
        frame.origin.x = btnFrame.origin.x;
        frame.size.width = btnFrame.size.width;
        self.bottomLine.frame = frame;
        
        // 修改字体大小
        btn.titleLabel.font = self.selectTiteFont;
        
        btn.selected = YES;
        
        

    } completion:^(BOOL finish){
        if(self.finished) {
            self.finished(btn); // 执行闭包
        }
    }];
    
}
#pragma mark - 懒加载
- (NSMutableDictionary *)btnFrames {
    if (!_btnFrames) {
        _btnFrames = [NSMutableDictionary dictionary];
    }
    return _btnFrames;
}

@end
