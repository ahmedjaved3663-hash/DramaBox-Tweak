#import <UIKit/UIKit.h>

// 1. Hooking generic functions that 99% of Drama apps use
%hookf(BOOL, is_unlock, id self) { return YES; }
%hookf(BOOL, is_vip, id self) { return YES; }
%hookf(NSInteger, coin_price, id self) { return 0; }

// 2. The "Nuclear" Popup Killer
// This will force ANY window with "Pay" or "Sub" in its name to close
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *name = NSStringFromClass([self class]);
    if ([name containsString:@"Pay"] || 
        [name containsString:@"Sub"] || 
        [name containsString:@"Purchase"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
%end

// 3. Force Video Player to "Ready" state
%hook AVPlayer
- (void)play {
    %orig;
}
%end
