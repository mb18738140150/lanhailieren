//
//  TixianViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "TixianViewController.h"
#import "EditAddressTableViewCell.h"
#define kEditAddressTableViewCellID @"kEditAddressTableViewCellID"

@interface TixianViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, strong)UIButton * addAddressBtn;

@end

@implementation TixianViewController

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
    NSDictionary * nameInfo = @{@"title":@"姓名",@"content":@"请填写账号对应姓名",@"placeholder":@(1)};
    NSDictionary  * numberInfo = @{@"title":@"提现账号",@"content":@"请填写银行卡或者支账号",@"placeholder":@(1)};
    NSDictionary  * phoneNumberInfo = @{@"title":@"手机号",@"content":@"请填写手机号",@"placeholder":@(1)};
    
    
    [self.dataSource addObject:nameInfo];
    [self.dataSource addObject:numberInfo];
    [self.dataSource addObject:phoneNumberInfo];
    
}


- (void)navigationViewSetup
{
    self.navigationItem.title = @"提现";
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
    [self.tableview registerClass:[EditAddressTableViewCell class] forCellReuseIdentifier:kEditAddressTableViewCellID];
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
    [self.tableview registerClass:[EditAddressTableViewCell class] forCellReuseIdentifier:kEditAddressTableViewCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableview];
    
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kEditAddressTableViewCellID forIndexPath:indexPath];
    [cell refreshUIWith:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 75;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.hd_width, 75)];
    view.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    UILabel * tipLB = [[UILabel alloc]initWithFrame:CGRectMake(tableView.hd_width - 200, 10, 185, 15)];
    tipLB.text = @"* 提现3-5个工作日内到账";
    tipLB.textColor = UIColorFromRGB(0x999999);
    tipLB.textAlignment = NSTextAlignmentRight;
    tipLB.font = [UIFont systemFontOfSize:10];
    [view addSubview:tipLB];
    
    UIButton * complateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complateBtn.frame = CGRectMake(view.hd_width / 2 - 100, 45, 200, 30);
    complateBtn.layer.cornerRadius = 4;
    complateBtn.layer.masksToBounds = YES;
    complateBtn.backgroundColor = kMainRedColor;
    [complateBtn setTitle:@"申请提现" forState:UIControlStateNormal];
    [complateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [view addSubview:complateBtn];
    [complateBtn addTarget:self action:@selector(storeAddress) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)storeAddress
{
    NSLog(@"申请提现");
}

@end
