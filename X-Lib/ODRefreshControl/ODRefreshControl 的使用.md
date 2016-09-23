# ODRefreshControl 的使用

*	创建方法
	
	```
	// 先 #import "ODRefreshControl.h"
ODRefreshControl *refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
	```
*	下拉刷新方法
	
	```
	- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl {
	    // 此处模拟网络请求数据，添加一个延时
	    double delayInSeconds = 3.0;
	    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
	        [refreshControl endRefreshing];
	        //TODO: 向服务器请求数据，刷新界面
	    });
}
	```
	