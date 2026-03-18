#import <UIKit/UIKit.h>

// 1. Declarations to prevent "Forward Declaration" errors
@interface UIViewController (DramaBox)
- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;
@end

// 2. Hooking the Episode Logic - Targeting common 3.1.4 names
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

// 3. Hooking the Video Player to bypass the "Locked" check
%hook STVideoPlayerController
- (BOOL)is_need_pay { return NO; }
- (BOOL)checkEpisodeUnlocked:(id)arg1 { return YES; }
%end

// 4. Force-Close the "Membership Expired" screen from your screenshot
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"Pay"] || [className containsString:@"Subscribe"]) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
%end

%ctor {
    // 3-second delay to let the app finish its server check
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
