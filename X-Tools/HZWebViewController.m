//
//  HZWebViewController.m
//  WebViewTest
//
//  Created by wangxi1-ps on 15/9/22.
//  Copyright © 2015年 x. All rights reserved.
//

#import "HZWebViewController.h"
#import "QHVWebView.h"
#import "viewconfig.h"
//#import <OnePasswordExtension.h>

#define kNavBarHeight                   44
#define kTooBarHeight                   44

@implementation XToolBar
- (UIImage *)createImage:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
- (void)drawRect:(CGRect)rect {

    [[self createImage:[UIColor whiteColor]] drawInRect:rect];
}
@end



@interface HZWebViewController ()<QHVWebViewDelegate,UIActionSheetDelegate>

@property (nonatomic,copy) NSURL *url;
@property (nonatomic,strong) QHVWebView *webview;
@property (nonatomic,strong) XToolBar *toolbar;

@property (strong, nonatomic) UIBarButtonItem *stopLoadingButton;
@property (strong, nonatomic) UIBarButtonItem *reloadButton;
@property (strong, nonatomic) UIBarButtonItem *backButton;
@property (strong, nonatomic) UIBarButtonItem *forwardButton;

@end

@implementation HZWebViewController

- (instancetype)initWithUrl:(NSString *)url{

    self = [super init];
    if(self){
        self.url = [NSURL URLWithString:url];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webview];
    [self initControls];
    
    [self load];
    if (!self.type) {
        self.navTitle = @"本品暂不支持一键海淘，请自行购买" ;
    }else{
    
        self.navTitle = self.type ;
    }

}


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{

    [self clear];

}

- (void)initControls{

    CGRect webViewRect = self.view.frame;
    webViewRect = CGRectMake(webViewRect.origin.x, self.navHeight, webViewRect.size.width, webViewRect.size.height-kTooBarHeight-self.navHeight);
    self.webview.frame = webViewRect;
    [self initToolbar];
}

- (void)initToolbar{
    
    self.stopLoadingButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shan"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self.webview
                                                             action:@selector(stopLoading)];
    
    self.reloadButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shuaxin"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(reload)];
    
    
    self.backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hou"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self.webview
                                                      action:@selector(goBack)];
    
    self.forwardButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"qian"]
                                                          style:UIBarButtonItemStylePlain
                                                         target:self.webview
                                                         action:@selector(goForward)];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"houtui"]
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(back)];
    
    UIBarButtonItem *shareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"liulanqi"]
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(share)];
    
    UIBarButtonItem *space_ = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                            target:nil
                                                                            action:nil];
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    
    self.toolbarItems = @[backItem,space_,self.stopLoadingButton, space_, self.backButton, space_, self.forwardButton, space_, shareButton];
    [self.toolbar setItems:self.toolbarItems animated:YES];
    self.toolbar.tintColor = UIColorFromRGB(0xe51f28);
    [self.view addSubview:self.toolbar];
}



- (void)loadHTMLString:(NSString *)string baseURL:(NSString *)baseURL{

    NSURL *url = [NSURL URLWithString:baseURL];
    [self.webview loadHTMLString:string baseURL:url];
}

- (void)loadUrl:(NSString *)url{
    if(url){
        self.url = [NSURL URLWithString:url];
        [self.webview loadURL:self.url];
    }
}

#pragma mark Private Interface
- (void)load{
    if(self.url){
        [self.webview loadURL:self.url];
    }
    
}
- (void)clear{
    
    [self.webview loadHTMLString:@"" baseURL:nil];
    self.title = @"";
    self.type = nil ;
   
}

- (void)toggleState{
    
    UIWebView *hzwebview = (id)[self.webview getWebView];
    self.backButton.enabled = hzwebview.canGoBack;
    self.forwardButton.enabled = hzwebview.canGoForward;
    
    NSMutableArray *toolbarItems = [self.toolbarItems mutableCopy];
    if (self.webview.isLoading) {
        toolbarItems[2] = self.stopLoadingButton;
    } else {
        toolbarItems[2] = self.reloadButton;
    }
    self.toolbarItems = [toolbarItems copy];
    [self.toolbar setItems:self.toolbarItems animated:YES];
}

- (void)finishLoad{
    
    [self toggleState];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark Event

- (void)reload {

    UIWebView *hzwebview = (id)[self.webview getWebView];
    [hzwebview reload];
}

- (void)back{
    
    
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count == 1) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    
   
}

- (void)share{

        
        UIActionSheet *moreSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"用Safari打开",@"复制链接", nil];
        [moreSheet showInView:self.view];
        

}


#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(actionSheet.cancelButtonIndex == buttonIndex){
        return;
    }
    if(!self.url){
        return;
    }
    switch (buttonIndex) {
        case 0:{
            [[UIApplication sharedApplication] openURL:self.url];
        }
            break;
        case 1:{
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            pasteboard.string = self.url.absoluteString;
        }
            break;
        case 2:{//1password
            
//            [[OnePasswordExtension sharedExtension] fillLoginIntoWebView:[self.webview getWebView] forViewController:self sender:actionSheet completion:^(BOOL success, NSError *error) {
//                if (!success) {
//                    HKDLog(@"Failed to fill login in webview: <%@>", error);
//                }
//            }];
        }
            break;
        default:
            break;
    }
}

#pragma mark QHVWebViewDelegate

- (void)webView:(QHVWebView *)webView didStartLoadingURL:(NSURL *)URL{

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self toggleState];
    
    if ([[URL absoluteString] hasPrefix:@"sms:"]) {
        [[UIApplication sharedApplication] openURL:URL];
        [webView stopLoading];
        return ;
    }
    
    if ([[URL absoluteString] hasPrefix:@"http://www.youtube.com/v/"] ||
        [[URL absoluteString] hasPrefix:@"http://itunes.apple.com/"] ||
        [[URL absoluteString] hasPrefix:@"https://itunes.apple.com/"] ||
        [[URL absoluteString] hasPrefix:@"http://phobos.apple.com/"]) {
        [[UIApplication sharedApplication] openURL:URL];
        [webView stopLoading];
        return ;
    }

}
- (void)webView:(QHVWebView *)webView didFinishLoadingURL:(NSURL *)URL{
//
    [self finishLoad];
//    self.title = [webView evaluateJavaScriptFromString:@"document.title"];
    self.url = URL;
}
- (void)webView:(QHVWebView *)webView didFailToLoadURL:(NSURL *)URL error:(NSError *)error{
    [self finishLoad];
}

#pragma mark - getters and setters
- (QHVWebView *)webview{

    if(!_webview){
    
        _webview = [[QHVWebView alloc] initWithFrame:self.view.bounds];
        _webview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webview.delegate = self;
    }
    return _webview;
}

- (XToolBar *)toolbar{

    if(!_toolbar){
    
        _toolbar = [[XToolBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-kTooBarHeight, self.view.bounds.size.width, kTooBarHeight)];
        _toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        [_toolbar setBarStyle:UIBarStyleBlackTranslucent];
        _toolbar.backgroundColor = [UIColor clearColor];
    
    }

    return _toolbar;
}

@end
