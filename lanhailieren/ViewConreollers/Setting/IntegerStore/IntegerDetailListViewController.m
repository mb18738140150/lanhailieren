//
//  IntegerDetailListViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "IntegerDetailListViewController.h"
#import "IntegerListTableViewCell.h"
#define kIntegerListTableViewCellID @"IntegerListTableViewCellID"
#import "IntegerDetailHeadView.h"

@interface IntegerDetailListViewController ()<UITableViewDelegate,UITableViewDataSource, UserModule_RecommendProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;


@end

@implementation IntegerDetailListViewController


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
    UIView * seperateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.hd_width, 5)];
    seperateView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:seperateView];
    
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
    [self doResetQuestionRequest];
    
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"积分明细";
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
//    NSDictionary * dataInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"智能手表蓝牙手环",@"integer":@"+120",@"state":@"待发货"};
//    NSDictionary  * passwordFoodInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"智能手表蓝牙手环",@"integer":@"+120",@"state":@"待发货"};
//    NSDictionary  * phoneNumberInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"智能手表蓝牙手环",@"integer":@"+120",@"state":@"待发货"};
//    NSDictionary  * addressInfo = @{@"time":@"2020-02-02 22:21:21",@"title":@"智能手表蓝牙手环",@"integer":@"+120",@"state":@"待发货"};
//
//    [self.dataSource addObject:dataInfo];
//    [self.dataSource addObject:passwordFoodInfo];
//    [self.dataSource addObject:phoneNumberInfo];
//    [self.dataSource addObject:addressInfo];
    
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
    self.page_index = 1;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestIntegralDetailListWithInfo:@{@"command":@"17",@"user_id":@([[UserManager sharedManager]getUserId]),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}

- (void)doNextPageQuestionRequest
{
    
    self.page_index++;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestIntegralDetailListWithInfo:@{@"command":@"17",@"user_id":@([[UserManager sharedManager]getUserId]),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}

#pragma mark - tableview delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegerListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kIntegerListTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
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
    [headView resetWithInfo:@{@"title":@"当前积分",@"content":[NSString stringWithFormat:@"%d", [[UserManager sharedManager]getCurrentInteger]]}];
    [backView addSubview:headView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(headView.frame) + 20, 100, 20)];
    label.textColor = UIColorFromRGB(0x666666);
    label.text = @"积分明细";
    label.font = kMainFont_16;
    [backView addSubview:label];
    
    return backView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 192;
}

#pragma mark - request
- (void)didRequestRecommendFailed:(NSString *)failedInfo
{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestRecommendSuccessed
{
    if (self.dataSource.count >= [[UserManager sharedManager] getIntegerDetailListTotalCount] ) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableview.mj_footer endRefreshing];
    }
    [self.tableview.mj_header endRefreshing];
    [SVProgressHUD dismiss];
    [self.dataSource removeAllObjects];
    for (NSDictionary * info in [[UserManager sharedManager] getIntegerDetailList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc] initWithDictionary:info];
        [mInfo setObject:[info objectForKey:@"add_time"] forKey:@"time"];
        [mInfo setObject:[info objectForKey:@"point"] forKey:@"integer"];
        
        [self.dataSource addObject:mInfo];
    }
    [self.tableview reloadData];
}

@end
