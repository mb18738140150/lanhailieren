//
//  FoodListViewController.m
//  lanhailieren
//
//  Created by aaa on 2020/3/13.
//  Copyright © 2020 mcb. All rights reserved.
//

#import "FoodListViewController.h"

#import "JingpinCollectionViewCell.h"
#define kJingpinCollectionViewCellID @"JingpinCollectionViewCellID"
#import "FoodIntroduceViewController.h"

@interface FoodListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UserModule_GoodListProtocol>

@property (nonatomic, strong)UICollectionView * collectionview;
@property (nonatomic, strong)LeftBar * leftBar;
@property (nonatomic, strong)UIButton * nomalBtn;
@property (nonatomic, strong)UIButton * saleCountBtn;
@property (nonatomic, strong)UIButton * priceBtn;
@property (nonatomic, assign)int sort;
@property (nonatomic, assign)int page_size;
@property (nonatomic, assign)int page_index;
@property (nonatomic, assign)int page_index_nomal;
@property (nonatomic, assign)int page_index_sale;
@property (nonatomic, assign)int page_index_price;
@property (nonatomic, strong)NSMutableArray * dataArray;
@property (nonatomic, strong)NSMutableArray * dataArray_nomal;
@property (nonatomic, strong)NSMutableArray * dataArray_sale;
@property (nonatomic, strong)NSMutableArray * dataArray_price;

@end

@implementation FoodListViewController
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArray_sale
{
    if (!_dataArray_sale) {
        _dataArray_sale = [NSMutableArray array];
    }
    return _dataArray_sale;
}
        
- (NSMutableArray *)dataArray_nomal
{
    if (!_dataArray_nomal) {
        _dataArray_nomal = [NSMutableArray array];
    }
    return _dataArray_nomal;
}
- (NSMutableArray *)dataArray_price
{
    if (!_dataArray_price) {
        _dataArray_price = [NSMutableArray array];
    }
    return _dataArray_price;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sort = 0;
    self.page_size = 10;
    self.page_index = 1;
    self.page_index_sale = 1;
    self.page_index_price = 1;
    self.page_index_nomal = 1;
    
    [self loadData];
    [self navigationViewSetup];
    if (IS_PAD) {
        [self refreshUI_iPad];
    }else
    {
        [self refreshUI_iPhone];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)loadData
{
    [SVProgressHUD show];
    [self startRequest];
}

- (void)navigationViewSetup
{
    self.navigationItem.title = @"商品列表";
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
    
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(53 + 10, 35, kScreenWidth - 53 - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 35) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[JingpinCollectionViewCell class] forCellWithReuseIdentifier:kJingpinCollectionViewCellID];
    
    
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}

- (void)refreshUI_iPhone
{
    UIView * view = [self topView];
    [self.view addSubview:view];
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 35, kScreenWidth - 20, kScreenHeight - kNavigationBarHeight - kStatusBarHeight - 35) collectionViewLayout:layout];
    self.collectionview.backgroundColor = [UIColor clearColor];
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    [self.collectionview registerClass:[JingpinCollectionViewCell class] forCellWithReuseIdentifier:kJingpinCollectionViewCellID];
    
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(doResetQuestionRequest)];
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(doNextPageQuestionRequest)];
}



