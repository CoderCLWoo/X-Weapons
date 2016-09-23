//
//  XTool.m
//  mgpyh
//
//  Created by x on 13-10-27.
//  Copyright (c) 2013年 x. All rights reserved.
//

#import "XTool.h"
#import "UtilitiesMacro.h"
#import "HZWebViewController.h"

//设置扩展属性
#include <sys/xattr.h>

@implementation XTool

+(void)openWebBrowser:(NSString *)url Controller:(UIViewController *)controller type:(NSString *)type{
    HZWebViewController *webViewController = [[HZWebViewController alloc] initWithUrl:url];
    webViewController.type = type ;
    [controller presentViewController:webViewController animated:YES completion:nil];
    webViewController = nil ;
    
}

+ (NSString *)htmlToText:(NSString *)urlString {
    XTool *tool = [[self alloc] init];
    
    return [tool filterHTML:urlString];
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
    return html;
}

//获取当前的viewcontroller
+ (UIViewController *)getCurrentRootViewController {
    
    UIViewController *result;
    
    // Try to find the root view controller programmically
    
    // Find the top window (that is not an alert view or other window)
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
	
    NSLog(@"result@ == %@",result);
    return result;
}


+(void)openWebBrowser:(NSString *)url Controller:(UIViewController *)controller
{
    HZWebViewController *webViewController = [[HZWebViewController alloc] initWithUrl:url];
    [controller.navigationController pushViewController:webViewController animated:YES];
    webViewController = nil ;
}

//app的版本
+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)flattenHTML:(NSString *)html {
  
  NSString *text = nil;
  NSScanner *thescanner = [NSScanner scannerWithString:html];
  
  while ([thescanner isAtEnd] == NO) {
    
    // find start of tag
    [thescanner scanUpToString:@"<" intoString:NULL];
    
    // find end of tag
    [thescanner scanUpToString:@">" intoString:&text] ;
    
    // replace the found tag with a space
    //(you can filter multi-spaces out later if you wish)
    html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@" "];
  } // while //
  
  return html;
}

////html转换为text
//+ (NSString *)htmlToText:(NSString *)urlString{
//    
//    if(urlString.length <= 0)
//        return nil;
//    
//    NSString *regEx_script = @"<[\\s]*?script[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?script[\\s]*?>";
//    // 定义script的正则表达式.
//    NSString *regEx_style = @"<[\\s]*?style[^>]*?>[\\s\\S]*?<[\\s]*?\\/[\\s]*?style[\\s]*?>";
//    // 定义style的正则表达式.
//    NSString *regEx_html = @"<[^>]+>";
//    // 定义HTML标签的正则表达式
//    NSString *regEx_houhtml = @"/[^>]+>";
//    // 定义HTML标签的正则表达式
//    NSString *regEx_spe = @"\\&[^;]+;";
//    // 定义特殊符号的正则表达式
//    NSString *regEx_blank = @" +";
//    // 定义多个空格的正则表达式
//    NSString *regEx_table = @"\t+";
//    // 定义多个制表符的正则表达式
//    NSString *regEx_enter = @"\n+";
//    // 定义多个回车的正则表达式
//    
//    //替换标签
//    NSString *textStr = [urlString stringByReplacingOccurrencesOfRegex:regEx_script withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_style withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_html withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_houhtml withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_spe withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_blank withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_table withString:@""];
//    textStr = [textStr stringByReplacingOccurrencesOfRegex:regEx_enter withString:@""];
//    if(textStr)
//        return textStr;
//    else
//        return urlString;
//}

