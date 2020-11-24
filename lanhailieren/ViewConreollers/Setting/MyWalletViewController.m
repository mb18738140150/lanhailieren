//
//  MyWalletViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/9.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "MyWalletViewController.h"
#import "IntegerListTableViewCell.h"
#define kIntegerListTableViewCellID @"IntegerListTableViewCellID"
#import "IntegerDetailHeadView.h"
#import "TixianViewController.h"

@interface MyWalletViewController ()<UITableViewDelegate,UITableViewDataSource,HYSegmentedControlDelegate,UserModule_RechargeDetailListProtocol>

@property (nonatomic, strong)HYSegmentedControl * segmentC;

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * chongzhiDataSource;
@property (nonatomic, strong)NSMutableArray * tixianDataSource;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@end

@implementation MyWalletViewController


- (NSMutableArray *)chongzhiDataSource
{
    if (!_chongzhiDataSource) {
        _chongzhiDataSource = [NSMutableArray array];
    }
    return _chongzhiDataSource;
}

- (NSMutableArray *)tixianDataSource
{
    if (!_tixianDataSource) {
        _tixianDataSource = [NSMutableArray array];
    }
    return _tixianDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.page_size = 10;
    self.page_index = 1;
    [self loadData];
    [self navigationViewSetup];
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:seperateView];
    
    if (IS_PAD) {
        [self refreshUI_iPad];
        self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(53 + self.tableview.hd_width / 2 - 100) OriginY:151 Titles:@[@"余额明细", @"提现明细"] delegate:self drop:NO color:kMainRedColor];
        [self.segmentC hideBottomBackLine];
    }else
    {
        [self refreshUI_iPhone];
        self.segmentC = [[HYSegmentedControl alloc] initWithOriginX:(self.tableview.hd_width / 2 - 100) OriginY:151 Titles:@[@"余额明细", @"提现明细"] delegate:self drop:NO color:kMainRedColor];
        [self.segmentC hideBottomBackLine];
    }
    
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"我的钱包";
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
    NSDictionary * dataInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"充值到余额",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * passwordFoodInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"充值到余额",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * phoneNumberInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"充值到余额",@"integer":@"+120",@"state":@"待发货"};
    NSDictionary  * addressInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"充值到余额",@"integer":@"+110",@"state":@"待发货"};
    
    [self.tixianDataSource addObject:passwordFoodInfo];
    [self.tixianDataSource addObject:phoneNumberInfo];
    [self.tixianDataSource addObject:addressInfo];
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 5, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[IntegerListTableViewCell class] forCellReuseIdentifier:kIntegerListTableViewCellID];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[IntegerListTableViewCell class] forCellReuseIdentifier:kIntegerListTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableview];
    
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    if (self.segmentC.selectIndex == 1) {
        [self.tableview.mj_header endRefreshing];
        return;
    }
    self.page_index = 1;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestRechargeDetailListWithInfo:@{@"command":@"18",@"user_id":@([[UserManager sharedManager]getUserId]),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}

- (void)doNextPageQuestionRequest
{
    if (self.segmentC.selectIndex == 1) {
        [self.tableview.mj_footer endRefreshing];
        return;
    }
    self.page_index++;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestRechargeDetailListWithInfo:@{@"command":@"18",@"user_id":@([[UserManager sharedManager]getUserId]),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}
#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.segmentC.selectIndex == 0) {
        return self.chongzhiDataSource.count;
    }else
    {
        return self.tixianDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegerListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kIntegerListTableViewCellID forIndexPath:indexPath];
    if (self.segmentC.selectIndex == 0) {
        [cell refreshUIWithInfo:[self.chongzhiDataSource objectAtIndex:indexPath.row]];
        cell.iconImageView.image = [UIImage imageNamed:@"ic_topup"];
    }else
    {
        [cell refreshUIWithInfo:[self.tixianDataSource objectAtIndex:indexPath.row]];
        cell.iconImageView.image = [UIImage imageNamed:@"ic_withdrawal"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.hd_width, 192)];
    backView.backgroundColor = [UIColor whiteColor];
    
    IntegerDetailHeadView * headView = [[IntegerDetailHeadView alloc]initWithFrame:CGRectMake(20, 6, backView.hd_width - 40, 145)];
    [headView resetWithInfo:@{@"title":@"当前余额",@"content":@"300.00"}];
    [backView addSubview:headView];
    [headView showTixianBtn];
    
    __weak typeof(self)weakSelf = self;
    headView.tixianBlock = ^{
        TixianViewController * tixianVC = [[TixianViewController alloc]init];
        [weakSelf.navigationController pushViewController:tixianVC animated:YES];
    };
    
    [backView addSubview:self.segmentC];
    
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 192;
}

#pragma mark - HYSegmentedControlDelegate
- (void)hySegmentedControlSelectAtIndex:(NSInteger)index
{
    [self.tableview reloadData];
}

- (void)didRequestRechargeDetailListSuccessed
{
    if (self.chongzhiDataSource.count >= [[UserManager sharedManager] getRechargeDetailListTotalCount] ) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableview.mj_footer endRefreshing];
    }
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.chongzhiDataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getRechargeDetailList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"complete_time"] forKey:@"time"];
        [mInfo setObject:[info objectForKey:@"amount"] forKey:@"integer"];
        [mInfo setObject:[info objectForKey:@"payment"] forKey:@"title"];
        
        [self.chongzhiDataSource addObject:mInfo];
    }
    [self.tableview reloadData];
}

- (void)didRequestRechargeDetailListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
