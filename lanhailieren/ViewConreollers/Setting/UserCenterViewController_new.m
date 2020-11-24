//
//  UserCenterViewController_new.m
//  lanhailieren
//
//  Created by aaa on 2020/4/14.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "UserCenterViewController_new.h"
#import "MainHeaderTableViewCell_new.h"
#define kMainHeaderTableViewCell_newID  @"MainHeaderTableViewCell_newID"
#import "MainHeadTableViewCell_Vip.h"
#define kMainHeadTableViewCell_VipID @"MainHeadTableViewCell_VipID"
#import "SettingTableViewCell.h"
#define kSettingTableViewCellID @"SettingTableViewCellID"

#import "CLTableViewViewController.h"
#import "SettingViewController_new.h"
#import "StoreListViewController.h"
#import "MyCustomViewController.h"
#import "MyCollectionViewController.h"
#import "JoinClubViewController.h"
#import <WebKit/WebKit.h>

@interface UserCenterViewController_new ()<UITableViewDelegate, UITableViewDataSource,UserModule_CompleteUserInfoProtocol>

@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray1;

@end

@implementation UserCenterViewController_new

- (NSMutableArray *)dataArray1
{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)reloadView
{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    
    [self refreshUI_iPhone];
    
}
- (void)loadData
{
    NSDictionary * fishInfo = @{@"image":@"main_my_collection",@"title":@"我的收藏"};
    NSDictionary  * intrgerFoodInfo = @{@"image":@"main_my_custom",@"title":@"我的定制"};
    NSDictionary  * coinInfo = @{@"image":@"main_my_initiation",@"title":@"入会方式"};
    NSDictionary  * buyInfo = @{@"image":@"main_my_stores",@"title":@"所有门店"};
    NSDictionary  * tousuInfo = @{@"image":@"main_my_set",@"title":@"设置"};
    NSDictionary  * aboutUsInfo = @{@"image":@"ic_my_contact",@"title":@"联系我们"};
    
    [self.dataArray1 addObject:fishInfo];
    [self.dataArray1 addObject:intrgerFoodInfo];
    [self.dataArray1 addObject:coinInfo];
    [self.dataArray1 addObject:buyInfo];
    [self.dataArray1 addObject:tousuInfo];
    [self.dataArray1 addObject:aboutUsInfo];
    
    [self doResetQuestionRequest];
}

- (void)navigationViewSetup
{
    
    self.navigationItem.title = @"个人中心";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)refreshUI_iPhone
{
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
//    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//    backImageView.backgroundColor = [UIColor clearColor];
//    backImageView.image = [UIImage imageNamed:@"bg_white"];
//    [self.view addSubview:backImageView];
//
//    UIImageView * topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
//    topView.image = [UIImage imageNamed:@"bg_my"];
//    [self.view addSubview:topView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth , kScreenHeight - 50 - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MainHeadTableViewCell_Vip class] forCellReuseIdentifier:kMainHeadTableViewCell_VipID];
    [self.tableView registerClass:[MainHeaderTableViewCell_new class] forCellReuseIdentifier:kMainHeaderTableViewCell_newID];
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [[UserManager sharedManager] completeUserInfoWithDic:@{@"command":@5} withNotifiedObject:self];
}

- (void)didCompleteUserSuccessed
{
    [self.tableView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.tableView reloadData];
}

- (void)didCompleteUserFailed:(NSString *)failInfo
{
    [self.tableView.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 6;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MainHeaderTableViewCell_new * cell = [tableView dequeueReusableCellWithIdentifier:kMainHeaderTableViewCell_newID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[[UserManager sharedManager] getUserInfos]];
        
        return cell;
    }
    if (indexPath.section == 1) {
        MainHeadTableViewCell_Vip * cell = [tableView dequeueReusableCellWithIdentifier:kMainHeadTableViewCell_VipID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[[UserManager sharedManager] getUserInfos]];
        __weak typeof(self)weakSelf = self;
        cell.vipBlock = ^(NSDictionary *info) {
            JoinClubViewController * vc = [[JoinClubViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return cell;
    }
   
    
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingTableViewCellID forIndexPath:indexPath];
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell refreshUIWithInfo:[self.dataArray1 objectAtIndex:indexPath.row]];
    [cell showGoImageView];
    if (indexPath.row == 5) {
        [cell resetConnectionInfo:@{}];
    }
    
    if (indexPath.section == 2 && indexPath.row == 1) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        }else
        {
            [cell hideAllSubViews];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 74;
    }
    if (indexPath.section == 1) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
           return 63;
        }
        return 0;
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
           return 50;
        }else
        {
            return 0;;
        }
    }
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
            {
                // my collection
                MyCollectionViewController * vc = [[MyCollectionViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
                
            }
                break;
            case 1:
            {
                // my custom-made
                MyCustomViewController * vc = [[MyCustomViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                // join club
                JoinClubViewController * vc = [[JoinClubViewController alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                // all stores
                StoreListViewController * storeVC = [[StoreListViewController alloc]init];
                
                storeVC.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:storeVC animated:YES];
            }
                break;
            case 4:
            {
                // setting
                __weak typeof(self)weakSelf = self;
                SettingViewController_new * setVC = [[SettingViewController_new alloc]init];
                setVC.hidesBottomBarWhenPushed = YES;
                setVC.quitBlock = ^{
                    [[UserManager sharedManager] logout];
                    [weakSelf performSelector:@selector(changeSelectIndex) withObject:nil afterDelay:0.1];
                };
                
                [self.navigationController pushViewController:setVC animated:YES];
                
            }
                break;
            case 5:
            {
                // connect us
                [self telephoneAction:@"18328331313"];
            }
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - 拨打电话
- (void)telephoneAction:(NSString *)telStr
{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt:%@", telStr];

    /// 防止iOS 10及其之后，拨打电话系统弹出框延迟出现

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];

    });
}

- (void)changeSelectIndex
{
    [self.navigationController.tabBarController setSelectedIndex:0];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
}

@end
