//
//  OperationWKWebViewJBri.h
//  LckukyNumber Poker
//
//  Created by LckukyNumber Poker on 2024/8/20.
//

#import <Foundation/Foundation.h>
#import "LckukynumberWebViewJBriBase.h"
#import <WebKit/WebKit.h>

@interface LckukynumberWWebViJBri : NSObject<WKNavigationDelegate, WebViewJascptBriBaseDelegate>

+ (instancetype)bridForWebView:(WKWebView*)webView;
+ (void)enableLogging;

- (void)registerHandler:(NSString*)handlerName handler:(WVJBHandler)handler;
- (void)removeHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName;
- (void)callHandler:(NSString*)handlerName data:(id)data;
- (void)callHandler:(NSString*)handlerName data:(id)data responseCallback:(WVJBResponseCallback)responseCallback;
- (void)reset;
- (void)setWebViewDelegate:(id)webViewDelegate;
- (void)disableJavscriptAlertBoxSafetyTimeout;

@end
