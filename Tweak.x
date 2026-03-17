#import <UIKit/UIKit.h>

%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 999999; }
- (BOOL)isSubscriptionActive { return YES; }
%end

%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)canWatch { return YES; }
- (BOOL)isFree { return YES; }
%end

%hook DBAdManager
- (BOOL)shouldShowAd { return NO; }
- (void)showRewardVideoAd:(id)arg1 { return; }
%end

%ctor {
    %init;
}
