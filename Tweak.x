#import <UIKit/UIKit.h>

// This is a "Dynamic Hook" - it won't cause build errors
%hook NSObject
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
- (BOOL)is_unlock { return YES; }
- (NSInteger)coin_price { return 0; }
%end

// Force the Pay Wall from your screenshot to dismiss itself
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"Pay"] || [className containsString:@"Subscribe"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end
