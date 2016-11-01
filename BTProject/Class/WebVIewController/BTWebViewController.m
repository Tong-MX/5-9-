//
//  BTWebViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/5.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTWebViewController.h"
#import "WebViewJavascriptBridge.h"
@interface BTWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *bTWebView;
@property WebViewJavascriptBridge* bridge;
@end

@implementation BTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarProperty];
    [self creatWebUI];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.view addGestureRecognizer:pan];
}

- (void)action:(UIPanGestureRecognizer*)pan {
//    [self backAction];
}
#pragma mark 创建的导航栏

- (void)setNavigationBarProperty {
    [self.view bringSubviewToFront: self.navigationBar];
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    
    [self setNavigationBarTitleText:_titleStr Color:UIColorC3 Font:UISystemFontT6 Bold:15];
    [self setNavigationBarLeftButtonBgImg:[UIImage imageNamed:@"top_back_icon"] TouchImg:nil Text:@""];
    [self alphaNav:1.f];
}

- (void)creatWebUI {
    self.bTWebView = [[UIWebView alloc] initWithFrame:CGRectMake(BTZero, 64, HKUIScreenWidth, HKUIScreenHeight - 64)];
    self.bTWebView.delegate = self;
    NSMutableURLRequest* request;
    if (self.type == 1) {
        request = [NSMutableURLRequest requestWithURL:[NSURL fileURLWithPath:self.url]];
    }else {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    }
    [self.bTWebView loadRequest:request];
    self.bTWebView.scalesPageToFit = YES;
    self.bTWebView.mediaPlaybackAllowsAirPlay = NO;
    self.bTWebView.mediaPlaybackRequiresUserAction = NO;
    [self.view addSubview:self.bTWebView];
    
    [WebViewJavascriptBridge enableLogging];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.bTWebView webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        
    }];
    
    [self registerHandler];
}

#pragma mark - UIWebViewDelegate 方法

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self showWaitProgressAsyn:@""];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self hiddenWaitProgressAsyn];
    NSString* jsCode = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://d.beauty.xiaolinxiaoli.com/app_js.txt"] encoding:NSUTF8StringEncoding error:nil];
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self hiddenWaitProgressAsyn];
}

- (void)registerHandler {
    
}

- (void)leftButtonAction {

    if (_bTWebView.canGoBack) {
        [self.bTWebView goBack];
    }else {
        [super leftButtonAction];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
