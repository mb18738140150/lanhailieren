//
//  TabbarViewController.m
//  Accountant
//
//  Created by aaa on 2017/2/27.
//  Copyright © 2017年 tianming. All rights reserved.
//

#import "TabbarViewController.h"
#import "OrderFoodViewController.h"
#import "ShoppingCarViewController.h"
#import "UserCenterViewController.h"
#import "AFNetworking.h"
#import "ShowPhotoViewController.h"
#import "OrderListViewController.h"
#import "LoginViewController.h"

#import "UserCenterViewController_new.h"
#import "EntertainmentViewController.h"
#import "FoodMakeViewController.h"
#import "XishaFoodViewController.h"
#import "ClubViewController.h"

@interface TabbarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@property (nonatomic,strong) OrderFoodViewController             *orderFoodViewController;
@property (nonatomic,strong) ShoppingCarViewController          *shoppingcarViewController;
@property (nonatomic,strong) UserCenterViewController         *userCenterViewController;
@property (nonatomic,strong) AFNetworkReachabilityManager   *netManager;
@property (nonatomic,strong) OrderListViewController         *orderListViewController;


@property (nonatomic,strong) UserCenterViewController_new         *userCenterViewController_new;
@property (nonatomic, strong)EntertainmentViewController * entertainmentViewController;
@property (nonatomic, strong)FoodMakeViewController * foodMakeViewController;
@property (nonatomic, strong)XishaFoodViewController * xishaVC;
@property (nonatomic, strong)ClubViewController * clubVC;

@end

@implementation TabbarViewController


#pragma mark - view controller life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.delegate = self;
    [self setupChildViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quesitonImageClick:) name:kNotificationOfQuestionImageClick object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(leftBarClick:) name:kNotificationOfLeftBarClick object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginClick:) name:kNotificationOfLoginClick object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerClick:) name:kNotificationOfRegisterClick object:nil];
    
    
    [self startMonitorNet];
}

-(void)viewWillAppear:(BOOL)animated{
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    [self.selectedViewController viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.selectedViewController viewDidAppear:YES];
}

- (void)requireLogin
{
    LoginViewController *login = [[LoginViewController alloc] init];

    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:login];

    [self presentViewController:nav animated:YES completion:nil];
}

- (void)startMonitorNet
{
    self.netManager = [AFNetworkReachabilityManager manager];
    __block NSString *showString;
    [self.netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                showString = @"网络不可用";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                showString = @"正在使用wifi网络";
                break;
            }
                
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                showString = @"正在使用手机流量";
                break;
            }
                
            case AFNetworkReachabilityStatusUnknown: {
                showString = @"正在使用未知网络";
                break;
            }
                
            default:
                break;
        }
        [SVProgressHUD showInfoWithStatus:showString];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    [self.netManager startMonitoring];
}


- (void)loginClick:(NSNotification *)notification
{
    [self requireLogin];
}



