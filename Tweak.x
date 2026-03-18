#import <UIKit/UIKit.h>

// --- USER WALLET HOOKS ---
// We target multiple prefixes to ensure we hit the 3.1.4 names
%hook DBUserModel
- (NSInteger)remaining_coins { return 999999; }
- (BOOL)is_vip { return YES; }
%end

%hook STUserModel
- (NSInteger)remaining_coins { return 999999; }
- (BOOL)is_vip { return YES; }
%end

%hook SDUserModel
- (NSInteger)coins { return 999999; }
- (BOOL)isVip { return YES; }
%end

// --- EPISODE UNLOCK HOOKS ---
// This is what makes the videos playable
%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%ctor {
    // Wait for the app to finish its initial connection
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
