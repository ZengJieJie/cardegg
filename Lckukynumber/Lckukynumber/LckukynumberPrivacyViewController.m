//
//  OperationPrivacyViewController.m
//  LckukyNumber Poker
//
//  Created by LckukyNumber Poker on 2024/8/19.
//

#import "LckukynumberPrivacyViewController.h"
#import <WebKit/WebKit.h>
#import <Adjust/Adjust.h>
#import "Masonry/Masonry.h"
#import "LckukynumberWWebViJBri.h"

@interface LckukynumberPrivacyViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIImageView *bg;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) LckukynumberWWebViJBri *bridge;

@end

@implementation LckukynumberPrivacyViewController

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSubViews];
    [self loadWebView];
}

- (void)loadWebView
{
    [self.activityIndicator startAnimating];
    if (self.url.length > 0) {
        self.btnClose.hidden = YES;
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
        [self.webView loadRequest:request];
    } else {
        NSURL *urlR = [NSURL URLWithString:@"https://tinyurl.com/LuckyCalculation-Poker"];
        if (urlR) {
            NSURLRequest *request = [NSURLRequest requestWithURL:urlR];
            [self.webView loadRequest:request];
        }
    }
}

- (void)initSubViews {
    self.bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"im_bg"]];
    self.bg.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bg];
    [self.bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds configuration:config];
    self.webView.hidden = YES;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        make.left.right.equalTo(self.view);
    }];
    
    [LckukynumberWWebViJBri enableLogging];
    self.bridge = [LckukynumberWWebViJBri bridForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"adjustEvent" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"adjustEvent111");
        if ([data isKindOfClass:[NSDictionary class]]) {
            NSDictionary *params = (NSDictionary *)data;
            if ([params[@"event"] isEqualToString:@"getadid"]) {
                NSDictionary *callback = @{@"recode": [Adjust adid]};
                if (responseCallback) {
                    NSLog(@"success");
                    responseCallback(callback);
                }
            }
        }
    }];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    self.activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator.color = [UIColor whiteColor];
    [self.view addSubview:self.activityIndicator];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
    }];
    
    self.btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnClose setBackgroundImage:[UIImage imageNamed:@"bback"] forState:UIControlStateNormal];
    [self.btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnClose];
    [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(30);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}

- (void)btnCloseClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bg.hidden = YES;
        self.webView.hidden = NO;
        [self.activityIndicator stopAnimating];
    });
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.bg.hidden = YES;
        self.webView.hidden = NO;
        [self.activityIndicator stopAnimating];
    });
}

#pragma mark - WKUIDelegate
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    if (!navigationAction.targetFrame) {
        NSURL *url = navigationAction.request.URL;
        if (url) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
    return nil;
}

@end
