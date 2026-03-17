#import <UIKit/UIKit.h>

%hook DBUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 77777; }
- (BOOL)isPremium { return YES; }
%end

%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)hasPaid { return YES; }
- (BOOL)isFree { return YES; }
%end

%ctor {
    // This forces the tweak to load even if the app tries to block it
    %init;
    NSLog(@"[DramaBoxHack] Tweak initialized successfully.");
}
