#import <UIKit/UIKit.h>

// 1. Force the Episode itself to be "Free" and "Unlocked"
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (BOOL)is_pay { return NO; }
- (NSInteger)coin_price { return 0; }
- (NSInteger)vip_price { return 0; }
%end

// 2. Tell the Player that it has permission to start the stream
%hook STVideoPlayerController
- (BOOL)is_need_pay { return NO; }
- (BOOL)checkEpisodeUnlocked:(id)arg1 { return YES; }
%end

// 3. This kills the 'Purchase' popup so it never covers the screen
%hook STPayViewController
- (void)viewDidLoad { 
    %orig;
    [self dismissViewControllerAnimated:NO completion:nil]; 
}
%end

%ctor {
    // We wait 2 seconds for the app to load its security data, 
    // then we overwrite it with our "Unlocked" values.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
