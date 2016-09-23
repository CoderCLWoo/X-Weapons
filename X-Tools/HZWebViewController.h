//
//  HZWebViewController.h
//  WebViewTest
//
//  Created by wangxi1-ps on 15/9/22.
//  Copyright © 2015年 x. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
@interface XToolBar : UIToolbar {}@end

@interface HZWebViewController : CommonViewController

@property(nonatomic,strong) NSString *type ;
- (instancetype)initWithUrl:(NSString *)url;

- (void)loadUrl:(NSString *)url;

- (void)loadHTMLString:(NSString *)string baseURL:(NSString *)baseURL;

@end
