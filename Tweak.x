#import <UIKit/UIKit.h>

// 1. Target the StoryMatrix (ST) Networking layer
%hook STNetRequestManager
- (void)requestWithConfig:(id)config success:(void (^)(id responseObject))success failure:(id)failure {
    // If the app asks the server "Is this user a VIP?", we force the answer to be 'true'
    NSString *url = [config valueForKey:@"url"];
    if ([url containsString:@"user/info"] || [url containsString:@"check_vip"]) {
        success(@{@"code": @200, @"data": @{@"is_vip": @1, @"vip_left_days": @9999}});
    } else {
        %orig;
    }
}
%end

// 2. Unlock Chapters locally (StoryMatrix 3.1.4 Class)
%hook STChapterModel
- (id)is_unlock { return @1; }
- (id)is_free { return @1; }
- (id)coin_price { return @0; }
%end

// 3. Force the "Wait" for video to bypass the coin check
%hook STVideoPlayer
- (void)playWithChapter:(id)chapter {
    [chapter setValue:@1 forKey:@"is_unlock"];
    %orig(chapter);
}
%end
