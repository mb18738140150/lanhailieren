//
//  OrderListViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/10.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "OrderListViewController.h"
#import "EScrollPageView.h"
#import "ShoppingCarListTableViewCell.h"
#define kShoppingCarListTableViewCellID @"ShoppingCarListTableViewCellID"
#import "OrderStateOperationView.h"
#import "OrderDetailViewController.h"

@interface OrderListViewController ()<UserModule_OrderListProtocol,UserModule_CancelOrderProtocol>

@property(nonatomic,retain)EScrollPageView *pageView;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, assign)float leftBarWidth;
@property (nonatomic, strong)NSMutableArray * dataSource;

@property (nonatomic, strong)NSArray * viewArray;

@property (nonatomic, assign)NSInteger currentIndex;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@property (nonatomic, assign)int page_index_all;
@property (nonatomic, assign)int page_index_nop_a_y;
@property (nonatomic, assign)int page_index_delivery;
@property (nonatomic, assign)int page_index_recieve;
@property (nonatomic, assign)int page_index_complate;

@property (nonatomic, strong)NSMutableArray * dataArray_all;
@property (nonatomic, strong)NSMutableArray * dataArray_nop_a_y;
@property (nonatomic, strong)NSMutableArray * dataArray_delivery;
@property (nonatomic, strong)NSMutableArray * dataArray_recieve;
@property (nonatomic, strong)NSMutableArray * dataArray_complate;

@end

@implementation OrderListViewController
- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)dataArray_all
{
    if (!_dataArray_all) {
        _dataArray_all = [NSMutableArray array];
    }
    return _dataArray_all;
}
- (NSMutableArray *)dataArray_nop_a_y
{
    if (!_dataArray_nop_a_y) {
        _dataArray_nop_a_y = [NSMutableArray array];
    }
    return _dataArray_nop_a_y;
}
- (NSMutableArray *)dataArray_delivery
{
    if (!_dataArray_delivery) {
        _dataArray_delivery = [NSMutableArray array];
    }
    return _dataArray_delivery;
}
- (NSMutableArray *)dataArray_recieve
{
    if (!_dataArray_recieve) {
        _dataArray_recieve = [NSMutableArray array];
    }
    return _dataArray_recieve;
}
- (NSMutableArray *)dataArray_complate
{
    if (!_dataArray_complate) {
        _dataArray_complate = [NSMutableArray array];
    }
    return _dataArray_complate;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderOperation:) name:@"orderOperationNotify" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderStateSelect:) name:kNotificationOfOrderStateSelect object:nil];
    
    self.page_size = 10;
    self.page_index = 1;
    self.page_index_all = 1;
    self.page_index_nop_a_y = 1;
    self.page_index_recieve = 1;
    self.page_index_complate = 1;
    self.page_index_delivery = 1;
    
    
    [self navigationViewSetup];
//    self.view.backgroundColor = [UIColor redColor];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
    
    for (int i = 0; i < self.viewArray.count; i++) {
        Test1ItemView * view = [self.viewArray objectAtIndex:i];
        view.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
        view.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
        
    }
    
    __weak typeof(self)weakSelf = self;
    self.pageView.currentIndexBlock = ^(NSInteger index) {
        NSLog(@"currentIndex - - %d", index);
        weakSelf.currentIndex = index;
    };
}

- (void)loadData
{
    [self startRequest];
}

#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    switch (self.currentIndex) {
        case 0:
        {
            self.page_index_all = 1;
            self.page_index = self.page_index_all;
        }
            break;
        case 1:
        {
            self.page_index_nop_a_y = 1;
            self.page_index = self.page_index_nop_a_y;
        }
            break;
        case 2:
        {
            self.page_index_delivery = 1;
            self.page_index = self.page_index_delivery;
        }
            break;
        case 3:
        {
            self.page_index_recieve = 1;
            self.page_index = self.page_index_recieve;
        }
            break;
        case 4:
        {
            self.page_index_complate = 1;
            self.page_index = self.page_index_complate;
        }
            break;
            
        default:
            break;
    }
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    switch (self.currentIndex) {
        case 0:
        {
            self.page_index_all++;
            self.page_index = self.page_index_all;
        }
            break;
        case 1:
        {
            self.page_index_nop_a_y++;
            self.page_index = self.page_index_nop_a_y;
        }
            break;
        case 2:
        {
            self.page_index_delivery++;
            self.page_index = self.page_index_delivery;
        }
            break;
        case 3:
        {
            self.page_index_recieve++;
            self.page_index = self.page_index_recieve;
        }
            break;
        case 4:
        {
            self.page_index_complate++;
            self.page_index = self.page_index_complate;
        }
            break;
            
        default:
            break;
    }
    [self startRequest];
}
- (void)startRequest
{
    [SVProgressHUD show];
    [[UserManager sharedManager] didRequestOrderListWithCourseInfo:@{@"command":@15,@"order_type":@1,@"order_status":@(self.currentIndex),@"page_size":@(self.page_size),@"page_index":@(self.page_index)} withNotifiedObject:self];
}

