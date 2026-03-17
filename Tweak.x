#import <UIKit/UIKit.h>

// 1. Force the Video Detail to think it is authorized
%hook DBVideoDetailModel
- (BOOL)isCanPlay { return YES; }
- (BOOL)isVipVideo { return NO; }
- (BOOL)isUnlock { return YES; }
%end

// 2. Force the Player to skip the "Check"
%hook DBVideoPlayerController
- (BOOL)shouldShowPayWall { return NO; }
- (void)setShouldShowPayWall:(BOOL)arg1 { %orig(NO); }
- (BOOL)isTrial { return NO; }
%end

// 3. Fake a successful Purchase result globally
%hook DBPurchaseManager
- (BOOL)isChapterUnlocked:(id)arg1 { return YES; }
- (void)checkChapterStatus:(id)arg1 completion:(void (^)(BOOL unlocked, id error))completion {
    if (completion) {
        completion(YES, nil);
    }
}
%end

// 4. Set UI Balance for visual confirmation
%hook DBUserModel
- (NSInteger)coins { return 88888; }
- (BOOL)isVip { return YES; }
%end

%ctor {
    %init;
}
