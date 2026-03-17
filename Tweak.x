#import <UIKit/UIKit.h>

// 1. Mask the Bundle ID so the Network doesn't break
%hook NSBundle
- (NSString *)bundleIdentifier {
    // This tells the app it is still the original version, even if it's not
    return @"com.storymatrix.drama"; 
}
%end

// 2. Precision hooks for Version 3.1.4 (User Profile)
%hook STUserModel
- (NSInteger)remaining_coins { return 77777; }
- (NSInteger)gold_beans { return 77777; }
- (BOOL)is_vip { return YES; }
%end

// 3. Precision hooks for Version 3.1.4 (Episode Unlocks)
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
%end

%ctor {
    %init;
}
