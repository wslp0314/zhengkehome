//
//  GCCommons.m
//  GasChat
//
//  Created by Martin Yin on 12/2/2015.
//  Copyright © 2015 Lngtop. All rights reserved.
//

#import "GCCommons.h"
#import "AppDelegate.h"
#import "GCBaseModel.h"

NSString * const kLPBaseURL                = @"https://auth.ivicar.cn/";
NSString * const kLPTestURL                = @"https://api.ivicar.cn/";
NSString * const kLPNewTestURL             = @"http://apiserver.ivicar.cn/";
NSString * const kLPUserInfo               = @"kLPUserInfo";
NSString * const kLPLoginSccess            = @"kLPLoginSccess";
NSString * const kLPAppkey                 = @"141c9c8bc7c33";
NSString * const kLPAppSecret              = @"278ec76a52469f96c1893fc59866beaf";
NSString * const kLPShowLoginView          = @"kLPShowLoginView";
NSString * const KLPKeyOffset              = @"KLPKeyOffset";
NSString * const kLPCodeCountDown          = @"kLPCodeCountDown";
NSString * const kLPHideHud                = @"kLPHideHud";
//ivicarCommon 修改kLPJPushAppID 为 25f0a3a0631abf8c581bd373
NSString * const kLPJPushAppID             = @"b61859c47d52e438b715f81a";
NSString * const kLPJPushChannel           = @"JPush";
NSString * const kLPDeviceSettingChangeID  = @"kLPDeviceSettingChangeID";
NSString * const kLPDeviceSettingParameter = @"kLPDeviceSettingParameter";
NSString * const kLPCarInfo                = @"kLPCarInfo";
NSString * const kLPPhoneNum               = @"kLPPhoneNum";
NSString * const kLPPassword               = @"kLPPassword";
NSString * const kLPJpushPhoneNum          = @"kLPJpushPhoneNum";
NSString * const kLPJpushPassword          = @"kLPJpushPassword";
NSString * const kLPToken                  = @"kLPToken";
NSString * const kLPJpushInfo              = @"kLPJpushInfo";
NSString * const kLPP2pID                  = @"kLPP2pID";
NSString * const kLPVersionDic             = @"kLPVersionDic";
NSString * const kLPVideoControllerAppear    = @"kLPVideoControllerAppear";
NSString * const kLPVideoControllerDisappear = @"kLPVideoControllerDisappear";
NSString * const kLPVideoScrollView          = @"kLPVideoScrollView";




//新后端短信验证类型(type)
NSString * const kLPRegister               = @"register";
NSString * const kLPReplaceMobile          = @"replaceMobile";
NSString * const kLPRestPassword           = @"restPassword";

//新后端手势登陆字典键(type)
NSString * const kLPGestureDic             = @"kLPGestureDic";


BOOL       const kLPJPushIsProduction     = YES;
NSUInteger const kLPCellHeight            = 48;

@interface GCCommons ()<UIDocumentInteractionControllerDelegate>

@end

@implementation GCCommons

+ (instancetype)commons {
    static dispatch_once_t once;
    static GCCommons *commons = nil;
    dispatch_once(&once, ^{
        commons = [[GCCommons alloc] init];
    });
    return commons;
}

//朋友分享视频
- (void) shareVideoWithVideoUrl:(NSURL *)videoUrl {
    self.docInteractionController = [UIDocumentInteractionController interactionControllerWithURL:videoUrl];
    self.docInteractionController.delegate = self;
    [[GCCommons commons].docInteractionController presentOptionsMenuFromRect:CGRectZero inView:[GCCommons getCurrentVC].view animated:YES];
}

#pragma mark - UIDocumentInteractionControllerDelegate
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)interactionController
{
    return [GCCommons getCurrentVC];
}

-(void)documentInteractionController:(UIDocumentInteractionController *)controller didEndSendingToApplication:(NSString *)application {
    NSLog(@"文件发送完毕");
}




