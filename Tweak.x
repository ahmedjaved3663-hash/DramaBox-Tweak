#import <UIKit/UIKit.h>

// 1. Force every chapter to report as 'Free' and 'Unlocked'
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (BOOL)is_pay { return NO; }
- (NSInteger)coin_price { return 0; }
- (NSInteger)vip_price { return 0; }
%end

// 2. Bypass the Video Player's internal check
%hook STVideoPlayerController
- (BOOL)is_need_pay { return NO; }
- (BOOL)checkEpisodeUnlocked:(id)arg1 { return YES; }
%end

// 3. Prevent the 'Buy Coins' popup from appearing
%hook STPayViewController
- (void)show { return; } 
%end

%ctor {
    // Wait for the app to initialize its models before we hook them
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
