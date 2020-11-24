//
//  ConvertListViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ConvertListViewController.h"
#import "ConvertListTableViewCell.h"
#define kConvertListTableViewCellID @"ConvertListTableViewCellID"

@interface ConvertListViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_OrderListProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@end

@implementation ConvertListViewController

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
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"兑换列表";
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
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 5, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[ConvertListTableViewCell class] forCellReuseIdentifier:kConvertListTableViewCellID];
    
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
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[ConvertListTableViewCell class] forCellReuseIdentifier:kConvertListTableViewCellID];
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
    [[UserManager sharedManager] didRequestOrderListWithCourseInfo:@{@"command":@15,@"order_type":@2,@"order_status":@(0),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}


- (void)didRequestOrderListSuccessed
{
    [SVProgressHUD dismiss];
    
    [self.tableview.mj_header endRefreshing];
    if (self.page_index == 1) {
        [self.dataSource  removeAllObjects];
    }
    for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        NSDictionary * orderGoodInfo = [[info objectForKey:@"order_goods"] count] > 0?[[info objectForKey:@"order_goods"] firstObject]:@{};
        if ([[orderGoodInfo allKeys] count] > 0) {
            [mInfo setObject:[orderGoodInfo objectForKey:@"goods_title"] forKey:@"title"];
            [mInfo setObject:[orderGoodInfo objectForKey:@"img_url"] forKey:@"img_url"];
            
        }
        
        
        [self.dataSource addObject:mInfo];
    }
    if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataSource.count) {
        [self.tableview.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableview.mj_footer endRefreshing];
    }
    
    [self.tableview reloadData];
    
}

- (void)didRequestOrderListFailed:(NSString *)failedInfo
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConvertListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kConvertListTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
