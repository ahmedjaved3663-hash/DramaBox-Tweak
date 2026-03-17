#import <UIKit/UIKit.h>

// 1. User Status: Tells the app you have a paid subscription
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 8888; } // Use a lower, safer number
- (BOOL)isSubscriptionActive { return YES; }
- (NSInteger)vipLevel { return 10; }
%end

// 2. Episode Logic: Tells the app the video is free and unlocked
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)canWatch { return YES; }
- (BOOL)isFree { return YES; }
- (BOOL)hasPaid { return YES; }
- (NSInteger)unlockType { return 0; } // 0 usually means 'Free' or 'Already Unlocked'
- (NSInteger)price { return 0; }
%end

// 3. Ad Manager: Block ads that might trigger when you play a video
%hook DBAdManager
- (BOOL)shouldShowAd { return NO; }
- (void)showRewardVideoAd:(id)arg1 { return; }
%end

%ctor {
    %init;
}
