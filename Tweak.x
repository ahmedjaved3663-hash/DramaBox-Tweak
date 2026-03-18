#import <UIKit/UIKit.h>

// This tells the compiler these classes exist so it doesn't error out
@class STUserCenter;
@class STChapterModel;
@class STPayViewController;

// 1. Hook the User Center to force VIP status
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
%end

// 2. Hook the Chapter Model to unlock episodes
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (NSInteger)coin_price { return 0; }
- (NSInteger)price { return 0; }
%end

// 3. Kill the Pay Wall from your screenshot (IMG_0168)
%hook STPayViewController
- (void)viewDidLoad {
    %orig;
    [self dismissViewControllerAnimated:NO completion:nil];
}
%end

// 4. Global "Safety" Hook for any hidden classes
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"Pay"] || [className containsString:@"Subscribe"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end
