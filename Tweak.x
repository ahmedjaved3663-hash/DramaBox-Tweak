#import <UIKit/UIKit.h>

// 1. Force the Subscription to always be "Active" locally
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
- (NSString *)vip_expire_time { return @"2099-12-31"; }
%end

// 2. Kill the "Expired" Popup logic
%hook STSubscriptionManager
- (BOOL)isExpired { return NO; }
- (BOOL)checkSubscriptionStatus { return YES; }
%end

// 3. Force the Episode to be "Unlocked" (APK Logic)
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

// 4. Prevent the "Subscribe Now" screen from showing
%hook STPayViewController
- (void)show { return; }
- (void)viewDidLoad { %orig; [self dismissViewControllerAnimated:NO completion:nil]; }
%end

%ctor {
    // Wait 4 seconds for the "Expired" check to finish, then we overwrite it
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
