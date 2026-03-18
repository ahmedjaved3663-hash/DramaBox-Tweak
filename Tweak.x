#import <UIKit/UIKit.h>

// 1. Hook the Aliyun Player to bypass the "Locked" segment check
%hook AliPlayer
- (void)prepare {
    // Force the player to think every video is "Free" or "Authorized"
    [self setValue:@(YES) forKey:@"isAutoPlay"];
    %orig;
}
%end

// 2. Hook the specific StoryMatrix User Info (Version 3.1.4)
%hook STUserModel
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
- (NSString *)vip_expire_time { return @"2099-01-01 00:00:00"; }
- (NSInteger)gold_num { return 999999; }
- (NSInteger)is_forever_vip { return 1; }
%end

// 3. Force the Chapter Model to show as "Purchased"
%hook STChapterModel
- (BOOL)is_unlock { return YES; }
- (BOOL)is_free { return YES; }
- (id)unlock_type { return @1; }
%end

// 4. Global "Value Killer" for paywalls
%hook NSBundle
- (id)objectForInfoDictionaryKey:(NSString *)key {
    if ([key isEqualToString:@"isVip"]) return @YES;
    return %orig;
}
%end
