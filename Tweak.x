#import <UIKit/UIKit.h>

// 1. Intercept the Purchase Manager - This is the most important part
%hook DBPurchaseManager
- (BOOL)isChapterUnlocked:(id)arg1 { return YES; }
- (void)buyChapter:(id)arg1 completion:(id)arg2 {
    // This tells the app the purchase was successful immediately
    void (^completionBlock)(BOOL, id) = arg2;
    if (completionBlock) {
        completionBlock(YES, nil);
    }
}
%end

// 2. Force the Video Player to ignore the "Locked" status
%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)hasPaid { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)price { return 0; }
%end

// 3. Keep the UI looking correct
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 99999; }
- (BOOL)isPremium { return YES; }
%end

%ctor {
    %init;
    // Removed the alert to prevent interference with video loading
}
