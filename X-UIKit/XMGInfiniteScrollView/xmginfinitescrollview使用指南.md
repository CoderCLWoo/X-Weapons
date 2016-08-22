# XMGInfiniteScrollView
### 无限循环轮播图控件

- 使用方法

```
#import "ViewController.h"
#import "XMGInfiniteScrollView.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMGInfiniteScrollView *scrollView = [[XMGInfiniteScrollView alloc] init];
    scrollView.frame = CGRectMake(30, 50, 300, 130);
    scrollView.images = @[
                          [UIImage imageNamed:@"img_00"],
                          [UIImage imageNamed:@"img_01"],
                          [UIImage imageNamed:@"img_02"],
                          [UIImage imageNamed:@"img_03"],
                          [UIImage imageNamed:@"img_04"]
                          ];
    scrollView.pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    scrollView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
}
@end

```
