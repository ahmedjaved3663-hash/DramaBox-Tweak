#import <UIKit/UIKit.h>

// --- DECLARATIONS FOR COMPILER ---
@interface STPayViewController : UIViewController
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end

@interface STUserCenter : NSObject
@end

@interface STChapterModel : NSObject
@end

@interface STSubscriptionManager : NSObject
@end

// --- THE HOOKS ---

// 1. Force Subscription Status
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
- (NSString *)vip_expire_time { return @"2099-12-31"; }
%end

// 2. Bypass Expiration Logic
%hook STSubscriptionManager
- (BOOL)isExpired { return NO; }
- (BOOL)checkSubscriptionStatus { return YES; }
%end

// 3. Unlock Chapters (APK Logic)
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

// 4. Force Dismiss Paywall (Fixes IMG_0168.jpg)
%hook STPayViewController
- (void)viewDidLoad { 
    %orig; 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}
%end

%ctor {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
