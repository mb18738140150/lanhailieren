//
//  UserCenterViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "UserCenterViewController.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "SettingTableViewCell.h"
#define kSettingTableViewCellID @"SettingTableViewCellID"

#import "MainHeaderTableViewCell.h"
#define kMainHeaderTableViewCellID @"MainHeaderTableViewCellID"

#import "IntegerStoreViewController.h"
#import "MyWalletViewController.h"
#import "RechargeViewController.h"
#import "TouSuFanKuiViewController.h"

@interface UserCenterViewController ()<UITableViewDelegate, UITableViewDataSource,UserModule_CompleteUserInfoProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableView;
@property (nonatomic, strong)NSMutableArray * dataArray1;
@property (nonatomic, strong)NSMutableArray * dataArray2;

@end

// hsajbdhisb度还是别覅就

@implementation UserCenterViewController

- (NSMutableArray *)dataArray1
{
    if (!_dataArray1) {
        _dataArray1 = [NSMutableArray array];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2
{
    if (!_dataArray2) {
        _dataArray2 = [NSMutableArray array];
    }
    return _dataArray2;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.tableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.navigationController.navigationBarHidden = NO;
    self.navBarBgAlpha = @"0.0";
    self.navigationController.navigationBar.tintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.tableView reloadData];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    // 设置导航栏标题和返回按钮颜色
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kCommonMainTextColor_50}];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
    
}

- (void)loadData
{
    NSDictionary * fishInfo = @{@"image":@"ic_my_seafood",@"title":@"海鲜商城"};
    NSDictionary  * intrgerFoodInfo = @{@"image":@"ic_my_integral",@"title":@"积分商城"};
    NSDictionary  * coinInfo = @{@"image":@"ic_my_wallet",@"title":@"我的钱包"};
    NSDictionary  * buyInfo = @{@"image":@"ic_my_topup",@"title":@"充值"};
    NSDictionary  * tousuInfo = @{@"image":@"ic_my_complaints",@"title":@"投诉反馈"};
    NSDictionary  * aboutUsInfo = @{@"image":@"ic_my_contact",@"title":@"联系我们"};
    
    [self.dataArray1 addObject:fishInfo];
    [self.dataArray1 addObject:intrgerFoodInfo];
    [self.dataArray2 addObject:coinInfo];
    [self.dataArray2 addObject:buyInfo];
    [self.dataArray2 addObject:tousuInfo];
    [self.dataArray2 addObject:aboutUsInfo];
}

- (void)navigationViewSetup
{
    UINavigationBar * bar = self.navigationController.navigationBar;
    [bar setShadowImage:[UIImage imageNamed:@"tm"]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tm"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_set"] style:UIBarButtonItemStylePlain target:self action:@selector(settingAction)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)settingAction
{
    __weak typeof(self)weakSelf = self;
    SettingViewController * setVC = [[SettingViewController alloc]init];
    setVC.hidesBottomBarWhenPushed = YES;
    setVC.quitBlock = ^{
        [[UserManager sharedManager] logout];
        [weakSelf performSelector:@selector(changeSelectIndex) withObject:nil afterDelay:0.1];
    };
    
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)changeSelectIndex
{
    if (IS_PAD) {
        [self.navigationController.tabBarController setSelectedIndex:1];
    }else
    {
        [self.navigationController.tabBarController setSelectedIndex:0];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
}

- (void)refreshUI_iPad
{
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.backgroundColor = [UIColor clearColor];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    UIImageView * topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    topView.image = [UIImage imageNamed:@"bg_my"];
    [self.view addSubview:topView];
    
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight + kStatusBarHeight, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(83, 0, kScreenWidth - 60 - 53, kScreenHeight + 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    [self.tableView registerClass:[MainHeaderTableViewCell class] forCellReuseIdentifier:kMainHeaderTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    self.view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    UIImageView * backImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    backImageView.backgroundColor = [UIColor clearColor];
    backImageView.image = [UIImage imageNamed:@"bg_white"];
    [self.view addSubview:backImageView];
    
    UIImageView * topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    topView.image = [UIImage imageNamed:@"bg_my"];
    [self.view addSubview:topView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(30, -64, kScreenWidth - 60, kScreenHeight - 50 + 64) style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    [self.tableView registerClass:[MainHeaderTableViewCell class] forCellReuseIdentifier:kMainHeaderTableViewCellID];
    [self.view addSubview:self.tableView];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
   
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] completeUserInfoWithDic:@{@"command":@5} withNotifiedObject:self];
}

- (void)loginAction
{
    LoginViewController * loginVC = [[LoginViewController alloc]init];
    
    [self.navigationController presentViewController:loginVC animated:YES completion:nil];
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
            return 2;
            break;
        case 2:
            return 4;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MainHeaderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kMainHeaderTableViewCellID forIndexPath:indexPath];
        [cell refreshUIWithInfo:[[UserManager sharedManager] getUserInfos]];
        
        cell.stateBlock = ^(NSDictionary *infoDic) {
            if (IS_PAD) {
                [self.tabBarController setSelectedIndex:3];
            }else
            {
                [self.tabBarController setSelectedIndex:2];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfOrderStateSelect object:infoDic];
        };
        
        return cell;
    }
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingTableViewCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 1) {
        [cell refreshUIWithInfo:[self.dataArray1 objectAtIndex:indexPath.row]];
    }else{
        [cell refreshUIWithInfo:[self.dataArray2 objectAtIndex:indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 360;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    }
    return 13;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 13)];
    view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            IntegerStoreViewController * integerVC = [[IntegerStoreViewController alloc]init];
            integerVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:integerVC animated:YES];
        }else
        {
            if (IS_PAD) {
                [self.tabBarController setSelectedIndex:1];
            }else
            {
                [self.tabBarController setSelectedIndex:0];
            }
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                {
                    MyWalletViewController * walletVC = [[MyWalletViewController alloc]init];
                    walletVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:walletVC animated:YES];
                }
                break;
            case 1:
            {
                RechargeViewController * rechargeVC = [[RechargeViewController alloc]init];
                rechargeVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:rechargeVC animated:YES];
            }
                break;
            case 2:
            {
                TouSuFanKuiViewController * tousuVC = [[TouSuFanKuiViewController alloc]init];
                tousuVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:tousuVC animated:YES];
            }
                break;
            case 3:
            {
//               [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLoginClick object:nil];
            }
                break;
                
            default:
                break;
        }
    }
}

@end
