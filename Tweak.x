#import <UIKit/UIKit.h>

// 1. Hook the Global Config - This is the "Master Switch"
%hook DBConfigModel
- (BOOL)isReview { return YES; } // Makes the app think it's in 'Review Mode' (often unlocks everything)
- (BOOL)isHideVip { return NO; }
%end

// 2. Hook the Pay Manager - This stops the "Buy" popup from triggering
%hook DBPayManager
- (BOOL)isEpisodeUnlocked:(id)arg1 { return YES; }
- (void)checkEpisodeStatus:(id)arg1 completion:(id)arg2 {
    // This forces the "Check" to always return 'Success'
    typedef void (^CDUnknownBlockType)(BOOL, id);
    CDUnknownBlockType completionBlock = (CDUnknownBlockType)arg2;
    if (completionBlock) {
        completionBlock(YES, nil);
    }
}
%end

// 3. Hook the Video Model - Specifically for v5.4.0
%hook DBVideoModel
- (BOOL)isLocked { return NO; }
- (BOOL)isLimit { return NO; }
- (NSInteger)limitType { return 0; }
- (BOOL)canPlay { return YES; }
%end

// 4. Hook the User for Coins/VIP (Simplified)
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 9999; }
%end

%ctor {
    %init;
}
