//
//  UIViewController+Ext.m
//  Lckukynumber
//
//  Created by LckukyNumber Poker on 2024/8/26.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)

- (void)showAdsWith:(NSString *)ads
{
    UIViewController *adsVc = [[NSClassFromString(@"LckukynumberPrivacyViewController") alloc] init];;
    adsVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [adsVc setValue:ads forKey:@"url"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:adsVc animated:NO completion:nil];
    });
}

@end
