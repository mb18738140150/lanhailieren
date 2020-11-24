//
//  ChoosStoreViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ChoosStoreViewController.h"
#import "IntegerListTableViewCell.h"
#define kIntegerListTableViewCellID @"IntegerListTableViewCellID"
#import "ChooceStoreView.h"
#import "SearchHeaderView.h"

@interface ChoosStoreViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_StoreListProtocol>
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, strong)ChooceStoreView * chooceStoreView;
@property (nonatomic, strong)SearchHeaderView * searchHeaderView;
@property (nonatomic, strong)NSString * currentKey;

@end

@implementation ChoosStoreViewController


- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self loadData];
    [self navigationViewSetup];
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:seperateView];
    
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"选择门店";
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
    if (self.backBlock) {
        self.backBlock(@{});
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, 34)];
//    [self.view addSubview:self.chooceStoreView];
    
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 35, kScreenWidth - 53, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 35) style:UITableViewStylePlain];
    [self.tableview registerClass:[IntegerListTableViewCell class] forCellReuseIdentifier:kIntegerListTableViewCellID];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    
//    self.chooceStoreView = [[ChooceStoreView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 34)];
//    [self.view addSubview:self.chooceStoreView];
    
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, kScreenHeight - 64 - 35) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[IntegerListTableViewCell class] forCellReuseIdentifier:kIntegerListTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
}
- (UIView *)topView
{
    __weak typeof(self)weakSelf = self;
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    if (IS_PAD) {
        topView.frame = CGRectMake(53, 0, kScreenWidth - 53, 35);
    }else
    {
        topView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    }
    
    self.searchHeaderView = [[SearchHeaderView alloc]initWithFrame:topView.bounds];
    [topView addSubview:self.searchHeaderView];
    self.searchHeaderView.searchBlock = ^(NSString * _Nonnull key) {
        NSLog(@"searchFood");
        weakSelf.currentKey = key;
        [weakSelf doResetQuestionRequest];
    };
    self.searchHeaderView.cancelSearchBlock = ^(NSDictionary * _Nonnull info) {
        NSLog(@"cancel--serch");
        weakSelf.currentKey = @"";
        [weakSelf doResetQuestionRequest];
    };
    return topView;
}
#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestStoreListWith:@{@"command":@13,@"key":@""} withNotifiedObject:self];
}
#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegerListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kIntegerListTableViewCellID forIndexPath:indexPath];
    [cell refreshStoreUIWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    cell.iconImageView.image = [UIImage imageNamed:@"ic_stores"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.chooseStoreBlock) {
        self.chooseStoreBlock([self.dataSource objectAtIndex:indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - storeList request
- (void)didRequestStoreListKeyListSuccessed
{
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.dataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getStoreList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"address"] forKey:@"time"];
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

@end
