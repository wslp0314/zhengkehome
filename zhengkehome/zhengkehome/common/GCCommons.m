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

NSString * const kDisclaimerStr = @"用户协议与隐私条款\n欢迎使用捍录者®全景监控APP软件（以下简称“捍录者”或“我们”）。本软件是配合车载全景监控系统使用，请您仔细阅读以下条款，如果您对本协议的任何条款表示异议，您可以选择不使用本软件。当您注册成功，意味着您完全接受本协议项下的全部条款。\n一、账号注册\n1.    用户在使用本服务前需要注册一个账号。账号应当使用邮箱、微信号、手机号码绑定注册。我们可以根据用户需求或产品需要对账号注册和绑定的方式进行变更，而无须事先通知用户。\n2.    在用户注册及使用本服务时，我们需要搜集能识别用户身份的个人信息以便我们可以在必要时联系用户，或为用户提供更好的使用体验。我们搜集的信息包括但不限于用户的姓名、性别、年龄、出生日期、身份证号、地址、车型等，我们同意对这些信息的使用将受限于第三条用户个人隐私信息保护的约束。\n二、服务内容\n1.    我们为用户提供行车记录仪、远程监控、车辆位置信息查询、车辆状态信息查询等服务。我们可以对提供的服务予以变更，且我们提供的服务内容可能随时变更；用户将会收到我们关于服务变更的通知。\n2.    我们提供的服务包含免费服务与收费服务。用户可以通过付费方式购买收费服务，具体方式为：用户通过网上银行、支付宝或其他“我们”平台提供的付费途径支付一定数额的人民币购买我们收费服务，从而获得付费用户应享有的权限。\n三、用户个人隐私信息保护\n1.    用户在注册账号或使用本服务的过程中，可能需要填写或提交一些必要的信息，如法律法规、规章规范性文件（以下称“法律法规”）规定的需要填写的身份信息。如用户提交的信息不完整或不符合法律法规的规定，则用户可能无法使用本服务或在使用本服务的过程中受到限制。\n2.    个人隐私信息是指涉及用户个人身份或个人隐私的信息，比如，用户真实姓名、身份证号、手机号码、手机设备识别码、微信号、IP地址。非个人隐私信息是指用户对本服务的操作状态以及使用习惯等明确且客观反映在我们服务器端的基本记录信息、个人隐私信息范围外的其它普通信息，以及用户同意公开的上述隐私信息。\n3.    尊重用户个人隐私信息的私有性是我们的一贯制度，我们将采取技术措施和其他必要措施，确保用户个人隐私信息安全，防止在本服务中收集的用户个人隐私信息泄露、毁损或丢失。在发生前述情形或者我们发现存在发生前述情形的可能时，将及时采取补救措施。\n4.    我们未经用户同意不向任何第三方公开、 透露用户个人隐私信息。但以下特定情形除外：\n（1）我们根据法律法规规定或有权机关的指示提供用户的个人隐私信息；\n（2）由于用户将其用户密码告知他人或与他人共享注册帐户与密码，由此导致的任何个人信息的泄漏，或其他非因我们原因导致的个人隐私信息的泄露；\n（3）    用户自行向第三方公开其个人隐私信息；\n（4）用户与我们及合作单位之间就用户个人隐私信息的使用公开达成约定，我们因此向合作单位公开用户个人隐私信息；\n（5）任何由于黑客攻击、电脑病毒侵入及其他不可抗力事件导致用户个人隐私信息的泄露。\n（6）用户同意我们可在以下事项中使用用户的个人隐私信息：\n1.    我们向用户及时发送重要通知，如软件更新、本协议条款的变更；\n2.    我们内部进行审计、数据分析和研究等，以改进我们的产品、服务和与用户之间的沟通；\n3.    依本协议约定，我们管理、审查用户信息及进行处理措施；\n4.    适用法律法规规定的其他事项。\n（7）除上述事项外，如未取得用户事先同意，我们不会将用户个人隐私信息使用于任何其他用途。\n（8）为了改善我们的技术和服务，向用户提供更好的服务体验，我们或可会自行收集使用或向第三方提供用户的非个人隐私信息。\n四、使用规则\n1.    本产品在车辆行驶及停车过程中记录影像资料只作为辅助参考之用，是否成为法律认可的证据资料需相关主管部门认可，我司不承担任何责任；\n2.    我司推荐使用质量合格的存储介质，否则会导致录影文件损坏或丢失；\n3.    对产品的任何更改需经我司认可的机构或人员进行操作，如用户自行操作造成的任何后果及损失与本司无关；\n4. 本产品需与汽车供电系统相连，发动机长时间未启动的情况下，建议断开本系统与汽车的连接，否则存在汽车电瓶亏电损坏而无法启动汽车的风险发生；\n5.    请在本产品规定的使用温度范围内使用，请不要在高温、低温、或者高潮湿的环境下使用本产品；\n6.    本软件使用过程中需用到第三方通信运营商提供的网络通道，在没有信号的环境中本软件不能正常提供服务；\n7.    我们提供的服务中可能包括广告，用户同意在使用过程中显示我们和第三方供应商、合作伙伴提供的广告。除法律法规明确规定外，用户应自行对依该广告信息进行的交易负责，对用户因依该广告信息进行的交易或前述广告商提供的内容而遭受的损失或损害，我们不承担任何责任。\n8.    本软件将不定期进行更新，部分功能可能会与本协议有细微差异，具体请以软件实际功能为准\n五、数据储存\n1.    我们不对用户在本服务中相关数据的删除或储存失败负责。\n2.    我们可以根据实际情况自行决定用户在本服务中数据的最长储存期限，并在服务器上为其分配数据最大存储空间等。用户可根据自己的需要自行备份本服务中的相关数据。\n3.    如用户停止使用本服务或本服务终止，我们可以从服务器上永久地删除用户的数据。本服务停止、终止后，我们没有义务向用户返还任何数据。\n六、不可抗力及其他免责事由\n1.    用户理解并确认，在使用本服务的过程中，可能会遇到不可抗力等风险因素，使本服务发生中断。不可抗力是指不能预见、不能克服并不能避免且对一方或双方造成重大影响的客观事件，包括但不限于自然灾害如洪水、地震、瘟疫流行和风暴等以及社会事件如战争、动乱、政府行为等。出现上述情况时，我们将努力在第一时间与相关单位配合，及时进行修复，但是由此给用户或第三方造成的损失，我们及合作单位在法律允许的范围内免责。\n2.    本服务同大多数互联网服务一样，受包括但不限于用户原因、网络服务质量、社会环境等因素的差异影响，可能受到各种安全问题的侵扰，如他人利用用户的资料，造成现实生活中的骚扰；用户下载安装的其它软件或访问的其他网站中含有“特洛伊木马”等病毒，威胁到用户的计算机信息和数据的安全，继而影响本服务的正常使用等等。用户应加强信息安全及使用者资料的保护意识，要注意加强密码保护，以免遭致损失和骚扰。\n3.    用户理解并确认，本服务存在因不可抗力、计算机病毒或黑客攻击、系统不稳定、用户所在位置、用户关机以及其他任何技术、互联网络、通信线路原因等造成的服务中断或不能满足用户要求的风险，因此导致的用户或第三方任何损失，我们不承担任何责任。\n4.    用户理解并确认，在使用本服务过程中存在来自任何他人的包括误导性的、欺骗性的、威胁性的、诽谤性的、令人反感的或非法的信息，或侵犯他人权利的匿名或冒名的信息，以及伴随该等信息的行为，因此导致的用户或第三方的任何损失，我们不承担任何责任。\n5.    用户理解并确认，我们需要定期或不定期地对“我们”平台或相关的设备进行检修或者维护，如因此类情况而造成服务在合理时间内的中断，我们无需为此承担任何责任，但我们应事先进行通告。\n6.    我们依据法律法规、本协议约定获得处理违法违规或违约内容的权利，该权利不构成我们的义务或承诺，我们不能保证及时发现违法违规或违约行为或进行相应处理。\n7.    用户理解并确认，对于我们向用户提供的下列产品或者服务的质量缺陷及其引发的任何损失，我们无需承担任何责任：\n1.    我们向用户免费提供的服务；\n2.    我们向用户赠送的任何产品或者服务。\n8.    在任何情况下，我们均不对任何间接性、后果性、惩罚性、偶然性、特殊性或刑罚性的损害，包括因用户使用“我们”或本服务而遭受的利润损失，承担责任（即使我们已被告知该等损失的可能性亦然）。尽管本协议中可能含有相悖的规定，我们对用户承担的全部责任，无论因何原因或何种行为方式，始终不超过用户因使用我们提供的服务而支付给我们的费用(如有)。\n七、服务的变更、中断、终止\n1.    鉴于网络服务的特殊性，用户同意我们有权随时变更、中断或终止部分或全部的服务（包括收费服务）。我们变更、中断或终止的服务，我们应当在变更、中断或终止之前通知用户，并应向受影响的用户提供等值的替代性的服务；如用户不愿意接受替代性的服务，如果该用户已经购买了我们付费服务，我们应当按照该用户实际使用服务的情况将剩余费用归还用户。\n2.    如发生下列任何一种情形，我们有权变更、中断或终止向用户提供的免费服务或收费服务，而无需对用户或任何第三方承担任何责任：\n（1）根据法律规定用户应提交真实信息，而用户提供的个人资料不真实、或与注册时信息不一致又未能提供合理证明；\n（2）    用户违反相关法律法规或本协议的约定；\n（3）    按照法律规定或有权机关的要求；\n（4）于安全的原因或其他必要的情形。\n八、其他\n1.    我们郑重提醒用户注意本协议中免除我们责任和限制用户权利的条款，请用户仔细阅读，自主考虑风险。\n2.    本协议的效力、解释及纠纷的解决，适用于中华人民共和国法律。若用户和我们之间发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户同意将纠纷或争议提交我们住所地有管辖权的人民法院管辖。\n3.    本协议的任何条款无论因何种原因无效或不具可执行性，其余条款仍有效，对双方具有约束力。\n";
NSString * const kVoltageDisclaimerStr = @"分档控制功能为高级功能选项，打开前请阅读并同意以下使用协议：\n1.本产品需与汽车供电系统相连，发动机长时间未启动的情况下，建议断开本系统与汽车的连接，否则存在汽车电瓶亏电损坏而无法启动汽车的风险发生；\n2.因不同车型电池种类及剩余寿命不同，分档控制功有造成汽车馈电的风险，请充分了解车辆电瓶情况，酌情考虑使用；\n3.此功能为高级功能，欢迎发烧友及专业用户使用并探讨,本APP不对因打开此功能造成的车辆馈电负责；\n4.欢迎反馈问题和建议，请加微信服务wangxin9353；\n关于全部协议请详见《用户协议与隐私条款》；";




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