- (UIView *)topView
{
    UIView * topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    if (IS_PAD) {
        topView.frame = CGRectMake(53, 0, kScreenWidth - 53, 35);
    }else
    {
        topView.frame = CGRectMake(0, 0, kScreenWidth, 35);
    }
    
    float leftWidth = (topView.hd_width - 270) / 2;
    self.nomalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nomalBtn.frame = CGRectMake(leftWidth, 0, 90, topView.hd_height);
    self.nomalBtn.backgroundColor = [UIColor whiteColor];
    [self.nomalBtn setTitle:@"默认" forState:UIControlStateNormal];
    self.nomalBtn.titleLabel.font = kMainFont;
    [self.nomalBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.nomalBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    [topView addSubview:self.nomalBtn];
    self.nomalBtn.selected = YES;
    
    self.saleCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saleCountBtn.frame = CGRectMake(CGRectGetMaxX(self.nomalBtn.frame), 0, 90, topView.hd_height);
    self.saleCountBtn.backgroundColor = [UIColor whiteColor];
    [self.saleCountBtn setTitle:@"销量" forState:UIControlStateNormal];
    self.saleCountBtn.titleLabel.font = kMainFont;
    [self.saleCountBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.saleCountBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    [topView addSubview:self.saleCountBtn];
    
    self.priceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.priceBtn.frame = CGRectMake(CGRectGetMaxX(self.saleCountBtn.frame), 0, 90, topView.hd_height);
    self.priceBtn.backgroundColor = [UIColor whiteColor];
    [self.priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    self.priceBtn.titleLabel.font = kMainFont;
    [self.priceBtn setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
    [self.priceBtn setTitleColor:kMainRedColor forState:UIControlStateSelected];
    [self.priceBtn setImage:[UIImage imageNamed:@"ic_triangle_bottom_active"] forState:UIControlStateSelected];
    [self.priceBtn setImage:[UIImage imageNamed:@"ic_triangle_bottom"] forState:UIControlStateNormal];
    [self.priceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.priceBtn.imageView.hd_width - 5, 0, self.priceBtn.imageView.hd_width + 5)];
    [self.priceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.priceBtn.titleLabel.hd_width + 5, 0, -self.priceBtn.titleLabel.hd_width - 5)];
    
    [topView addSubview:self.priceBtn];
    
    [self.nomalBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.saleCountBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.priceBtn addTarget:self action:@selector(shaixuanAction:) forControlEvents:UIControlEventTouchUpInside];
    return topView;
}

- (void)shaixuanAction:(UIButton *)button
{
    if ([button isEqual:self.nomalBtn]) {
        self.sort = 1;
        self.nomalBtn.selected = YES;
        self.saleCountBtn.selected = NO;
        self.priceBtn.selected = NO;
        self.page_index = self.page_index_nomal;
    }else if ([button isEqual:self.saleCountBtn])
    {
        self.sort = 2;
        self.nomalBtn.selected = NO;
        self.saleCountBtn.selected = YES;
        self.priceBtn.selected = NO;
        self.page_index = self.page_index_sale;
    }else
    {
        self.sort = 3;
        self.nomalBtn.selected = NO;
        self.saleCountBtn.selected = NO;
        self.priceBtn.selected = YES;
        self.page_index = self.page_index_price;
    }
    [self startRequest];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JingpinCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kJingpinCollectionViewCellID forIndexPath:indexPath];
    [cell refreshUIWithInfo:[self.dataArray objectAtIndex:indexPath.item]];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_PAD) {
        float width = (kScreenWidth - 53 - 60) / 5;
        return CGSizeMake(width, (width) * 0.7 + 85);
    }
    else
    {
        float width = (kScreenWidth - 60) / 2;
        return CGSizeMake(width, (width) * 0.7 + 85);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * foodInfo = [self.dataArray objectAtIndex:indexPath.row];
    FoodIntroduceViewController * vc = [[FoodIntroduceViewController alloc]init];
    vc.good_id = [[foodInfo objectForKey:@"id"] intValue];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - getintegerDetailList
- (void)doResetQuestionRequest
{
    switch (self.sort) {
        case 1:
        {
            self.page_index_nomal = 1;
            self.page_index = self.page_index_nomal;
        }
            break;
        case 2:
        {
            self.page_index_sale = 1;
            self.page_index = self.page_index_sale;
        }
            break;
        case 3:
        {
            self.page_index_price = 1;
            self.page_index = self.page_index_price;
        }
            break;
            
        default:
            break;
    }
    [self startRequest];
}

- (void)doNextPageQuestionRequest
{
    switch (self.sort) {
        case 1:
            {
                self.page_index_nomal++;
                self.page_index = self.page_index_nomal;
            }
            break;
        case 2:
        {
            self.page_index_sale++;
            self.page_index = self.page_index_sale;
        }
            break;
        case 3:
        {
            self.page_index_price++;
            self.page_index = self.page_index_price;
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
    [[UserManager sharedManager] didRequestGoodListWithInfo:@{@"command":@9,@"type":@1,@"categor_id":@(self.categor_id),@"plate":@(self.plate),@"page_size":@(self.page_size),@"page_index":@(self.page_index),@"key":self.key,@"sort":@(self.sort),@"is_hot":@(self.is_hot),@"is_red":@(self.is_red)} withNotifiedObject:self];
}

#pragma mark - goosList request
- (void)didRequestGoodListSuccessed
{
    [SVProgressHUD dismiss];
    [self.collectionview.mj_header endRefreshing];
    
    switch (self.sort) {
        case 1:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_nomal removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getGoodList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
                [self.dataArray_nomal addObject:mInfo];
            }
            if ([[UserManager sharedManager] getGoodListTotalCount] <= self.dataArray_nomal.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            
            self.dataArray = self.dataArray_nomal;
        }
            break;
        case 2:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_sale removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getGoodList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
                [self.dataArray_sale addObject:mInfo];
            }
            
            if ([[UserManager sharedManager] getGoodListTotalCount] <= self.dataArray_sale.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            self.dataArray = self.dataArray_sale;
        }
            break;
        case 3:
        {
            if (self.page_index_nomal == 1) {
                [self.dataArray_price removeAllObjects];
            }
            for (NSDictionary * info in [[UserManager sharedManager] getGoodList]) {
                NSMutableDictionary * mInfo = [[NSMutableDictionary alloc]initWithDictionary:info];
                [mInfo setObject:[info objectForKey:@"sell_price"] forKey:@"price"];
                [self.dataArray_price addObject:mInfo];
            }
            if ([[UserManager sharedManager] getGoodListTotalCount] <= self.dataArray_price.count) {
                [self.collectionview.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                [self.collectionview.mj_footer endRefreshing];
            }
            self.dataArray = self.dataArray_price;
        }
            break;
            
        default:
            break;
    }
    
    [self.collectionview reloadData];
    
}

- (void)didRequestGoodListFailed:(NSString *)failedInfo
{
    [self.collectionview.mj_header endRefreshing];
    [self.collectionview.mj_footer endRefreshing];
    [SVProgressHUD dismiss];
    [SVProgressHUD showErrorWithStatus:failedInfo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
@end
