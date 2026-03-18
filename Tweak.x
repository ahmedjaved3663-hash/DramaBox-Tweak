#import <UIKit/UIKit.h>

// --- DECLARATIONS ---
@interface STPayViewController : UIViewController @end
@interface DBPayViewController : UIViewController @end
@interface SDPayViewController : UIViewController @end

// --- THE HOOKS ---

// 1. Force VIP for all possible User Classes
%hook STUserCenter
- (BOOL)isVip { return YES; }
- (BOOL)is_vip { return YES; }
%end

%hook DBUserModel
- (BOOL)is_vip { return YES; }
- (NSInteger)remaining_coins { return 999999; }
%end

%hook SDUserModel
- (BOOL)isVip { return YES; }
- (NSInteger)coins { return 999999; }
%end

// 2. Force Chapters to be Unlocked (The APK Mod Logic)
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

%hook SDChapterModel
- (BOOL)isUnlocked { return YES; }
- (BOOL)isFree { return YES; }
- (NSInteger)price { return 0; }
%end

// 3. Kill the "Expired" Popup for all possible views
%hook STPayViewController
- (void)viewDidLoad { %orig; [self dismissViewControllerAnimated:NO completion:nil]; }
%end

%hook DBPayViewController
- (void)viewDidLoad { %orig; [self dismissViewControllerAnimated:NO completion:nil]; }
%end

%hook SDPayViewController
- (void)viewDidLoad { %orig; [self dismissViewControllerAnimated:NO completion:nil]; }
%end

%ctor {
    // 4-second delay to ensure the server check is finished
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        %init;
    });
}
