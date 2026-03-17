#import <UIKit/UIKit.h>

// 1. Hook the User Info - Targeting v3.1.4 specific class names
%hook STUserCenter
- (NSInteger)coins { return 99999; }
- (NSInteger)beans { return 99999; }
- (BOOL)isVip { return YES; }
%end

%hook STUserModel
- (NSInteger)remaining_coins { return 99999; }
- (BOOL)is_vip { return YES; }
- (NSString *)vip_expire_time { return @"2099-12-31"; }
%end

// 2. Hook the Episode Unlock Logic
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)price { return 0; }
%end

// 3. Silent Initialization to prevent startup crash
%ctor {
    // We wait 3 seconds before hooking. This lets the app's 
    // internal security checks finish before we modify the memory.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
