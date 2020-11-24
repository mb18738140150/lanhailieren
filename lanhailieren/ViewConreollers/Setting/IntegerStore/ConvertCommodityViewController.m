//
//  ConvertCommodityViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/7.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "ConvertCommodityViewController.h"
#import "AddressListTableViewCell.h"
#define kAddressListTableViewCellID @"AddressListTableViewCellID"
#import "ConvertCommodityTableViewCell.h"
#define kConvertCommodityTableViewCellID @"ConvertCommodityTableViewCellID"

#import "AddressListViewController.h"

@interface ConvertCommodityViewController ()<UITableViewDelegate,UITableViewDataSource,UserModule_CreateOrderProtocol,UserModule_CompleteUserInfoProtocol,UserModule_GoodDetailProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;


@property (nonatomic, strong)NSMutableArray * foodDetailArray;
@property (nonatomic, assign)float foodDetailColletionHeight;
@property (nonatomic, strong)NSArray * goodSpecificationArray;
@property (nonatomic, strong)NSArray * specsArray;

@property (nonatomic, strong)NSDictionary * currentSpecificationInfo;// 当前选中商品规格info
@property (nonatomic, strong)NSDictionary * goodInfo;// 商品info

@property (nonatomic, assign)int count;
@property (nonatomic, strong)UILabel * totalPointLB;

@end

@implementation ConvertCommodityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    self.navigationItem.title = @"兑换商品";
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
    self.count = 1;
    [self.info setObject:@(self.count) forKey:@"count"];
    
    [SVProgressHUD dismiss];
    [[UserManager sharedManager] didRequestGoodDetailWithInfo:@{@"command":@10,@"good_id":@([[self.info objectForKey:@"id"] intValue])} withNotifiedObject:self];
    
}
- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[AddressListTableViewCell class] forCellReuseIdentifier:kAddressListTableViewCellID];
    [self.tableview registerClass:[ConvertCommodityTableViewCell class] forCellReuseIdentifier:kConvertCommodityTableViewCellID];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(53, kScreenHeight - 50 - kNavigationBarHeight - kStatusBarHeight, kScreenWidth - 53, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    NSString * integerStr = [NSString stringWithFormat:@"所需积分: %d", ([self getGoodPoint] * self.count)];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    [integerStr_m addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(5, integerStr.length - 5)];
    
    UILabel * orderBtn = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.attributedText = integerStr_m;
    orderBtn.font = [UIFont systemFontOfSize:16];
    self.totalPointLB = orderBtn;
    [bottomView addSubview:orderBtn];
    
    UIButton * convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    convertBtn.frame = CGRectMake(bottomView.hd_width - 120, 0, 120, 50);
    convertBtn.backgroundColor = kMainRedColor;
    [convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [convertBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    convertBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [convertBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:convertBtn];
    
    [self.view addSubview:bottomView];
}

- (void)refreshUI_iPhone
{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[AddressListTableViewCell class] forCellReuseIdentifier:kAddressListTableViewCellID];
    [self.tableview registerClass:[ConvertCommodityTableViewCell class] forCellReuseIdentifier:kConvertCommodityTableViewCellID];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    [self.view addSubview:self.tableview];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 50 - kNavigationBarHeight - kStatusBarHeight, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    NSString * integerStr = [NSString stringWithFormat:@"所需积分: %d", ([self getGoodPoint] * self.count)];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainRedColor};
    [integerStr_m addAttributes:attribute range: NSMakeRange(5, integerStr.length - 5)];
    
    UILabel * orderBtn = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 200, 20)];
    orderBtn.textColor = UIColorFromRGB(0x000000);
    orderBtn.attributedText = integerStr_m;
    orderBtn.font = [UIFont systemFontOfSize:16];
    self.totalPointLB = orderBtn;
    [bottomView addSubview:orderBtn];
    
    UIButton * convertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    convertBtn.frame = CGRectMake(bottomView.hd_width - 120, 0, 120, 50);
    convertBtn.backgroundColor = kMainRedColor;
    [convertBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    [convertBtn setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    convertBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [convertBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:convertBtn];
    
    [self.view addSubview:bottomView];
    
}

- (void)refreshTotalPOint
{
    NSString * integerStr = [NSString stringWithFormat:@"所需积分: %d", ([self getGoodPoint] * self.count)];
    NSMutableAttributedString *integerStr_m = [[NSMutableAttributedString alloc]initWithString:integerStr];
    NSDictionary * attribute = @{NSForegroundColorAttributeName:kMainRedColor};
    [integerStr_m addAttributes:attribute range: NSMakeRange(5, integerStr.length - 5)];
    self.totalPointLB.attributedText = integerStr_m;
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddressListTableViewCell * headCell = [tableView dequeueReusableCellWithIdentifier:kAddressListTableViewCellID forIndexPath:indexPath];
        headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [headCell refreshUIWithInfo:[UserManager sharedManager].currentSelectAddressInfo];
        [headCell hideEditBtn];
        [headCell showSeperateImageView];
        return headCell;
    }
    if (indexPath.section == 2) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        [cell.contentView removeAllSubviews];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIButton * orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        orderBtn.frame = CGRectMake(15, 15, 100, 20);
        [orderBtn setTitle:@"所需积分" forState:UIControlStateNormal];
        [orderBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        orderBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:orderBtn];
        
        UIButton* checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        checkAllBtn.frame = CGRectMake(cell.hd_width - 100, orderBtn.hd_y, 70, 20);
        checkAllBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        checkAllBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [checkAllBtn setTitle:[NSString stringWithFormat:@"%d", ([self getGoodPoint] * self.count)] forState:UIControlStateNormal];
        [checkAllBtn setTitleColor:kMainRedColor forState:UIControlStateNormal];
        [cell.contentView addSubview:checkAllBtn];
        
        return cell;
    }
    
    ConvertCommodityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kConvertCommodityTableViewCellID forIndexPath:indexPath];
    
    [cell refreshUIWithInfo:self.info];
    __weak typeof(self)weakSelf = self;
    // 更改数量
    cell.countBlock = ^(int count) {
        weakSelf.count = count;
        [weakSelf.info setObject:@(weakSelf.count) forKey:@"count"];
        [weakSelf.tableview reloadData];
        [weakSelf refreshTotalPOint];
    };
    
    return cell;
}

