#import <UIKit/UIKit.h>

// 1. Target the User Profile - In 3.1.4, they used 'UserInfo' logic
%hook DBUserInfoModel
- (NSInteger)remaining_coins { return 77777; }
- (NSInteger)gold_beans { return 77777; }
- (BOOL)is_vip { return YES; }
- (NSString *)vip_end_time { return @"2099-01-01"; }
%end

// 2. Target the Episode/Chapter logic for 3.1.x
%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

// 3. The "Master Bypass" - Stop the Paywall Controller from loading
%hook DBPayViewController
- (void)viewDidLoad { 
    // Do nothing, effectively killing the popup
    return; 
}
%end

%ctor {
    %init;
}
