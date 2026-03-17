#import <UIKit/UIKit.h>

// 1. Hooking every possible User property name for 3.1.4
%hook SDUserModel
- (NSInteger)coins { return 999999; }
- (NSInteger)balance { return 999999; }
- (BOOL)isVip { return YES; }
%end

%hook ALUserModel
- (NSInteger)coins { return 999999; }
- (BOOL)isVip { return YES; }
%end

// 2. Targeting the Chapter/Episode logic
%hook SDChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)price { return 0; }
%end

%hook ALChapterModel
- (BOOL)isUnlocked { return YES; }
- (NSInteger)price { return 0; }
%end

// 3. The "Last Resort" - Forcing the Player to bypass checks
%hook SDVideoPlayer
- (BOOL)isEpisodeUnlocked:(id)arg1 { return YES; }
%end

%ctor {
    // Wait for the app to fully load before injecting
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
