//
//  OrderDetailViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/12.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "ShoppingCarListTableViewCell.h"
#define kShoppingCarListTableViewCellID @"ShoppingCarListTableViewCellID"
#import "AddressListTableViewCell.h"
#define kAddressListTableViewCellID @"AddressListTableViewCellID"
#import "AddressListViewController.h"
#import "OrderStateOperationView.h"

@interface OrderDetailViewController ()
<UITableViewDelegate,UITableViewDataSource,UserModule_CancelOrderProtocol>

@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, strong)UIView * topView;
@property (nonatomic, strong)UIImageView * orderStateImageView;
@property (nonatomic, strong)UILabel * orderStateLB;
@property (nonatomic, strong)UILabel * tipLB;

@property (nonatomic, strong)UIButton * cancelOrderBtn;
@property (nonatomic, strong)UIButton * orderDetailBtn;
@property (nonatomic, strong)UIButton * buyBtn;
@property (nonatomic, strong)UILabel * orderStateLB_1;

@end

@implementation OrderDetailViewController

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
    self.dataSource =  [self.infoDic objectForKey:@"order_goods"];
    [self.tableview reloadData];
}


- (void)navigationViewSetup
{
    self.navigationItem.title = @"订单详情";
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
    
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(53, 0, kScreenWidth - 53, 64)];
    [self.view addSubview:self.topView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.locations = @[@(0.5)];
    gradient.frame =self.topView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0x269FFF).CGColor,(id)UIColorFromRGB(0x37A2F5).CGColor,(id)UIColorFromRGB(0x65BBFD).CGColor,nil];
    [self.topView.layer insertSublayer:gradient atIndex:0];
    
    self.orderStateLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 60, 15)];
    self.orderStateLB.hd_centerX = self.topView.hd_width / 2;
    self.orderStateLB.font = kMainFont;
    self.orderStateLB.text = @"待付款";
    self.orderStateLB.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.orderStateLB];
    
    self.orderStateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.orderStateLB.hd_x - 30, 20, 25, 25)];
    self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_delivery"];
    [self.topView addSubview:self.orderStateLB];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.orderStateLB.hd_x, CGRectGetMaxY(self.orderStateLB.frame) + 5, 300, 15)];
    self.tipLB.font = kMainFont_12;
    self.tipLB.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.tipLB];
    self.tipLB.text = @"您的订单待付款，快去付款吧";
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(53, 64, kScreenWidth - 53, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 50 - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[ShoppingCarListTableViewCell class] forCellReuseIdentifier:kShoppingCarListTableViewCellID];
    [self.tableview registerClass:[AddressListTableViewCell class] forCellReuseIdentifier:kAddressListTableViewCellID];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    
    [self refreshStateLB];
}

- (void)refreshUI_iPhone
{
    self.topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    [self.view addSubview:self.topView];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    //设置开始和结束位置(设置渐变的方向)
    gradient.startPoint = CGPointMake(0, 0);
    
    gradient.endPoint = CGPointMake(1, 0.5);
    gradient.locations = @[@(0.5)];
    gradient.frame =self.topView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)UIColorFromRGB(0x269FFF).CGColor,(id)UIColorFromRGB(0x37A2F5).CGColor,(id)UIColorFromRGB(0x65BBFD).CGColor,nil];
    [self.topView.layer insertSublayer:gradient atIndex:0];
    
    self.orderStateLB = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, 60, 15)];
    self.orderStateLB.hd_centerX = self.topView.hd_width / 2;
    self.orderStateLB.font = kMainFont;
    self.orderStateLB.text = @"待付款";
    self.orderStateLB.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.orderStateLB];
    
    self.orderStateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.orderStateLB.hd_x - 30, 20, 25, 25)];
    self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_delivery"];
    [self.topView addSubview:self.orderStateImageView];
    
    self.tipLB = [[UILabel alloc]initWithFrame:CGRectMake(self.orderStateLB.hd_x, CGRectGetMaxY(self.orderStateLB.frame) + 5, 300, 15)];
    self.tipLB.font = kMainFont_12;
    self.tipLB.textColor = [UIColor whiteColor];
    [self.topView addSubview:self.tipLB];
    self.tipLB.text = @"您的订单待付款，快去付款吧";
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth , kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 50 - 64) style:UITableViewStylePlain];
    [self.tableview registerClass:[ShoppingCarListTableViewCell class] forCellReuseIdentifier:kShoppingCarListTableViewCellID];
    [self.tableview registerClass:[AddressListTableViewCell class] forCellReuseIdentifier:kAddressListTableViewCellID];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor = UIColorFromRGB(0xf5f5f5);
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    [self refreshStateLB];
}

