#import <UIKit/UIKit.h>

// Using a generic hook to avoid build errors from missing class headers
%hook NSObject

// Hooking common DramaBox/StoryMatrix variables
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
- (BOOL)is_unlock { return YES; }
- (NSInteger)gold_num { return 99999; }

// Hooking Aliyun Player status (from your Frameworks screenshot)
- (BOOL)isAutoPlay { return YES; }
- (NSInteger)video_price { return 0; }

%end

// This kills the "Purchase" screen immediately if it pops up
%hook UIViewController
- (void)viewDidAppear:(BOOL)animated {
    %orig;
    NSString *className = NSStringFromClass([self class]);
    if ([className containsString:@"Pay"] || [className containsString:@"Subscribe"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
%end
