#import <UIKit/UIKit.h>

// 1. Hooking every possible 'Chapter' model prefix
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%hook DBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%hook ADChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
%end

%hook GBChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
%end

// 2. Force the Subscription to be "Active"
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
%end

%hook DBUserModel
- (BOOL)is_vip { return YES; }
%end

// 3. Kill any popup that says "Subscribe" or "Pay"
%hook UIViewController
- (void)viewWillAppear:(BOOL)animated {
    %orig;
    NSString *name = NSStringFromClass([self class]);
    if ([name containsString:@"Pay"] || [name containsString:@"Sub"] || [name containsString:@"Coin"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
%end

%ctor {
    // 5-second delay to let the app load its initial data from the server
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