//手机机型
+ (NSString *)deviceModel
{
    UIDevice *dev = [UIDevice currentDevice];
    return dev.model;
}
//MD5编码
+ (NSString *)md5String:(NSString *)string
{
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];  
}
+ (NSString *)pathWithDocuments
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}
// 创建多级目录
+ (BOOL)createDirectoriesAtPath:(NSString *)inPath
                     attributes:(NSDictionary *)inAttributes
{
    NSArray *components = [inPath pathComponents];
    int i;
    BOOL result = YES;
    
    for (i = 1 ; i <= [components count] ; i++ ) {
        NSArray *subComponents = [components subarrayWithRange:
                                  NSMakeRange(0,i)];
        NSString *subPath = [NSString pathWithComponents:subComponents];
        BOOL isDir;
        BOOL exists = [[NSFileManager defaultManager]
                       fileExistsAtPath:subPath isDirectory:&isDir];
        
        if (!exists) {
            result = [[NSFileManager defaultManager]
                      createDirectoryAtPath:subPath
                      withIntermediateDirectories:YES
                      attributes:inAttributes
                      error:nil];
            if (!result)
                return result;
        }
    }
    return result;
}
+ (UIImage *)createImage:(UIColor *)color
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

/**
 *  计算字符串显示在指定的界面上的时候
 *
 *  @param text  需要计算的文字
 *  @param font  字体
 *  @param width 文字显示在界面上的宽度
 *
 *  @return 返回字符串显示在界面上所需要的宽和高
 */
+ (CGSize)textSizeWith:(NSString *)text Font:(UIFont *)font ShowWidth:(CGFloat)width
{
  CGSize textSize;
#if  __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [text boundingRectWithSize:CGSizeMake(width, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    textSize.height = ceil(labelSize.height);
    textSize.width = ceil(labelSize.width);
#else
    textSize = [text sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#endif
  return textSize;
}


+ (NSString *)switchTime:(NSString*)dataTime DataFormat:(NSString *)format
{
    if(!dataTime || dataTime.length <=0)
        return @"1天";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"shanghai"];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:format];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss S"];//YYYY 根据系统不一样，会导致计算差一年
    NSDate* date = [dateFormatter dateFromString:dataTime];
    return  [self switchDateTime:date];
}

+ (NSString *)switchDateTime:(NSDate *)date
{
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    NSUInteger time = 0;
    NSString *timeStamp;
    if (timeInterval < 60)
    {
        timeStamp = [NSString stringWithFormat:@"刚刚"];
    }
    else if ((time = timeInterval / 60) < 60)
    {
        timeStamp = [NSString stringWithFormat:@"%lu分钟前", (unsigned long)time];
    }
    else if ((time = time / 60) < 24)
    {
        timeStamp = [NSString stringWithFormat:@"%lu小时前", (unsigned long)time];
    }
    else if ((time = time / 24) < 30)
    {
        timeStamp = [NSString stringWithFormat:@"%lu天前", (unsigned long)time];
    }
    else if ((time = time / 30) < 12)
    {
        timeStamp = [NSString stringWithFormat:@"%lu月前", (unsigned long)time];
    }
    else
    {
        time = time / 12;
        timeStamp = [NSString stringWithFormat:@"%lu年前", (unsigned long)time];
    }
    return timeStamp;
}

+ (NSString *)nowTime
{
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    df.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"shanghai"];
    [df setDateFormat:@"yyyy年MM月dd日 HH小时mm分ss秒"];
    return  [df stringFromDate:currentDate];
}

+(NSString *)timeFormat:(NSString *)strTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"shanghai"];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zz"];
    NSDate* date = [dateFormatter dateFromString:strTime];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    return  [dateFormatter stringFromDate:date];
}
+(NSString *)stringWith:(NSDate *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"shanghai"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:time];
    return destDateString;
}

+(NSString *)cachePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}

//获取iPhone6大屏的对应尺寸
+ (CGFloat)covertiPhone6SizeFromOldSize:(CGFloat)size{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    CGFloat newSize = width > height ? height : width;
    CGFloat oldSize = 320.0f;
    CGFloat nSize = newSize / oldSize * size;
    return nSize;
}

//设置扩展属性(移除文件的iCloud自动备份属性)
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    const char* filePath = [[URL path] fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}

@end