- (int)getGoodPoint
{
    NSString * pointStr = [NSString stringWithFormat:@"%@", [self.info objectForKey:@"point"]];
    pointStr = [pointStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return pointStr.intValue;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }else if (indexPath.section == 2)
    {
        return 50;
    }
    return 160;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableview.hd_width, 7)];
    footerView.backgroundColor = UIColorFromRGB(0xf5f5f5);
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 7;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        AddressListViewController * setVC = [[AddressListViewController alloc]init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
}


- (void)buyAction
{
    if ([UserManager sharedManager].currentSelectAddressInfo == 0) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:@"您还未选择地址"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        return;
    }
    
    NSArray * proList = [self getProList];
    
    int payment_id = 9;
    
    [[UserManager sharedManager] didRequestCreateOrderWithCourseInfo:@{@"command":@14,@"shop_id":[[UserManager sharedManager].currentSelectStore objectForKey:@"id"],@"address_id":[[UserManager sharedManager].currentSelectAddressInfo objectForKey:@"id"],@"remark":@"",@"payment_id":@(payment_id),@"is_invoice":@(0),@"pro_list":proList} withNotifiedObject:self];
    
}

- (NSArray *)getProList
{
    NSDictionary * info = self.goodInfo;
    NSMutableArray * selectArray = [NSMutableArray array];
    NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
    [mInfo setObject:[info objectForKey:@"channel_id"] forKey:@"channel_id"];
    [mInfo setObject:[info objectForKey:@"id"] forKey:@"article_id"];
    [mInfo setObject:@0 forKey:@"goods_id"];
    [mInfo setObject:[[UserManager sharedManager].currentSelectStore objectForKey:@"id"] forKey:@"shop_id"];
    [mInfo setObject:@([[UserManager sharedManager] getUserId]) forKey:@"user_id"];
    [mInfo setObject:@(self.count) forKey:@"quantity"];
    [selectArray addObject:mInfo];
    
    return selectArray;
}

- (void)didRequestCreateOrderSuccessed
{
    [SVProgressHUD showSuccessWithStatus:@"兑换成功"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    });
    [[UserManager sharedManager] completeUserInfoWithDic:@{@"command":@5} withNotifiedObject:self];
}

- (void)didRequestCreateOrderFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didCompleteUserSuccessed
{
    [self.tableview reloadData];
}

- (void)didCompleteUserFailed:(NSString *)failInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestGoodDetailSuccessed
{
    [SVProgressHUD dismiss];
    NSDictionary * data = [[UserManager sharedManager] getGoodDetailInfo];
    
    NSDictionary * info = [data objectForKey:@"data"];
    self.goodInfo = info;
    // 商品规格
    self.goodSpecificationArray = [info objectForKey:@"goods"];
    self.specsArray = [data objectForKey:@"specs"];
    // 商品详细参数获取
    NSDictionary * fieldsInfo = [info objectForKey:@"fields"];
    NSDictionary * field_listInfo = [data objectForKey:@"field_list"];
    NSMutableArray * fieldArray = [NSMutableArray array];
    for (NSString * fieldKey in [fieldsInfo allKeys]) {
        for (NSString * field_listKey in [field_listInfo allKeys]) {
            if ([fieldKey isEqualToString:field_listKey]) {
                //                NSMutableDictionary * mInfo = [NSMutableDictionary dictionary];
                //                [mInfo setObject:[fieldsInfo objectForKey:fieldKey] forKey:@"value"];
                //                [mInfo setObject:[field_listInfo objectForKey:field_listKey] forKey:@"name"];
                
                NSString * str = [NSString stringWithFormat:@"%@：%@", [field_listInfo objectForKey:field_listKey],[fieldsInfo objectForKey:fieldKey]];
                [fieldArray addObject:str];
                break;
            }
        }
    }
    self.foodDetailArray = fieldArray;
    
    [self.tableview reloadData];
}

- (void)didRequestGoodDetailFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

@end
