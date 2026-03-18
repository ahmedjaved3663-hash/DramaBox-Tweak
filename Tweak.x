#import <UIKit/UIKit.h>

// 1. Force the Episode itself to report as "Unlocked" and "Free"
%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (BOOL)is_pay { return NO; }
- (NSInteger)coin_price { return 0; }
- (NSInteger)vip_price { return 0; }
%end

// 2. Bypass the Video Player's internal authorization check
%hook DBVideoPlayerController
- (BOOL)is_need_pay { return NO; }
- (BOOL)checkEpisodeUnlocked:(id)arg1 { return YES; }
- (void)showPayWall { return; } // This kills the popup completely
%end

// 3. User Model - Force VIP status for Guest account
%hook DBUserModel
- (BOOL)is_vip { return YES; }
- (NSInteger)remaining_coins { return 1; } // Keeping it at 1 to match your APK
%end

%ctor {
    // We wait 4 seconds for the app to finish its initial network handshake
    // before we "hijack" the video permission logic.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
