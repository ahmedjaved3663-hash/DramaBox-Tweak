#import <UIKit/UIKit.h>

// 1. Hook the Purchase Manager to auto-approve everything
%hook DBPurchaseManager
- (BOOL)isChapterUnlocked:(id)arg1 { return YES; }
- (void)buyChapter:(id)arg1 completion:(id)arg2 {
    // This forces the "Buy" action to finish instantly as a success
    typedef void (^CDUnknownBlockType)(BOOL, id);
    CDUnknownBlockType completionBlock = (CDUnknownBlockType)arg2;
    if (completionBlock) {
        completionBlock(YES, nil);
    }
}
%end

// 2. Hook the Video Content to remove the "Locked" status
%hook DBVideoChapterModel
- (BOOL)isLocked { return NO; }
- (BOOL)isVip { return NO; }
- (NSInteger)price { return 0; }
%end

// 3. Keep the User Status for the UI
%hook DBUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 99999; }
%end

%ctor {
    %init;
    
    // Success Alert
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = nil;
        if (@available(iOS 13.0, *)) {
            for (UIWindowScene *scene in [UIApplication sharedApplication].connectedScenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    window = scene.windows.firstObject;
                    break;
                }
            }
        }
        if (window) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Mod Active" 
                message:@"Transaction Bypass Enabled!" 
                preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"Play" style:UIAlertActionStyleDefault handler:nil]];
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    });
}
