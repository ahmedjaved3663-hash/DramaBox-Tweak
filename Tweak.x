#import <UIKit/UIKit.h>

// --- THE OVERRIDE LOGIC ---

%hookf(BOOL, is_unlock, id self) { return YES; }
%hookf(BOOL, is_free, id self) { return YES; }
%hookf(NSInteger, coin_price, id self) { return 0; }
%hookf(BOOL, is_vip, id self) { return YES; }

// Target the generic "Play" and "Unlock" methods used in 3.1.4
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    // If a window with "Pay" or "Coin" in the name appears, we kill it immediately
    if ([NSStringFromClass([self class]) containsString:@"Pay"] || 
        [NSStringFromClass([self class]) containsString:@"Coin"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
%end

%ctor {
    // Wait for the app's internal database to load (5 seconds)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
