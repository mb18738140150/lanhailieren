//
//  IntegerStoreViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntegerStoreViewController.h"
#import "IntergerCommodityTableViewCell.h"
#define kIntergerCommodityTableViewCellID @"IntergerCommodityTableViewCell"
#import "IntergerCommodityHeaderTableViewCell.h"
#define kIntergerCommodityHeaderTableViewCellID @"IntergerCommodityHeaderTableViewCell"

#import "ConvertCommodityViewController.h"
#import "ConvertListViewController.h"
#import "IntegerDetailListViewController.h"
#import "CommodityDetailViewController.h"

@interface IntegerStoreViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_GoodListProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@end

@implementation IntegerStoreViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page_size = 10;
    self.page_index = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
    [self navigationViewSetup];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"积分商城";
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
    [self startReqest];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[IntergerCommodityTableViewCell class] forCellReuseIdentifier:kIntergerCommodityTableViewCellID];
    [self.tableview registerClass:[IntergerCommodityHeaderTableViewCell class] forCellReuseIdentifier:kIntergerCommodityHeaderTableViewCellID];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[IntergerCommodityTableViewCell class] forCellReuseIdentifier:kIntergerCommodityTableViewCellID];
    [self.tableview registerClass:[IntergerCommodityHeaderTableViewCell class] forCellReuseIdentifier:kIntergerCommodityHeaderTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableview];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    self.page_index = 1;
    [self startReqest];
}

- (void)doNextPageQuestionRequest
{
    self.page_index++;
    [self startReqest];
}
- (void)startReqest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestGoodListWithInfo:@{@"command":@9,@"type":@2,@"categor_id":@(0),@"plate":@(0),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":@"",@"sort":@(1),@"is_hot":@(0),@"is_red":@(0)} withNotifiedObject:self];
}

#pragma mark - goosList request
- (void)didRequestGoodListSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableview.mj_header endRefreshing];
    
    if (self.page_index == 1) {
        [self.dataSource removeAllObjects];
    }
    for (NSDictionary * info in [[UserManager sharedManager] getGoodList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
        [mInfo setObject:[info objectForKey:@"sale_num"] forKey:@"count"];
        [self.dataSource addObject:mInfo];
    }
    if ([[UserManager sharedManager] getGoodListTotalCount] <= self.dataSource.count) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableview.mj_footer endRefreshing];
    }
    
    
    [self.tableview reloadData];
    
}

- (void)didRequestGoodListFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        IntergerCommodityHeaderTableViewCell * headCell = [tableView dequeueReusableCellWithIdentifier:kIntergerCommodityHeaderTableViewCellID forIndexPath:indexPath];
        [headCell refreshUIWithInfo:@{@"count":[[[UserManager sharedManager] getUserInfos] objectForKey:kPoint]}];
        __weak typeof(self)weakSelf = self;
        headCell.integerBuyListBlock = ^{
            ConvertListViewController * convertLIstVC = [[ConvertListViewController alloc]init];
            [weakSelf.navigationController pushViewController:convertLIstVC animated:YES];
        };
        headCell.integerDetailListBlock = ^{
            IntegerDetailListViewController * integerDetailListVC = [[IntegerDetailListViewController alloc]init];
            [weakSelf.navigationController pushViewController:integerDetailListVC animated:YES];
        };
        return headCell;
    }
    IntergerCommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kIntergerCommodityTableViewCellID forIndexPath:indexPath];
    
    NSDictionary * infoDic = [self.dataSource objectAtIndex:indexPath.row];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]] forKey:@"image"];
    
    [cell refreshUIWithInfo:mInfo];
    __weak typeof(self)weakSelf = self;
    cell.convertCommodityBlock = ^(NSDictionary *info) {
        ConvertCommodityViewController * convertVC = [[ConvertCommodityViewController alloc]init];
        convertVC.info = [[NSMutableDictionary alloc] initWithDictionary:info];
        [weakSelf.navigationController pushViewController:convertVC animated:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (IS_PAD) {
            return 264;
        }else{
            return kScreenHeight * 0.34;
        }
    }
    return 170;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.hd_width, 45)];
    footerView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, footerView.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [footerView addSubview:seperateView];
    
    UIButton * orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(15, 25, 100, 20);
    [orderBtn setTitle:@"兑换好礼" forState:UIControlStateNormal];
    [orderBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [footerView addSubview:orderBtn];
    
    UIButton* checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkAllBtn.frame = CGRectMake(footerView.hd_width - 100, orderBtn.hd_y, 70, 20);
    checkAllBtn.titleLabel.font = kMainFont;
    checkAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [checkAllBtn setTitle:@"查看更多" forState:UIControlStateNormal];
    [checkAllBtn setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    [footerView addSubview:checkAllBtn];
    
    UIImageView * goImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(checkAllBtn.frame) + 5, checkAllBtn.hd_y + 2, 15, 15)];
    goImageView.image = [UIImage imageNamed:@"main_go"];
    [footerView addSubview:goImageView];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 0;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommodityDetailViewController * vc = [[CommodityDetailViewController alloc]init];
    NSDictionary * infoDic = [self.dataSource objectAtIndex:indexPath.row];
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:infoDic];
    [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[infoDic objectForKey:@"img_url"]] forKey:@"image"];
    vc.info = mInfo;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
