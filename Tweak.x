#import <UIKit/UIKit.h>

// 1. Force User to look like a paying subscriber
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 5555; }
- (BOOL)isSubscriptionActive { return YES; }
%end

// 2. Force the Episode Manager to see everything as "Already Bought"
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)canWatch { return YES; }
- (BOOL)isFree { return YES; }
- (BOOL)hasPaid { return YES; } // This tells the server-check to skip
- (NSInteger)unlockType { return 0; } // 0 = Already Unlocked
%end

// 3. Force the Pay-Wall to stay hidden
%hook DBVideoPlayerController
- (BOOL)shouldShowPayWall { return NO; }
- (void)setShouldShowPayWall:(BOOL)arg1 { %orig(NO); }
%end

// 4. Force the "Is Playable" check to always return YES
%hook DBVideoModel
- (BOOL)isLocked { return NO; }
- (BOOL)isVipOnly { return NO; }
- (BOOL)isPayVideo { return NO; }
%end

%ctor {
    %init;
}