#pragma mark - ui setup
- (void)setupChildViewControllers
{
    self.orderFoodViewController = [[OrderFoodViewController alloc] init];
    self.shoppingcarViewController = [[ShoppingCarViewController alloc] init];
    self.userCenterViewController = [[UserCenterViewController alloc] init];
    self.orderListViewController = [[OrderListViewController alloc]init];
    
    self.userCenterViewController_new = [[UserCenterViewController_new alloc]init];
    self.entertainmentViewController = [[EntertainmentViewController alloc]init];
    self.foodMakeViewController = [[FoodMakeViewController alloc]init];
    self.xishaVC = [[XishaFoodViewController alloc]init];
    self.clubVC = [[ClubViewController alloc]init];
    
    /*    self.courseCategoryViewController = [[AllCourseViewController alloc] init];
     self.courseCategoryViewController.intoType = IntoPageTypeAllCourse;*/
    
    UINavigationController *orderFoodNavigation = [[UINavigationController alloc] initWithRootViewController:self.clubVC];
//    orderFoodNavigation = [[UINavigationController alloc] initWithRootViewController:self.orderFoodViewController];
    orderFoodNavigation.tabBarItem.image = [UIImage imageNamed:@"tab_club"];
    orderFoodNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_club_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderFoodNavigation.tabBarItem.title = @"俱乐部";
    
    UINavigationController *shoppingCarNavigation = [[UINavigationController alloc] initWithRootViewController:self.xishaVC];
//    shoppingCarNavigation = [[UINavigationController alloc] initWithRootViewController:self.shoppingcarViewController];
    shoppingCarNavigation.tabBarItem.image = [UIImage imageNamed:@"tab_food"];
    shoppingCarNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_food_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppingCarNavigation.tabBarItem.title = @"西沙美食";
    
    UINavigationController *orderListNavigation = [[UINavigationController alloc] initWithRootViewController:self.foodMakeViewController];
//    orderListNavigation = [[UINavigationController alloc] initWithRootViewController:self.orderListViewController];
    orderListNavigation.tabBarItem.image = [UIImage imageNamed:@"tab_making"];
    orderListNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_making_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    orderListNavigation.tabBarItem.title = @"美食制作";
    
    UINavigationController *videoNavigation = [[UINavigationController alloc] initWithRootViewController:self.entertainmentViewController];
    videoNavigation.tabBarItem.image = [UIImage imageNamed:@"tab_recreation"];
    videoNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_recreation_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    videoNavigation.tabBarItem.title = @"休闲娱乐";
    
    UINavigationController *mainNavigation = [[UINavigationController alloc] initWithRootViewController:self.userCenterViewController_new];
    mainNavigation.tabBarItem.image = [UIImage imageNamed:@"tab_my"];
    mainNavigation.tabBarItem.selectedImage = [[UIImage imageNamed:@"tab_my_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mainNavigation.tabBarItem.title = @"我的";
    
    self.viewControllers = @[orderFoodNavigation,shoppingCarNavigation,orderListNavigation,videoNavigation,mainNavigation];
}


#pragma mark - delegate func
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    UINavigationController *nav = (UINavigationController *)viewController;
    
    if ( [nav.topViewController class] == [UserCenterViewController_new class]) {
        if (![[UserManager sharedManager] isUserLogin]) {
            [self requireLogin];

            [self setSelectedIndex:0];
        }else
        {
            [self.userCenterViewController_new reloadView];
        }
    }
    
//    if ([nav.topViewController class] == [FoodMakeViewController class]) {
//        if (![[UserManager sharedManager] isUserLogin]) {
//            [self requireLogin];
//            if (IS_PAD) {
//                [self setSelectedIndex:1];
//            }else
//            {
//                [self setSelectedIndex:0];
//            }
//            [self setSelectedIndex:0];
//        }
//    }
    
    if ([nav.topViewController class] != [FoodMakeViewController class]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfFoodMakeVideoStopPlay object:nil];
        if (self.foodMakeViewController.haveLoad) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.foodMakeViewController performSelector:@selector(showCategory) withObject:nil];
            });
        }
    }
    if ([nav.topViewController class] != [EntertainmentViewController class]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfAederVideoStopPlay object:nil];
        if (self.entertainmentViewController.haveLoad) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.entertainmentViewController performSelector:@selector(showCategory) withObject:nil];
            });
        }
    }
}

#pragma mark - assistantCenter protocol
- (void)didRequestAssistantCenterSuccessed
{
    
}

- (void)didRequestAssistantCenterFailed:(NSString *)failedInfo
{
    
}



- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
//    if (IS_PAD) {
//        return UIInterfaceOrientationMaskLandscapeLeft;
//    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)quesitonImageClick:(NSNotification *)notification
{
    UIImage *image = notification.object;
    ShowPhotoViewController *vc = [[ShowPhotoViewController alloc] initWithImage:image];
    vc.isShowDelete = NO;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)leftBarClick:(NSNotification *)notification
{
    NSIndexPath * indexpath = notification.object;
    switch (indexpath.row) {
        case 1:
            {
                self.selectedIndex = 1;// orderFood
                [self judgeIsRequireLogin];
            }
            break;
        case 2:
        {
            self.selectedIndex = 2;// shoppingCar
            [self judgeIsRequireLogin];
        }
            break;
        case 3:
        {
            self.selectedIndex = 3;// orderList
            [self judgeIsRequireLogin];
        }
            break;
        case 4:
        {
            self.selectedIndex = 0;// main
            [self judgeIsRequireLogin];
        }
            break;
            
        default:
            break;
    }
}

- (void)judgeIsRequireLogin
{
    if (![[UserManager sharedManager] isUserLogin]) {
        [self requireLogin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
