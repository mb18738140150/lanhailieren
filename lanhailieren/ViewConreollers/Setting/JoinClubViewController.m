//
//  JoinClubViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/4/20.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "JoinClubViewController.h"
#import "JoinClubTableViewCell.h"
#define kJoinClubTableViewCellID @"JoinClubTableViewCellID"
#import "CustomView.h"

#import "NoDataTableViewCell.h"
#define kNoDataCellID @"NoDataTableViewCellID"

@interface JoinClubViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_StoreListProtocol,UserModule_VIPCustomProtocol>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@end

@implementation JoinClubViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self navigationViewSetup];
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:seperateView];
    
    [self refreshUI_iPhone];
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"入会方式";
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
- (void)loadData
{
    [self.dataSource addObject:@{}];
    [self.dataSource addObject:@{}];
    [self.dataSource addObject:@{}];
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
}

- (void)refreshUI_iPhone
{
    if (IS_PAD) {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(50, 0, kScreenWidth - 100, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    }else
    {
        self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
    }
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[JoinClubTableViewCell class] forCellReuseIdentifier:kJoinClubTableViewCellID];
    [self.tableview registerClass:[NoDataTableViewCell class] forCellReuseIdentifier:kNoDataCellID];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 1;;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        NoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    JoinClubTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kJoinClubTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWith:[self.dataSource objectAtIndex:indexPath.row]];
    __weak typeof(self)weakSelf = self;
    cell.applyBlock = ^(NSDictionary *info) {
        [weakSelf showCustomMadeView:info];
    };
    
    return cell;
}

- (void)showCustomMadeView:(NSDictionary *)infoDic
{
    CustomView * customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withJopinClub:YES];
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    __weak typeof(self)weakSelf = self;
    customView.customMakeCommitBlock = ^(NSDictionary *info) {
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestVIPCustomWithInfo:@{@"command":@37,@"channel_name":@"shop",@"article_id":[infoDic objectForKey:@"id"],@"shop_id":@0,@"name":[info objectForKey:@"name"],@"phone":[info objectForKey:@"phone"],@"address":@"",@"webchat":[info objectForKey:@"webchat"],@"birthday":[info objectForKey:@"birthday"]} withNotifiedObject:weakSelf];
    };
    
    [window addSubview:customView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return tableView.hd_height;
    }
    
    CGFloat mapWidth = tableView.hd_width - 50;
    if (IS_PAD) {
        mapWidth = tableView.hd_width - 146;
    }
    
    return 5 + 20 + 100 + 15 + 5 + 5 + mapWidth * 0.5 + 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 30)];
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel * titleLB = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.hd_width - 20, view.hd_height)];
    if (IS_PAD) {
        titleLB.frame = CGRectMake(60, 0, view.hd_width - 120, view.hd_height);
    }
    
    titleLB.text = @"门店信息";
    titleLB.textColor = UIColorFromRGB(0x000000);
    titleLB.font = kMainFont_12;
    [view addSubview:titleLB];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 0;
    }
    
    return 30;
}

#pragma mark - storeList request

- (void)didRequestVIPCustomFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestVIPCustomSuccessed
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"申请成功"];
    
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestStoreListKeyListSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.dataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.dataSource addObject:mInfo];
    }
    [self.tableview reloadData];
}

- (void)didRequestStoreListKeyListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)dealloc
{
    NSLog(@"ruhuifangshi dealloc");
}


@end
