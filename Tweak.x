#import <UIKit/UIKit.h>

%hook DBUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 88888; }
- (BOOL)isPremium { return YES; }
%end

%hook DBChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)hasPaid { return YES; }
- (BOOL)isFree { return YES; }
%end

// This force-hides the paywall pop-up you see in your photo
%hook DBPayManager
- (BOOL)isEpisodeUnlocked:(id)arg1 { return YES; }
%end

%ctor {
    %init;
    // This will show a message if the tweak actually loads
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Loaded" message:@"DramaBox Mod Active" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}
