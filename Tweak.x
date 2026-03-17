#import <UIKit/UIKit.h>

// 1. Hook the User Info - Targeting the 'ST' prefix used in v3.1.4
%hook STUserInfoModel
- (NSInteger)remaining_coins { return 99999; }
- (NSInteger)gold_beans { return 99999; }
- (BOOL)is_vip { return YES; }
%end

// 2. Hook the Episode Logic
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

// 3. Prevent the Paywall from crashing the app
%hook STPayViewController
- (void)viewDidLoad { %orig; }
- (BOOL)shouldShowPayWall { return NO; }
%end

%ctor {
    // We wait 2 seconds after the app starts to inject the code.
    // This prevents the "Startup Crash" you are seeing.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
