//
//  KSBaseHtmlController.m
//  KSLolTool
//
//  Created by xiaoshi on 16/3/17.
//  Copyright © 2016年 https://github.com/shijinliang, http://blog.csdn.net/sjl_leaf. All rights reserved.
//

#import "KSBaseHtmlController.h"

@interface KSBaseHtmlController ()<UIWebViewDelegate>
{
    BOOL _isFirstRequest;
}
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) WebType webType;
@property (nonatomic, strong) NSString *htmlStr;

@end

@implementation KSBaseHtmlController

- (void)setWebViewWithWebType:(WebType)webType urlString:(NSString *)url htmlString:(NSString *)html title:(NSString *)title
{
    self.webType = webType;
    self.urlStr = url;
    self.htmlStr = html;
    self.titleStr = title;
    switch (_webType) {
        case WebTypeUrl: {
            [self setWebViewWithUrlString:_urlStr];
            break;
        }
        case WebTypeHtml: {
            [self setWebViewWithHtml:_htmlStr];
            break;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    _isFirstRequest = YES;
    [self.view addSubview:self.webView];
    if (!isEmptyString(_urlStr)) {
        [self setWebViewWithUrlString:_urlStr];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setWebViewWithHtml:(NSString *)htmlStr
{
    [self.webView loadHTMLString:htmlStr baseURL:nil];
}

- (void)setWebViewWithUrlString:(NSString *)urlStr
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - webview delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSString *document = [webView stringByEvaluatingJavaScriptFromString:@"document"];
    if (isEmptyString(self.title)) {
        self.title = title;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"didFailLoadWithError:%@", error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是第一次打开，第一次打开url，对url进行处理
    if (_isFirstRequest) {
        
        //获取网页错误码，
        NSHTTPURLResponse *response = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
        
        if (response.statusCode >= 400 ) {
            self.webView.hidden = YES;
            [self setNoDataViewHide:NO];
            return NO;
        } else{
            self.webView.hidden = NO;
        }
        NSString *s = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        s = [s stringByReplacingOccurrencesOfString:@"捞月狗" withString:ProductName];
        _isFirstRequest = NO;
        [webView loadHTMLString:s baseURL:nil];
        return NO;
    }
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        NSString *url = [[request URL] absoluteString];
        [self openNewView:url];
        return NO;
    }
    return YES;
}

- (void)openNewView:(NSString *)url
{
    
}

#pragma mark - 懒加载
- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height - 64)];
        _webView.delegate = self;
        _webView.scalesPageToFit = NO;
        
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _webView;
}


@end
