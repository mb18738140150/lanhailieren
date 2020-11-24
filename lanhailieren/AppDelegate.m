//
//  AppDelegate.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "AppDelegate.h"
#import "JRSwizzle.h"
#import "NSDictionary+Unicode.h"

#define kAliMapKey @"1db88366d22fd16c7dcb6d48929efb39"
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()<UserModule_LoginProtocol,UserModule_StoreListProtocol,UserModule_AddressListProtocol,WXApiDelegate,WXApiManagerDelegate,UserModule_GoodProtocol>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.tabbarViewController = [[TabbarViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabbarViewController;
//    [self loginAccount];
    [NSDictionary jr_swizzleMethod:@selector(description) withMethod:@selector(my_description) error:nil];
    
    [self loadCategory];
    [WXApi startLogByLevel:WXLogLevelDetail logBlock:^(NSString * _Nonnull log) {
        NSLog(@"***** \n %@ \n******", log);
    }];
    BOOL isRegister = [WXApi registerApp:@"wxfae4605c7d50263a" universalLink:@"https://hunter.hnzhiling.com/hunter/"];
    
    [WXApi checkUniversalLinkReady:^(WXULCheckStep step, WXCheckULStepResult * _Nonnull result) {
        NSLog(@"^^^^^^^^^ \n %@ \n^^^^^^^^^^^", result);
    }];
    
//    if (isRegister) {
//        NSLog(@"*******************\n 微信 register success \n********************");
//    }else
//    {
//        NSLog(@"*******************\n 微信 register failed \n********************");
//    }
    
    [WXApiManager sharedManager].delegate = self;
    
    NSArray *queriesSchemes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"LSApplicationQueriesSchemes"];
    NSLog(@"*******************\n %@ \n********************", queriesSchemes);
    
    [AMapServices sharedServices].apiKey = kAliMapKey;
    
    return YES;
}

- (void)loadCategory
{
    [[UserManager sharedManager] didRequestGoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"goods"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestArderCategoryListWithInfo:@{@"command":@8,@"channel_name":@"arder"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestXishaFoodCategoryListWithInfo:@{@"command":@8,@"channel_name":@"dish"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestFisheryHarvestCategoryListWithInfo:@{@"command":@8,@"channel_name":@"fish"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestFoodMakeCategoryListWithInfo:@{@"command":@8,@"channel_name":@"food"} withNotifiedObject:nil];
    [[UserManager sharedManager] didRequestClubActivityCategoryListWithInfo:@{@"command":@8,@"channel_name":@"activity"} withNotifiedObject:nil];
}

- (void)loginAccount
{
    NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
    NSString *password = [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    
    if (userName != nil && password != nil) {
        [[UserManager sharedManager] loginWithUserName:userName andPassword:password withNotifiedObject:self];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
//    return  [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{

    NSLog(@"userActivity : %@",userActivity.webpageURL.description);
//    return [WXApi handleOpenUniversalLink:userActivity delegate:self];
    return [WXApi handleOpenUniversalLink:userActivity delegate:[WXApiManager sharedManager]];
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (IS_PAD) {
        if ([SoftManager shareSoftManager].isPhontoLibrary) {
            [SoftManager shareSoftManager].isPhontoLibrary = NO;
            return UIInterfaceOrientationMaskAll;
        }else
        {
            return UIInterfaceOrientationMaskLandscape;
        }
    }else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)managerDidRecvMessageResponse:(SendMessageToWXResp *)resp
{
    if (resp.errCode == 0) {
        [SVProgressHUD showSuccessWithStatus:@"分享成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        NSDictionary * info = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentShareInfo];
        
        [[UserManager sharedManager] didRequestDianzanDetailWithInfo:@{@"command":@36,@"channel_name":[info objectForKey:@"channel_name"],@"article_id":[info objectForKey:@"id"],@"click_type":@3} withNotifiedObject:self];
        
    }else
    {
        [SVProgressHUD showErrorWithStatus:resp.errStr];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
    
    
}

- (void)didRequestGoodSuccessed
{
    if ([[UserManager sharedManager].currentShareVC respondsToSelector:@selector(getCurrentpage_indexInfo)]) {
        [[UserManager sharedManager].currentShareVC performSelector:@selector(getCurrentpage_indexInfo)];
    }
}

- (void)didRequestGoodFailed:(NSString *)failedInfo
{
    
}


/*
 总结了一下，每次调用一个 视图控制器 的时候，都会调用指定支持屏幕的方法 - (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window                                       同时在一个视图控制器显示的时候，会调用自己的 支持屏幕方向 supportedInterfaceOrientations 的方法，所以才能在 UIImagePickerController 显示的时候通过指定支持方向来改变 其在用户面前展现的方向。
 
 作者：redye
 链接：https://www.jianshu.com/p/88926c04667d
 来源：简书
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

- (void)didUserLoginSuccessed
{
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    [[UserManager sharedManager] getAddressListWithDic:@{@"command":@"12",@"user_id":@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
}

- (void)didUserLoginFailed:(NSString *)failedInfo
{
//    [SVProgressHUD dismiss];
//    [SVProgressHUD showErrorWithStatus:failedInfo];
////    [self pushLoginVC];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//    });
}
- (void)pushLoginVC
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
}

#pragma mark - storeList request
- (void)didRequestStoreListKeyListSuccessed
{
    NSArray * storeInfo = [[UserManager sharedManager] getStoreList];
    if (storeInfo.count > 0) {
        [UserManager sharedManager].currentSelectStore = [storeInfo firstObject];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfGetStoreSuccess object:nil];
}

- (void)didRequestStoreListKeyListFailed:(NSString *)failedInfo
{
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
}

- (void)didAddressListFailed:(NSString *)failedInfo
{
    [[UserManager sharedManager] getAddressListWithDic:@{@"command":@"12",@"user_id":@([[UserManager sharedManager] getUserId])} withNotifiedObject:self];
}

- (void)didAddressListSuccessed
{
    NSArray * addressArray = [[UserManager sharedManager] getAddressList];
    if (addressArray.count > 0) {
        for (NSDictionary * info in addressArray) {
            if([[info objectForKey:@"is_default"] intValue] == 1)
            {
                [UserManager sharedManager].currentSelectAddressInfo = info;
                break;
            }
        }
        if ([UserManager sharedManager].currentSelectAddressInfo == nil) {
            [UserManager sharedManager].currentSelectAddressInfo = [addressArray firstObject];
        }
    }
}

@end