- (void) showHudWith:(NSString *)text {
    self.hud = [JGProgressHUD createHud];
    [[self.hud textLabel] setText:text];
    [self.hud showInView:[[UIApplication sharedApplication].windows lastObject].rootViewController.view];
    [self.hud addGreenGlowAnimation];
}

- (void) hideHud {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self.hud dismissAnimated:YES];
    self.hud = nil;
    //    });
}

- (void) showErrorHudWith:(NSString *)text {
    self.hud = [JGProgressHUD createHud];
    [[self.hud textLabel] setText:text];
    [self.hud setIndicatorView:[JGProgressHUDErrorIndicatorView new]];
    [self.hud showInView:[[UIApplication sharedApplication].windows lastObject].rootViewController.view];
    [self.hud addRedGlowAnimation];
    [self.hud dismissAfterDelay:1];
}

- (void) showSuccessHudWith:(NSString *)text {
    self.hud = [JGProgressHUD createHud];
    [[self.hud textLabel] setText:text];
    [self.hud setIndicatorView:[JGProgressHUDSuccessIndicatorView new]];
    [self.hud showInView:[[UIApplication sharedApplication].windows lastObject].rootViewController.view];
    [self.hud addGreenGlowAnimation];
    [self.hud dismissAfterDelay:1];
}

+ (NSString *)getMessageWithResult:(NSString *)result {
    NSArray *array = [result componentsSeparatedByString:@","];
    NSString *message;
    for (NSString *str in array) {
        if ([str rangeOfString:@"message"].location != NSNotFound) {
            NSArray *arr = [str componentsSeparatedByString:@"\""];
            message = arr[arr.count -2];
        }
    }
    return message;
}


+ (BOOL)hasUserInfoBefore {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"kLPUserInfo"];
    return userInfo ? YES:NO;
}

+ (BOOL)hasTokenBefore {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userInfo = [userDefaults objectForKey:kLPToken];
    return userInfo.length ? YES:NO;
}

+ (BOOL)hasGesturePasswordBefore {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:[GCCommons getUserId]];
    NSString *gesturePassword;
    if (userInfo) {
        gesturePassword = userInfo[@"gesturePassword"];
    } else {
        return  NO;
    }
    return gesturePassword.length ? YES:NO;
}

+ (BOOL)hasLoginUseNineViewState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo;
    if ([GCCommons getUserId].length) {
        userInfo = [userDefaults objectForKey:[GCCommons getUserId]];
    }
    return userInfo[@"loginUseNineView"]?YES:NO;
}

+ (BOOL)getLoginUseNineViewState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults objectForKey:kLPGestureDic];
    NSString *gesturePassword = dic[@"gesturePassword"];
    bool state = false;
    if (kLPServerBackground?[GCCommons getGesturePassword].length:gesturePassword.length) {
        NSDictionary *userInfo = [userDefaults objectForKey:[GCCommons getUserId]];
        if (kLPServerBackground?userInfo[@"loginUseNineView"]:dic[@"loginUseNineView"]) {
            state = kLPServerBackground?[userInfo[@"loginUseNineView"] integerValue]:[dic[@"loginUseNineView"] integerValue];
        } else {
            state = NO;
        }
    } else {
        state = NO;
    }
    return state;
}

+ (BOOL)getLoginTouchIDViewState {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    bool state = false;
    NSDictionary *userInfo = kLPServerBackground?[userDefaults objectForKey:[GCCommons getUserId]]:[userDefaults objectForKey:kLPGestureDic];
    if (userInfo[@"touchIDView"]) {
        state = [userInfo[@"touchIDView"] integerValue];
    } else {
        state = NO;
    }
    return state;
}

+ (NSString *) getUserId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"kLPUserInfo"];
    
    return userInfo ? userInfo[@"user_id"]:@"";
}

