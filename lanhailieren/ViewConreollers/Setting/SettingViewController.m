//
//  SettingViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingTableViewCell.h"
#define kSettingTableViewCellID @"SettingTableViewCellID"
#import "AddressListViewController.h"
#import "RegisterDataViewController.h"
#import "ChangePasswordViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@end

@implementation SettingViewController

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
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}

- (void)loadData
{
    NSDictionary * dataInfo = @{@"image":@"ic_set_data",@"title":@"修改资料"};
    NSDictionary  * passwordFoodInfo = @{@"image":@"ic_set_password",@"title":@"修改密码"};
    NSDictionary  * phoneNumberInfo = @{@"image":@"ic_set_tel",@"title":@"修改手机号"};
    NSDictionary  * addressInfo = @{@"image":@"ic_set_address",@"title":@"我的地址"};

    [self.dataSource addObject:dataInfo];
    [self.dataSource addObject:passwordFoodInfo];
    [self.dataSource addObject:phoneNumberInfo];
    [self.dataSource addObject:addressInfo];

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
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[SettingTableViewCell class] forCellReuseIdentifier:kSettingTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
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
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    if (indexPath.row == 3) {
        AddressListViewController * setVC = [[AddressListViewController alloc]init];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    }else if (indexPath.row == 0){
        RegisterDataViewController * vc = [[RegisterDataViewController alloc]init];
        vc.userId = [[UserManager sharedManager] getUserId];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
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
