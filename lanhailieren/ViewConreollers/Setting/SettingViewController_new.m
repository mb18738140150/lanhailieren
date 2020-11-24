//
//  SettingViewController_new.m
//  lanhailieren
//
//  Created by aaa on 2020/4/15.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SettingViewController_new.h"
#import "SettingTableViewCell.h"
#define kSettingTableViewCellID @"SettingTableViewCellID"
#import "AddressListViewController.h"
#import "RegisterDataViewController.h"
#import "ChangePasswordViewController.h"
#import "ChangePhoneViewController.h"
@interface SettingViewController_new ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@end

@implementation SettingViewController_new

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationViewSetup];
    [self loadData];
    
    [self refreshUI_iPhone];
}

- (void)loadData
{
    NSDictionary  * addressInfo = @{@"image":@"ic_set_vip",@"title":@"会员等级"};
    NSDictionary * dataInfo = @{@"image":@"ic_set_data",@"title":@"修改资料"};
    NSDictionary  * phoneNumberInfo = @{@"image":@"ic_set_tel",@"title":@"修改手机号"};
    
    [self.dataSource addObject:addressInfo];
    [self.dataSource addObject:dataInfo];
    [self.dataSource addObject:phoneNumberInfo];
    
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"设置";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}
- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableview];
}

#pragma mark - tableview delegate & datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kSettingTableViewCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell refreshUIWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    
    
    if (indexPath.row == 0) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
           cell.accessoryType = UITableViewCellAccessoryNone;
           [cell resetLevelInfo:[[UserManager sharedManager] getUserInfos]];
        }else
        {
            [cell hideAllSubViews];
        }
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
           return 50;
        }else
        {
            return 0;;
        }
    }
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.hd_width, 130)];
    footerView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    UIButton * exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake((self.tableview.hd_width - 200) / 2, 50, 200, 30);
    exitBtn.backgroundColor = kMainRedColor;
    exitBtn.layer.cornerRadius = 3;
    exitBtn.layer.masksToBounds = YES;
    exitBtn.titleLabel.font = kMainFont;
    [exitBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    [exitBtn setTitle:@"退出账户" forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:exitBtn];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 130;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        // change phone
        ChangePhoneViewController * vc = [[ChangePhoneViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        RegisterDataViewController * vc = [[RegisterDataViewController alloc]init];
        vc.userId = [[UserManager sharedManager] getUserId];
        vc.isFromSetting = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        ChangePasswordViewController * vc = [[ChangePasswordViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)logoutAction
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要退出该账号么" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alert show];
}

#pragma mark - alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self logout];
    }
}

- (void)logout
{
    if (self.quitBlock) {
        self.quitBlock();
    }
    [self.navigationController popViewControllerAnimated:NO];
    
}

@end
