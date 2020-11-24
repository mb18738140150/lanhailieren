//
//  XishaSearchFisheryHarvestResultViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/5/3.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "XishaSearchFisheryHarvestResultViewController.h"
#import "FisheryHarvestTableViewCell.h"
#define kFisheryHarvestTableViewCellID @"FisheryHarvestTableViewCellID"
#import "ClubActivityDetailViewController.h"
#import "FisheryHarvestDetailViewController.h"

#import "NoDataTableViewCell.h"
#define kNoDataCellID @"NoDataTableViewCellID"

@interface XishaSearchFisheryHarvestResultViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_ChannelListProtocol,UserModule_ChannelDetailProtocol>

@property (nonatomic, strong)NSMutableArray * dataSource;
@property(nonatomic,retain)UITableView *tableView;

@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;

@end

@implementation XishaSearchFisheryHarvestResultViewController

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page_index = 1;
    self.page_size = 10;
    [self navigationViewSetup];
    [self loadData];
    
    [self tableView];
}
- (void)navigationViewSetup
{
    self.navigationItem.title = @"渔获介绍";
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
- (UITableView *)tableView{
    if (_tableView == nil) {
        
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - kStatusBarHeight) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        [_tableView registerClass:[FisheryHarvestTableViewCell class] forCellReuseIdentifier:kFisheryHarvestTableViewCellID];
        [_tableView registerClass:[NoDataTableViewCell class] forCellReuseIdentifier:kNoDataCellID];

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
        
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource.count == 0) {
        return 1;;
    }
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        NoDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kNoDataCellID forIndexPath:indexPath];
        [cell refreshUI];
        
        return cell;
    }
    
    FisheryHarvestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kFisheryHarvestTableViewCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSDictionary * info = [self.dataSource objectAtIndex:indexPath.row] ;
    __weak typeof(self)weakSelf = self;
    __weak typeof(cell)wealCell = cell;
    
    [cell refreshUIWithInfo:info];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return tableView.hd_height;
    }
    
    return 75;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource.count == 0) {
        return;
    }
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestClubContestDetailWithInfo:@{@"command":@31,@"channel_name":@"fish",@"id":[self.dataSource[indexPath.row] objectForKey:@"id"]} withNotifiedObject:self];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    self.page_index = 1;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestFisheryHarvestListWithInfo:@{@"command":@30,@"channel_name":@"fish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}


- (void)doNextPageQuestionRequest
{
    self.page_index++;
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestFisheryHarvestListWithInfo:@{@"command":@30,@"channel_name":@"fish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}
- (void)loadData
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestFisheryHarvestListWithInfo:@{@"command":@30,@"channel_name":@"fish",@"category_id":@0,@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(0),@"is_red":@0} withNotifiedObject:self];
    
}

- (void)didRequestChannelListSuccessed
{
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    
    if (self.page_index == 1) {
        [self.dataSource removeAllObjects];
    }
    for (NSDictionary * info in [[UserManager sharedManager] getFisheryHarvestList]) {
        NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
        [self.dataSource addObject:mInfo];
    }
    
    
    if ([[UserManager sharedManager] getFisheryHarvestListTotalCount] <= self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else
    {
        [self.tableView.mj_footer endRefreshing];
    }
    
    
    [self.tableView reloadData];
    
}

- (void)didRequestChannelListFailed:(NSString *)failedInfo
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestChannelDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSDictionary * info = [[UserManager sharedManager] getClubContestDetail];
    
    NSMutableArray * speciArray = [NSMutableArray array];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:UIColorFromRGB(0x000000)};
    
    for (NSString * key in [info allKeys]) {
        if ([key isEqualToString:@"category_name"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"分类名称",[info objectForKey:key]];
            
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(4, str.length - 4)];
            
            [speciArray addObject:mStr];
            break;
        }
    }
    
    for (NSString * key in [info allKeys]) {
        if ([key isEqualToString:@"place"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"产地",[info objectForKey:key]];
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(2, str.length - 2)];
            
            [speciArray addObject:mStr];
            break;
        }
    }
    
    for (NSString * key in [info allKeys]) {
        
        if ([key isEqualToString:@"eat_way"]) {
            
            NSString * str = [NSString stringWithFormat:@"%@：%@", @"食用方式",[info objectForKey:key]];
            NSMutableAttributedString * mStr = [[NSMutableAttributedString alloc]initWithString:str];
            [mStr addAttributes:attribute range:NSMakeRange(4, str.length - 4)];
            
            [speciArray addObject:mStr];
            break;
        }
        
    }
    NSMutableDictionary * mInfo = [NSMutableDictionary dictionaryWithDictionary:info];
    [mInfo setObject:speciArray forKey:@"speciArray"];
    
    FisheryHarvestDetailViewController * vc = [[FisheryHarvestDetailViewController alloc]init];
    vc.infoDic = mInfo;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didRequestChannelDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}


@end
