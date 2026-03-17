#import <UIKit/UIKit.h>

// 1. Force the User into a "Paid" state
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 5000; }
- (BOOL)isSubscriptionActive { return YES; }
%end

// 2. Force the Episode to think it is already bought
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)canWatch { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)unlockType { return 0; } // 0 = Free
- (NSInteger)price { return 0; }
%end

// 3. The "Deep Hook": Target the Player directly
%hook DBVideoPlayerModel
- (BOOL)isTrial { return NO; } // Disables the "Trial only" mode
- (BOOL)needsUnlock { return NO; }
- (void)setNeedsUnlock:(BOOL)arg1 { %orig(NO); }
%end

%hook DBVideoDetailModel
- (BOOL)isVipVideo { return NO; } // Tells the player this isn't a restricted video
%end

%ctor {
    %init;
}