+ (NSString *)getGesturePassword {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:[GCCommons getUserId]];
//    userInfo = [userDefaults objectForKey:userInfo[@"user_id"]];
    
    return userInfo[@"gesturePassword"]?userInfo[@"gesturePassword"]:nil;
}

+ (NSDictionary *)getGesturePasswordDic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:@"kLPUserInfo"];
    userInfo = [userDefaults objectForKey:userInfo[@"user_id"]];
    return userInfo;
}

+ (NSString *)getP2pID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:[GCCommons getUserId]];
    return userInfo[@"p2pid"];
}

+ (NSString *)getKLPP2pID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [userDefaults objectForKey:kLPP2pID];
}

+ (NSDictionary *)getUserDefaultDicWithKey:(NSString *)key {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfo = [userDefaults objectForKey:key];
    return userInfo;
}

+ (void)saveGesturePassDicWith:(NSDictionary *)dic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    if(dic) {
        NSDictionary *infos = dic;
        if ([GCCommons getUserId]) {
            [userDefaults setObject:infos forKey:[GCCommons getUserId]];
        }
    }
    [userDefaults synchronize];
}

+ (void)saveP2pIDWithUserId:(NSString *)userId andP2pIDDic:(NSDictionary *)dic {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:dic forKey:userId];
    [userDefaults synchronize];
}

+ (NSString *)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    if ([[UIApplication valueForKeyPath:@"statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
        children = [[[[UIApplication valueForKeyPath:@"statusBar"] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    } else {
        children = [[[UIApplication valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    }
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
        }
        //根据状态选择
    }
    if (!netType) {
        return @"无网络";
    }
    return state;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end

int randomInt(int low, int high)
{
    return (arc4random() % (high-low+1)) + low;
}

BOOL randomBool()
{
    return (BOOL)randomInt(0, 1);
}

float randomClamp()
{
    return (float)(arc4random() % ((unsigned)RAND_MAX + 1)) / (float)((unsigned)RAND_MAX + 1);
}

UIViewController *AppRootTopViewController() {
    UIViewController  *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    if([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *rootNavigationController = (UINavigationController *)rootViewController;
        if(rootNavigationController.visibleViewController != nil) {
            if(rootNavigationController.visibleViewController.navigationController != nil) {
                return rootNavigationController.visibleViewController.navigationController;
            } else {
                return rootNavigationController.visibleViewController;
            }
        } else {
            return rootNavigationController;
        }
    } else {
        return rootViewController;
    }
    return nil;
}




BOOL isValidFloatNumberString(NSString *string) {
    static NSRegularExpression *regex;
    static dispatch_once_t onceSecurePredicate;
    dispatch_once(&onceSecurePredicate, ^{
        regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d+(\\.\\d{0,2})?)|(\\.\\d{1,2})$" options:0 error:NULL];
    });

    if (0 < [string length]) {
        NSRange range = [regex rangeOfFirstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
        if ([string length] == range.length) {

            return YES;
        } else {

            return NO;
        }
    } else {
//        NSNumber *num = @(1568785899);
        
        return YES;
    }
}

NSUInteger priceIntegerValueFromString(NSString *string) {
    double costDoubleValue = [string doubleValue];

    return (NSUInteger)(costDoubleValue * 100);
}

#if LogToFile
@interface GCFileLogger ()

@property (strong, nonatomic) NSFileHandle *loggerFileHandle;

@end

@implementation GCFileLogger: NSObject

+ (instancetype)logger {
    static dispatch_once_t once;
    static GCFileLogger *sharedLogger = nil;
    dispatch_once(&once, ^{
        sharedLogger = [[GCFileLogger alloc] init];
    });
    return sharedLogger;
}


- (void)dealloc {
    self.loggerFileHandle = nil;
}

- (void)log:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);
    
    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
    [self.loggerFileHandle writeData:[[message stringByAppendingString:@"\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [self.loggerFileHandle synchronizeFile];
    
    NSLog(@"%@", message);
}






@end
#endif
