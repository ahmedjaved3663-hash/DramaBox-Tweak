#import <UIKit/UIKit.h>

// 1. Force Membership for 'ST' and 'DB' prefixes
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
%end

%hook DBUserModel
- (BOOL)is_vip { return YES; }
%end

// 2. Unlock Episodes (Common 3.1.4 Function Names)
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
%end

// 3. Close the "Subscribe" Popup from your screenshot (IMG_0168)
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *name = NSStringFromClass([self class]);
    // If a window with these names pops up, we close it immediately
    if ([name containsString:@"Pay"] || [name containsString:@"Subscribe"] || [name containsString:@"Coin"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
%end
