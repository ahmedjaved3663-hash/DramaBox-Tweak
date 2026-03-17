#import <UIKit/UIKit.h>

// 1. Force the Play Manager to see all videos as "Authorized"
%hook DBVideoPlayerManager
- (BOOL)isCanPlayWithChapter:(id)arg1 { return YES; }
- (BOOL)checkIsUnlockedWithChapter:(id)arg1 { return YES; }
%end

// 2. Suppress the Purchase Pop-up at the root level
%hook DBPayWallView
- (void)showInView:(id)arg1 { return; } // This stops the window from ever appearing
%end

// 3. Fake the Server Response for Chapter Status
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)isFree { return YES; }
- (BOOL)hasPaid { return YES; }
- (NSInteger)unlockType { return 0; }
%end

// 4. Force UI to show Coins (to verify the Tweak is loaded)
%hook DBUserModel
- (NSInteger)coins { return 77777; }
- (BOOL)isVip { return YES; }
%end

%ctor {
    %init;
}
