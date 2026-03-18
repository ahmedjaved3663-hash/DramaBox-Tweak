#import <UIKit/UIKit.h>

// 1. Force VIP status in the App's local storage
%hook NSUserDefaults
- (bool)boolForKey:(NSString *)defaultName {
    if ([defaultName containsString:@"vip"] || 
        [defaultName containsString:@"Unlock"] || 
        [defaultName containsString:@"isMember"]) {
        return YES;
    }
    return %orig;
}

- (id)objectForKey:(NSString *)defaultName {
    if ([defaultName containsString:@"vip_timeout"] || [defaultName containsString:@"expire"]) {
        return @"2099-12-31"; // Set a far-future expiry date
    }
    return %orig;
}
%end

// 2. Disable the "Limit" check for episodes
%hook NSNumber
- (long long)longLongValue {
    // If the app checks 'coin_balance', return a high number
    return 99999;
}
%end

// 3. Prevent the "Transaction" popup from appearing
%hook UIWindow
- (void)makeKeyAndVisible {
    %orig;
    UIViewController *root = self.rootViewController;
    if ([NSStringFromClass([root class]) containsString:@"Pay"]) {
        [root dismissViewControllerAnimated:NO completion:nil];
    }
}
%end