- (void)didRequestOrderListSuccessed
{
    [SVProgressHUD dismiss];
    Test1ItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    
    switch (self.currentIndex) {
        case 0:
        {
            if (self.page_index_all == 1) {
                [self.dataArray_all  removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                
                [self.dataArray_all addObject:mInfo];
            }
            if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataArray_all.count) {
                [view.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [view.tableView.mj_footer endRefreshing];
            }
            
            view.dataSource = self.dataArray_all;
        }
        case 1:
        {
            if (self.page_index_nop_a_y == 1) {
                [self.dataArray_nop_a_y  removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                
                [self.dataArray_nop_a_y addObject:mInfo];
            }
            if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataArray_nop_a_y.count) {
                [view.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [view.tableView.mj_footer endRefreshing];
            }
            
            view.dataSource = self.dataArray_nop_a_y;
        }
            break;
        case 2:
        {
            if (self.page_index_delivery == 1) {
                [self.dataArray_delivery  removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                
                [self.dataArray_delivery addObject:mInfo];
            }
            if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataArray_delivery.count) {
                [view.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [view.tableView.mj_footer endRefreshing];
            }
            
            view.dataSource = self.dataArray_delivery;
        }
            break;
        case 3:
        {
            if (self.page_index_recieve == 1) {
                [self.dataArray_recieve  removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                
                [self.dataArray_recieve addObject:mInfo];
            }
            if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataArray_recieve.count) {
                [view.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [view.tableView.mj_footer endRefreshing];
            }
            
            view.dataSource = self.dataArray_recieve;
        }
            break;
        case 4:
        {
            if (self.page_index_complate == 1) {
                [self.dataArray_complate  removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getMyOrderList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                
                [self.dataArray_complate addObject:mInfo];
            }
            if ([[UserManager sharedManager] getMyOrderListTotalCount] <= self.dataArray_complate.count) {
                [view.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [view.tableView.mj_footer endRefreshing];
            }
            
            view.dataSource = self.dataArray_complate;
        }
            break;
            
        default:
            break;
    }
    
    [view.tableView reloadData];
    
}

- (void)didRequestOrderListFailed:(NSString *)failedInfo
{
    if(self.viewArray.count == 0)
    {
        return;
    }
    Test1ItemView * view = [self.viewArray objectAtIndex:self.currentIndex];
    [view.tableView.mj_header endRefreshing];
    [view.tableView.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"订单列表";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = kCommonNavigationBarColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kCommonMainTextColor_50};
    TeamHitBarButtonItem * leftBarItem = [TeamHitBarButtonItem leftButtonWithImage:[UIImage imageNamed:@"public-返回"] title:@""];
    [leftBarItem addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftBarItem];
}

- (void)backAction:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)refreshUI_iPad
{
    self.leftBar = [[LeftBar alloc]initWithFrame:CGRectMake(0, 0, 53, kScreenHeight - 64)];
    [self.view addSubview:self.leftBar];
    self.leftBarWidth = 53;
    [self pageView];
}

- (void)refreshUI_iPhone
{
    self.leftBarWidth = 0;
    [self pageView];
    
}

- (EScrollPageView *)pageView{
    if (_pageView == nil) {
        CGFloat statusBarH = ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0);
        //每一项的view子类需要继承EScrollPageItemBaseView实现相关界面
        EScrollPageItemBaseView *v1 = [[Test1ItemView alloc] initWithPageTitle:@"全部"];
        EScrollPageItemBaseView *v2 = [[Test1ItemView alloc] initWithPageTitle:@"待付款"];
        EScrollPageItemBaseView *v3 = [[Test1ItemView alloc] initWithPageTitle:@"待发货"];
        EScrollPageItemBaseView *v4 = [[Test1ItemView alloc] initWithPageTitle:@"待收货"];
        EScrollPageItemBaseView *v5 = [[Test1ItemView alloc] initWithPageTitle:@"已完成"];
        NSArray *vs = @[v1,v2,v3,v4,v5];
        EScrollPageParam *param = [[EScrollPageParam alloc] init];
        self.viewArray = vs;
        if(vs.count == 0)
        {
            return nil;
        }
        //头部高度
        param.headerHeight = 50;
        //默认第3个
        param.segmentParam.startIndex = 0;
        //排列类型
        param.segmentParam.type = EPageContentBetween;
        //每个宽度，在type == EPageContentLeft，生效
        param.segmentParam.itemWidth = 60;
        //底部线颜色
        param.segmentParam.lineColor = kMainRedColor;
        //背景颜色
        param.segmentParam.bgColor = 0xffffff;
        //正常字体颜色
        param.segmentParam.textColor = 0x000000;
        //选中的颜色
        param.segmentParam.textSelectedColor = 0x37a2f5;
        
        _pageView = [[EScrollPageView alloc] initWithFrame:CGRectMake(self.leftBarWidth, 0, self.view.frame.size.width - self.leftBarWidth, [UIScreen mainScreen].bounds.size.height-statusBarH) dataViews:vs setParam:param];
        [self.view addSubview:_pageView];
    }
    return _pageView;
}


- (void)orderOperation:(NSNotification *)notification
{
    NSDictionary * info = notification.object;
    OrderOpreation state = [[info objectForKey:@"OrderOpreation"] integerValue];
    NSInteger section = [[info objectForKey:@"section"] intValue];
    
    NSDictionary * currentOrderInfo ;
    __weak typeof(self)weakSelf = self;
    switch (self.currentIndex) {
        case 0:
            currentOrderInfo = [self.dataArray_all objectAtIndex:section];
            break;
        case 1:
            currentOrderInfo = [self.dataArray_nop_a_y objectAtIndex:section];
            break;
        case 2:
            currentOrderInfo = [self.dataArray_delivery objectAtIndex:section];
            break;
        case 3:
            currentOrderInfo = [self.dataArray_recieve objectAtIndex:section];
            break;
        case 4:
            currentOrderInfo = [self.dataArray_complate objectAtIndex:section];
            break;
            
        default:
            break;
    }
    
    if (state == OrderOpreation_orderDetail) {
        OrderDetailViewController * vc = [[OrderDetailViewController alloc]init];
        
        vc.infoDic = currentOrderInfo;
        vc.cancelOrderSuccessBlock = ^{
            [weakSelf doResetQuestionRequest];
        };
        
        [self.navigationController pushViewController:vc animated:YES];
    }else if (state == OrderOpreation_cancelOrder){
        [SVProgressHUD show];
        [[UserManager sharedManager] didRequestCancelOrderWithCourseInfo:@{@"command":@16,@"id":[currentOrderInfo objectForKey:@"id"]} withNotifiedObject:self];
    }
    
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
    [self doResetQuestionRequest];
}


- (void)orderStateSelect:(NSNotification *)notification
{
    NSDictionary * info = notification.object;
    int index = [[info objectForKey:@"orderState"] intValue];
    [self.pageView scrollToIndex:index];
}

@end


@interface Test1ItemView()

@end

@implementation Test1ItemView

- (void)didAppeared{
    [self tableView];
}
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        [_tableView registerClass:[ShoppingCarListTableViewCell class] forCellReuseIdentifier:kShoppingCarListTableViewCellID];
        
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCarListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kShoppingCarListTableViewCellID forIndexPath:indexPath];
    
    NSDictionary * info = [[[self.dataSource objectAtIndex:indexPath.section] objectForKey:@"order_goods"] objectAtIndex:indexPath.row];
    
    NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
    [mInfo setObject:[info objectForKey:@"quantity"] forKey:@"count"];
    [mInfo setObject:[info objectForKey:@"real_price"] forKey:@"price"];
    [mInfo setObject:[info objectForKey:@"spec_text"] forKey:@"tip"];
    [mInfo setObject:[info objectForKey:@"goods_title"] forKey:@"title"];
    [mInfo setObject:[NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:@"img_url"]] forKey:@"image"];
    
    [cell refreshOrderCellWith:mInfo];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.dataSource objectAtIndex:section] objectForKey:@"order_goods"] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (void)getOrderStatus
{
    // "status":0,//(订单状态1生成订单,2确认订单,3完成订单,4取消订单,5作废订单)
//    "express_status":1,  //1未发货 2已发货
//    "p_a_yment_status" = 2; // 1.未支_付 2.已支_付
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, 35)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIView * topSeperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, 4)];
    topSeperateLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [headView addSubview:topSeperateLine];
    
    UIView * bottomSeperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, headView.hd_height - 1, self.hd_width, 1)];
    bottomSeperateLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [headView addSubview:bottomSeperateLine];
    
    NSDictionary * info = [self.dataSource objectAtIndex:section];
    
    UILabel * orderIDLB = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 200, 15)];
    orderIDLB.textColor = UIColorFromRGB(0x000000);
    orderIDLB.backgroundColor = [UIColor whiteColor];
    orderIDLB.text = [NSString stringWithFormat:@"订单号：%@", [info objectForKey:@"order_no"]];
    orderIDLB.font = kMainFont_12;
    [headView addSubview:orderIDLB];
    
    UILabel * orderStateLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 100, 12, 85, 15)];
    orderStateLB.textColor = kMainRedColor;
    orderStateLB.backgroundColor = [UIColor whiteColor];
    orderStateLB.textAlignment = NSTextAlignmentRight;
    switch ([self getOrderState:info]) {
        case OrderState_nop_a_y:
            orderStateLB.text = @"未付款";
            break;
        case OrderState_delivery:
            orderStateLB.text = @"待收货";
            break;
        case OrderState_no_delivery:
            orderStateLB.text = @"待发货";
            break;
        case OrderState_complate:
            orderStateLB.text = @"已完成";
            break;
        case OrderState_cancel:
            orderStateLB.text = @"已取消";
            break;
        case OrderState_void:
            orderStateLB.text = @"已作废";
            break;
            
        default:
            break;
    }
    
    orderStateLB.font = kMainFont_12;
    [headView addSubview:orderStateLB];
    
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width, 85)];
    footView.backgroundColor = [UIColor whiteColor];
    
    UIView * topSeperateLine = [[UIView alloc]initWithFrame:CGRectMake(0, 34, self.hd_width, 1)];
    topSeperateLine.backgroundColor = UIColorFromRGB(0xf2f2f2);
    [footView addSubview:topSeperateLine];
    
    NSDictionary * info = [self.dataSource objectAtIndex:section];
    
    UILabel * priceLB = [[UILabel alloc]initWithFrame:CGRectMake(self.hd_width - 120, 12, 100, 15)];
    priceLB.textColor = UIColorFromRGB(0x000000);
    priceLB.backgroundColor = [UIColor whiteColor];
    priceLB.textAlignment = NSTextAlignmentRight;
    priceLB.text = [NSString stringWithFormat:@"总金额：￥%@", [info objectForKey:@"order_amount"]];
    priceLB.font = kMainFont_12;
    [footView addSubview:priceLB];
    
    OrderStateOperationView * operationView = [[OrderStateOperationView alloc]initWithFrame:CGRectMake(0, 35, self.hd_width, 50)];
    operationView.orderState = [self getOrderState:info];
    operationView.orderOperationBlock = ^(OrderOpreation orderOperation) {
        ;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderOperationNotify" object:@{@"OrderOpreation":@(orderOperation),@"section":@(section)}];
    };
    [footView addSubview:operationView];
    return footView;
}

/*
 p_a_yment_status 1、未付款 2、已付款
 express_status 1、未发货 2、已发货
 status (订单状态1生成订单,2确认订单,3完成订单,4取消订单,5作废订单)
 
 */

- (OrderState)getOrderState:(NSDictionary *)info
{
    int p_a_yment_status = [[info objectForKey:@"p_a_yment_status"] intValue];
    int express_status = [[info objectForKey:@"express_status"] intValue];
    int status = [[info objectForKey:@"status"] intValue];
    
    if (status == 3) {
        return OrderState_complate;// 已完成
    }else if (status == 4){
        return OrderState_cancel;// 已取消
    }else if (status == 5)
    {
        return OrderState_void;// 作废
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

