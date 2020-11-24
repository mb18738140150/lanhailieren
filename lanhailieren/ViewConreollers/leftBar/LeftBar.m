//
//  LeftBar.m
//  lanhailieren
//
//  Created by aaa on 2020/3/5.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "LeftBar.h"
#import "LeftBarTableViewCell.h"
#define kLeftBarCellID @"LeftBarTableViewCellid"

@interface LeftBar()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView * tableview;
@property (nonatomic, strong)NSMutableArray * dataSource;

@end

@implementation LeftBar

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareUI];
    }
    return self;
}

- (void)prepareUI
{
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccessClick:) name:kNotificationOfLoginSuccess object:nil];
    
    self.backgroundColor = UIColorFromRGB(0xffffff);
    self.seperateLine = [[UIView alloc]initWithFrame:CGRectMake(self.hd_width - 1, 0, 1, self.hd_height)];
    self.seperateLine.backgroundColor = UIColorFromRGB(0xc9c9c9);
    [self addSubview:self.seperateLine];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.hd_width - 1, self.hd_height) style:UITableViewStylePlain];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[LeftBarTableViewCell class] forCellReuseIdentifier:kLeftBarCellID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableview];
}

- (void)loginSuccessClick:(NSNotification *)notification
{
    NSDictionary * info = [[UserManager sharedManager] getUserInfos];
    NSString * imageStr = [NSString stringWithFormat:@"%@%@", kRootImageUrl,[info objectForKey:kUserHeaderImageUrl]];
    [self.dataSource replaceObjectAtIndex:0 withObject:@{@"image":imageStr,@"title":[info objectForKey:kUserName],@"image_select":@""}];
    
}

- (void)loadData
{
    NSDictionary * userInfo = @{@"image":@"placeholdImage",@"title":@"揽海猎人",@"image_select":@""};
    NSDictionary  * orderFoodInfo = @{@"image":@"ic_left_ordering",@"title":@"点餐",@"image_select":@"ic_left_ordering"};
    NSDictionary  * shoppingInfo = @{@"image":@"ic_left_car",@"title":@"购物车",@"image_select":@"ic_left_car_active"};
    NSDictionary  * orderListInfo = @{@"image":@"ic_left_order",@"title":@"订单",@"image_select":@"ic_left_order_active"};
    NSDictionary  * mainInfo = @{@"image":@"ic_left_my",@"title":@"我的",@"image_select":@"ic_left_my_active"};
    [self.dataSource addObject:userInfo];
    [self.dataSource addObject:orderFoodInfo];
    [self.dataSource addObject:shoppingInfo];
    [self.dataSource addObject:orderListInfo];
    [self.dataSource addObject:mainInfo];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LeftBarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kLeftBarCellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [cell refreshUserInfoWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    }else
    {
        [cell refreshWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    }
    
    if (indexPath.row == 2) {
        // 刷新购物车数量
        [cell resetShoppingCar];
    }
    
    // 当前选中图标
    if ([SoftManager shareSoftManager].currentIndexPath.row == indexPath.row) {
        [cell refreshSelectWithInfo:[self.dataSource objectAtIndex:indexPath.row]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SoftManager shareSoftManager].currentIndexPath = indexPath;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationOfLeftBarClick object:indexPath];
}

- (void)refreshTableView
{
    [self.tableview reloadData];
}

@end
