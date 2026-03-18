#import <UIKit/UIKit.h>

// 1. Force the Episode itself to report as "Free" and "Unlocked"
%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (BOOL)is_pay { return NO; }
- (NSInteger)coin_price { return 0; }
%end

// 2. Bypass the Video Player's "Permission" check
%hook DBVideoPlayerController
- (BOOL)is_need_pay { return NO; }
- (BOOL)checkEpisodeUnlocked:(id)arg1 { return YES; }
%end

// 3. This kills the 'Purchase' popup if it tries to appear
%hook DBPayViewController
- (void)show { return; } 
%end

%ctor {
    // We wait 3 seconds to let the app load its server data first,
    // then we overwrite that data with our "Unlocked" values.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
