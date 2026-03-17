#import <UIKit/UIKit.h>

// Force VIP and Coins
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 99999; }
- (BOOL)isSubscriptionActive { return YES; }
%end

// Force Unlock Episodes
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)hasPaid { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)unlockType { return 0; }
%end

// Disable the Paywall pop-up
%hook DBPayManager
- (BOOL)isEpisodeUnlocked:(id)arg1 { return YES; }
%end

%ctor {
    %init;
    
    // Modern Alert for iOS 13+ to avoid the 'keyWindow' error
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                    window = ((UIWindowScene *)scene).windows.firstObject;
                    break;
                }
            }
        }
        
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mod Status" 
                message:@"DramaBox Hack Loaded Successfully!" 
                preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Enjoy" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