- (void)refreshStateLB
{
    switch ([self getOrderState:self.infoDic]) {
        case OrderState_nop_a_y:
            self.orderStateLB.text = @"待付款";
            self.tipLB.text = @"您的订单待付款，快去付款吧";
            self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_p_a_yment"];
            break;
        case OrderState_delivery:
            self.orderStateLB.text = @"待收货";
            self.tipLB.text = @"您的订单正在运输中";
            self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_delivery"];
            break;
        case OrderState_no_delivery:
            self.orderStateLB.text = @"待发货";
            self.tipLB.text = @"您的订单已揽收";
            self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_goods"];
            break;
        case OrderState_complate:
            self.orderStateLB.text = @"已完成";
            self.tipLB.text = @"您的订单已完成";
            self.orderStateImageView.image = [UIImage imageNamed:@"ic_details_complete"];
            break;
        case OrderState_cancel:
            self.orderStateLB.text = @"已取消";
            self.tipLB.text = @"您的订单已取消";
            break;
        case OrderState_void:
            self.orderStateLB.text = @"已作废";
            self.tipLB.text = @"您的订单已作废";
            break;
        default:
            break;
    }
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
        AddressListTableViewCell * headCell = [tableView dequeueReusableCellWithIdentifier:kAddressListTableViewCellID forIndexPath:indexPath];
//        headCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [headCell refreshUIWithInfo:self.infoDic];
        [headCell hideEditBtn];
        return headCell;
    }
    
    
    ShoppingCarListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kShoppingCarListTableViewCellID forIndexPath:indexPath];
    
    NSDictionary * info = [self.dataSource objectAtIndex:indexPath.row];
    
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
    [mInfo setObject:[info objectForKey:@"quantity"] forKey:@"count"];
    [mInfo setObject:[info objectForKey:@"real_price"] forKey:@"price"];
    [mInfo setObject:[info objectForKey:@"spec_text"] forKey:@"tip"];
    [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]] forKey:@"image"];
    
    [cell refreshOrderCellWith:mInfo];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    }
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        AddressListViewController * addressVC = [[AddressListViewController alloc]init];
//        [self.navigationController pushViewController:addressVC animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 3)];
    headView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 120)];
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.hd_width, 78)];
    backView.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:backView];
    
    UILabel * orderIDLB = [[UILabel alloc]initWithFrame:CGRectMake(13, 9, 200, 20)];
    orderIDLB.text = [NSString stringWithFormat:@"订单号：%@", [self.infoDic objectForKey:@"order_no"]];
    orderIDLB.font = kMainFont_12;
    orderIDLB.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:orderIDLB];
    
    UILabel * timeLB = [[UILabel alloc]initWithFrame:CGRectMake(13, 29, 200, 20)];
    timeLB.text = [NSString stringWithFormat:@"下单时间：%@", [self.infoDic objectForKey:@"add_time"]];
    timeLB.font = kMainFont_12;
    timeLB.backgroundColor = [UIColor whiteColor];
    [footerView addSubview:timeLB];
    
    UILabel * orderStateLB = [[UILabel alloc]initWithFrame:CGRectMake(13, 49, 200, 20)];
    orderStateLB.attributedText = [self getOrderStateStr:@"订单状态：待付款"];
    orderStateLB.font = kMainFont_12;
    orderStateLB.backgroundColor = [UIColor whiteColor];
    self.orderStateLB_1 = orderStateLB;
    [footerView addSubview:orderStateLB];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buyBtn.frame = CGRectMake(tableView.hd_width - 100, CGRectGetMaxY(backView.frame) + 15, 85, 26);
    self.buyBtn.layer.cornerRadius = self.buyBtn.hd_height / 2;
    self.buyBtn.layer.masksToBounds = YES;
    self.buyBtn.backgroundColor = kMainRedColor;
    [self.buyBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [self.buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buyBtn.titleLabel.font = kMainFont_12;
    [footerView addSubview:self.buyBtn];
    
    
    self.cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelOrderBtn.frame = CGRectMake(self.buyBtn.hd_x - 100, self.buyBtn.hd_y, 85, 26);
    self.cancelOrderBtn.layer.cornerRadius = self.buyBtn.hd_height / 2;
    self.cancelOrderBtn.layer.masksToBounds = YES;
    self.cancelOrderBtn.layer.borderWidth = 1;
    self.cancelOrderBtn.layer.borderColor = UIColorFromRGB(0x696969).CGColor;
    self.cancelOrderBtn.backgroundColor = [UIColor whiteColor];
    [self.cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [self.cancelOrderBtn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    self.cancelOrderBtn.titleLabel.font = kMainFont_12;
    [footerView addSubview:self.cancelOrderBtn];
    
    switch ([self getOrderState:self.infoDic]) {
        case OrderState_nop_a_y:
        {
            self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：待付款"];
            [self.buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
            [self.cancelOrderBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderState_delivery:
        {
            self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：待收货"];
            [self.buyBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.buyBtn addTarget:self action:@selector(lookDeliveryAction) forControlEvents:UIControlEventTouchUpInside];
            [self.cancelOrderBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        }
        case OrderState_no_delivery:
        {
            self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：待发货"];
            [self.buyBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.buyBtn addTarget:self action:@selector(lookDeliveryAction) forControlEvents:UIControlEventTouchUpInside];
            [self.cancelOrderBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        }
            break;
        case OrderState_complate:
            {
                self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：已完成"];
                [self.buyBtn removeFromSuperview];
                [self.cancelOrderBtn removeFromSuperview];
            }
//            break;
        case OrderState_cancel:
        {
            self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：已取消"];
            [self.buyBtn removeFromSuperview];
            [self.cancelOrderBtn removeFromSuperview];
        }
            break;
        case OrderState_void:
        {
            self.orderStateLB_1.attributedText = [self getOrderStateStr:@"订单状态：已作废"];
            [self.buyBtn removeFromSuperview];
            [self.cancelOrderBtn removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
    
    
    return footerView;
}

- (NSMutableAttributedString *)getOrderStateStr:(NSString *)str
{
    NSString * stateStr = str;
    NSMutableAttributedString *stateStr_m = [[NSMutableAttributedString alloc]initWithString:stateStr];
    [stateStr_m addAttribute:NSForegroundColorAttributeName value:kMainRedColor range:NSMakeRange(5, stateStr.length - 5)];
    return stateStr_m;
}

- (void)buyAction
{
    
}

- (void)cancelAction
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestCancelOrderWithCourseInfo:@{@"command":@16,@"id":[self.infoDic objectForKey:@"id"]} withNotifiedObject:self];
}

- (void)lookDeliveryAction
{
    
}


- (void)didRequestCancelOrderFailed:(NSString *)failedInfo
{
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)didRequestCancelOrderSuccessed
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
    if (self.cancelOrderSuccessBlock) {
        self.cancelOrderSuccessBlock();
    }
}


- (OrderState)getOrderState:(NSDictionary *)info
{
    int p_a_yment_status = [[info objectForKey:@"p_a_yment_status"] intValue];
    int express_status = [[info objectForKey:@"express_status"] intValue];
    int status = [[info objectForKey:@"status"] intValue];
    
    if (status == 3) {
        return OrderState_complate;// 已完成
    }else if (status == 4){
        return OrderState_cancel;
    }else if (status == 5)
    {
        return OrderState_void;
    }
    
    if (p_a_yment_status == 1) {
        return OrderState_nop_a_y;// 未付款
    }
    if (p_a_yment_status == 2) {
        if (express_status == 1) {
            return OrderState_no_delivery; // 已付款 未发货
        }
        return OrderState_delivery;// 已付款 已发货
    }
    
    return OrderState_nop_a_y;
}


@end
