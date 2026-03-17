#import <UIKit/UIKit.h>

// 1. Force User Status
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 5555; }
- (BOOL)isSubscriptionActive { return YES; }
%end

// 2. Force Episode/Chapter to be 'Purchased'
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)canWatch { return YES; }
- (BOOL)isFree { return YES; }
- (BOOL)hasPaid { return YES; }
- (NSInteger)unlockType { return 0; }
%end

// 3. SERVER BYPASS: This forces the server's 'is_locked' response to be false
%hook DBVideoModel
- (BOOL)isLocked { return NO; }
- (BOOL)isVipOnly { return NO; }
%end

// 4. PLAYER BYPASS: Tells the player the video is authorized
%hook DBVideoPlayerController
- (BOOL)shouldShowPayWall { return NO; }
- (BOOL)isPlayable { return YES; }
%end

%ctor {
    %init;
}
