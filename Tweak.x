#import <UIKit/UIKit.h>

// 1. Force the Purchase Manager to "finish" every transaction instantly
%hook DBPurchaseManager
- (BOOL)isChapterUnlocked:(id)arg1 { return YES; }

// This targets the specific callback method used in v5.4.0
- (void)buyChapter:(id)arg1 completion:(id)completion {
    // We define the block structure the app expects (success bool, error object)
    void (^completionBlock)(BOOL success, id error) = completion;
    if (completionBlock) {
        // We tell the app: Success = YES, Error = nil
        completionBlock(YES, nil);
    }
}
%end

// 2. Remove the "Locked" status from the Video Model
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)hasPaid { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)unlockType { return 0; }
%end

// 3. Keep the User UI showing High Coins and VIP status
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (BOOL)isPremium { return YES; }
- (NSInteger)coins { return 88888; }
- (BOOL)vipLevel { return 10; }
%end

%ctor {
    %init;
}
